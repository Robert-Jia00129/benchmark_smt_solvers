import itertools
import os.path

import z3  # if this fails, run 'python -m pip install z3-solver'
import numpy as np
import random
from copy import deepcopy
import time
from typing import List
from pathlib import Path


# z3.set_param('parallel.enable',True)
# child class to write push and pop to SMT2 file
class Solver2SMT(z3.Solver):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._start_recording = False
        self._history = []

    def add(self, *args, **kwargs):
        if self._start_recording:
            for arg in args:
                self._history.append(("add", str(arg.sexpr())))
        super().add(*args, **kwargs)

    def push(self, *args, **kwargs):
        if self._start_recording:
            self._history.append(("push", None))
        super().push(*args, **kwargs)

    def pop(self, *args, **kwargs):
        if self._start_recording:
            self._history.append(("pop", None))
        super().pop(*args, **kwargs)

    def check(self, *args, **kwargs):
        if self._start_recording:
            self._history.append(("check", args))
            result = super().check(*args, **kwargs)
            self._history.append(("result", result))
            return result
        else:
            return super().check(*args, **kwargs)

    def start_recording(self):
        self._start_recording = True
        initial_state = self.to_smt2()
        # Remove the last "(check-sat)" from the initial state
        initial_state = initial_state.rsplit("(check-sat)", 1)[0]
        self._history.append(("initial_state", initial_state))

    def generate_smtlib(self, filename):
        with open(filename, "w") as file:
            file.write(f"(set-logic QF_LIA)")
            for operation in self._history:
                op, args = operation
                if op == "initial_state":
                    file.write(args)
                elif op == "add":
                    file.write(f"(assert {args})\n")
                elif op in ["push", "pop"]:
                    file.write(f"({op} 1)\n")
                elif op == "check":
                    file.write(f"(check-sat)\n")
                elif op == "result":
                    file.write(f"; Result: {args}\n")

class Sudoku:
    _grid = None # Creating an empty matrix with None everywhere
    _solver = None # The solver
    _valid_charset = set([int(x) for x in range(0, 10)]) # Set of valid input chars that is could be placed in a position
    _classic = True
    _distinct = True
    _per_col = True
    _no_num = True
    _prefill = False
    _hard_smt_logPath = None
    _hard_sudoku_logPath = None

    def __init__(self, sudoku_array: List[int], classic: bool, distinct: bool, per_col: bool, no_num: bool,
                 prefill: bool, seed, hard_smt_logPath="", hard_sudoku_logPath="", verbose=False, distinct_digits=True
                 ):
        """
        Only write a logFile when a path is provided
        Type hint for List[int] might not work
        :param sudoku_array:
        :param classic: classic or argyle sudoku
        :param distinct: encoding constraints using z3.Distinct() or z3.PbEq()
        :param per_col: start filling/removing the grid with number in per_col order:
            (start with the first index (0,0) and end at index (8,8))
            or not per_col order:
            (start filling the grid with number order. first filling in all the 1s, 2s, 3s...
            and end with the number 9)
        :param no_num: Encode the numbers with numberic representation (1-9) or
                boolean representation (val1, val2... val9): val2==True indicates the number is 2 at this index
        :param prefill: prefill the grid:
            per_col case: prefill the first row with 1-9 in random order
            not per_col case: prefill all the 1s with random numbers
        :param hard_smt_logPath:
        """
        # a 1-D sudoku_array
        self._solver = Solver2SMT()
        self._timeout = 5000
        self._incTimeOut = self._timeout
        self._solver.set("timeout", self._timeout)
        # self._solver.from_file("fileName")
        self._classic = classic
        self._distinct = distinct
        self._no_num = no_num
        self._per_col = per_col
        self._nums = [[0 for _ in range(9)] for _ in range(9)]
        self._hard_smt_logPath = hard_smt_logPath
        self._hard_sudoku_logPath = hard_sudoku_logPath
        self._prefill = prefill
        self._penalty = 0
        self.condition_tpl = (self._classic, self._distinct, self._per_col, self._no_num, self._prefill)
        self._verbose = verbose
        self._bool_timeout = False
        self._seed = seed
        self._store_global = False
        self._global_solver = z3.Solver()
        self._distinctdigits = distinct_digits
        # self._solver_operations = []
        if seed == 0:
            print("WARNING: NO random seed was set for solver class. "
                  "This would cause experiments to be unreliable when compared in across constraints."
                  "If this is intentional, please ignore .")
        random.seed(seed)
        self._solver_operations = []  # Initialize operation logging

        # Create variables
        if self._distinctdigits:
            self._constants = [z3.Bool(f"C{i}") for i in range(1, 10)]
            self._grid = [[[z3.Bool(f"cell_{r+1}_{c+1}_C{num+1}") for num in range(9)] for c in range(9)] for r in range(9)]

        else:
            self._constants = [i for i in range(10)]
            if not no_num:
                self._grid = [[z3.Int(f"cell_{r+1}_{c+1}") for c in range(9)] for r in range(9)]
            else:
                self._grid = [[[z3.Bool(f"cell_{r+1}_{c+1}_{num+1}") for num in range(9)]
                               for c in range(9)] for r in range(9)]

        assert (len(sudoku_array) == 81), f"Invalid sudoku string provided! length:{len(sudoku_array)}"
        self.load_numbers(sudoku_array[:81])


    def generate_smt2_file(self, filename):
        self._solver.generate_smtlib(filename)

    def load_numbers(self, sudoku_array):
        """
        assign each number in sudoku_array to grid
        :param sudoku_array: np.matrix
        :return: None
        """
        for r in range(9):
            for c in range(9):
                x = sudoku_array[r * 9 + c]
                assert (x in self._valid_charset), "Invalid sudoku string provided! (invalid character \'{}\')".format(
                    x)
                if x != 0:
                    self._nums[r][c] = int(x)

    def load_constraints(self):
        digits = [self._grid[r][c] for c in range(9) for r in range(9)]  # digit
        rows = [self._grid[r] for r in range(9)]  # row 1-9
        cols = [[self._grid[r][c] for r in range(9)] for c in range(9)]  # col 1-9
        offset = list(itertools.product(range(0, 3), range(0, 3)))  # box 1st -9th
        boxes = []
        # Load existing numbers
        for r in range(9):
            for c in range(9):
                if self._nums[r][c] != 0:
                    if self._no_num:
                        self._solver.add(self._grid[r][c][self._nums[r][c] - 1])
                    else:
                        self._solver.add(self._grid[r][c] == int(self._nums[r][c]))

        for r in range(0, 9, 3):
            for c in range(0, 9, 3):
                boxes.append([self._grid[r + dy][c + dx] for dy, dx in offset])

        if self._no_num:
            # pbeq ONLY, no_num 3D grid
            # TODO
            # [self._solver.add(z3.PbEq([(self._grid[i][j][k], 1) for k in range(9)], 1),const("no_num")==True)
            #  for i in range(9) for j in range(9)]  # digit
            [self._solver.add(z3.PbEq([(self._grid[i][j][k], 1) for k in range(9)], 1))
             for i in range(9) for j in range(9)]  # digit
            [self._solver.add(z3.PbEq([(self._grid[k][i][j], 1) for k in range(9)], 1))
             for i in range(9) for j in range(9)]  # Col distinct
            [self._solver.add(z3.PbEq([(self._grid[j][k][i], 1) for k in range(9)], 1))
             for i in range(9) for j in range(9)]  # Row distinct
            [self._solver.add(z3.PbEq([(box[k][j], 1) for k in range(9)], 1))
             for j in range(9) for box in boxes]  # box
        else:  # numbers  2D grid
            # Restrict digits in between 1-9
            for digit in digits:
                # TODO this, and we could maybe also improve this with PBEQ
                # if self._distinctdigits:
                #     self._solver.add(self._solver.Or(digit == 1, digit == 2)...)
                # else:
                    self._solver.add(digit >= 1) # ==1 ==2 ==3 ==4 ....
                    self._solver.add(digit <= 9)  # Digit
            if self._distinct:  # distinct, numbers 2D grid
                [self._solver.add(z3.Distinct(row)) for row in rows]  # rows
                [self._solver.add(z3.Distinct(row)) for row in cols]  # cols
                [self._solver.add(z3.Distinct(row)) for row in boxes]  # boxes
            else:  # pbeq, numbers, 2D grid
                [self._solver.add(z3.PbEq([(row[i] == k, 1) for i in range(9)], 1))
                 for k in range(1, 10) for row in rows]
                [self._solver.add(z3.PbEq([(row[i] == k, 1) for i in range(9)], 1))
                 for k in range(1, 10) for row in cols]
                [self._solver.add(z3.PbEq([(row[i] == k, 1) for i in range(9)], 1))
                 for k in range(1, 10) for row in boxes]
        # Argyle-----
        if not self._classic:
            argyle_hints = [[self._grid[r][r + 4] for r in range(4)]  # Major diagonal 1
                , [self._grid[r][r + 1] for r in range(8)]  # ??
                , [self._grid[r + 1][r] for r in range(8)]
                , [self._grid[r + 4][r] for r in range(4)]
                , [self._grid[r][-r - 5] for r in range(4)]
                , [self._grid[r][-r - 2] for r in range(8)]
                , [self._grid[r + 1][-r - 1] for r in range(8)]
                , [self._grid[r + 4][-r - 1] for r in range(4)]
                            ]
            if self._no_num:
                self._solver.add(
                    z3.And([z3.PbLe([(digit[k], 1) for digit in arg], 1) for arg in argyle_hints for k in range(9)]))
                pass
            else:
                if self._distinct:
                    self._solver.add(z3.And([z3.Distinct(arg) for arg in argyle_hints]))
                else:
                    self._solver.add(z3.And(
                        [z3.PbLe([(digit == k, 1) for digit in arg], 1) for arg in argyle_hints for k in range(9)]))

    def new_solver(self):
        """
        Try checking index[i][j] == Tryval with alternative approach
        :param i:
        :param j:
        :param tryVal:
        :return:
        """
        s_new = Sudoku([c for r in self._nums for c in r], self._classic, False,
                       self._per_col, True, self._prefill,seed=4321) # @sj*** Shoud this be random???
        s_new._timeout = 0
        s_new._solver.set("timeout", 0)
        s_new.load_constraints()
        self._penalty += 1
        return s_new

    def check_condition(self, i, j, tryVal):
        start = time.time()
        res = self._solver.check(self._grid[i][j][tryVal - 1] if self._no_num else self._grid[i][j] == int(tryVal))
        end = time.time()
        if self._timeout == 0: return res
        if end - start < (self._timeout - 100) / 1000 and res == z3.unknown:
            raise 'Probably somebody hit ctrl-c, aborting'
        elif self._verbose and end - start > self._timeout / 10000 and res != z3.unknown:
            print('One check took more than 10% of timeout, but completed')
        return res

    def removable(self, i, j, test_num) -> (bool, int):
        """
        Testing one index by one index. How to use push and pop
        to test to whole grid without reloading constraints
        Test if test_num is unique and could be removed
        --Replacement: check_puzzle_solvable function

        :param test_num: 1-9
        :return: (removable: bool, penalty: int)
        """
        self._nums[i][j] = 0
        self.load_constraints()
        condition = self.check_not_removable(i, j, test_num)  # try _nums[i][j] != test_num
        if condition == z3.sat:
            return False, 0
        elif condition == z3.unknown:
            # Try solving with faster method
            condition = self.new_solver().check_not_removable(i, j, test_num)
            if condition == z3.unknown:
                raise f"Timeout happened twice when checking if {i} {j} {test_num} is removable"
            else:
                if self._verbose:
                    print(f'unsolvable problem checking removable was {condition} for ({i},{j}) is {test_num}')
                self.write_to_smt_and_sudoku_file((i, j), test_num, condition)
                return condition != z3.sat, 1
        return True, 0

    def check_not_removable(self, i, j, tryVal):
        res = self._solver.check(
            self._grid[i][j][tryVal - 1] == False if self._no_num else self._grid[i][j] != int(tryVal))
        return res

    def add_constaint(self, i, j, tryVal):
        self._nums[i][j] = int(tryVal)
        if self._no_num:
            constraint = self._grid[i][j][tryVal - 1]
        else:
            constraint = self._grid[i][j] == tryVal
        self._solver.add(constraint)
        self._solver_operations.append(("assert", str(constraint)))

    def add_not_equal_constraint(self, i, j, tryVal):
        self._solver.add(self._grid[i][j][tryVal - 1] == False if self._no_num else self._grid[i][j] != int(tryVal))

    def gen_solved_sudoku(self):
        """
        produce a solved FULL sudoku
        --Replacement: solving_sudoku function

        :return: 2D list of a solved FULL sudoku
        """
        self.load_constraints()
        if self._per_col:
            # Fill by index
            for i in range(9):
                # print(f"Filling row {i}")
                if i == 0 and self._prefill:
                    testlst = [k for k in range(1, 10)]
                    random.shuffle(testlst)
                for j in range(9):
                    if self._nums[i][j] != 0:
                        continue
                    if i == 0 and self._prefill:
                        tryVal = testlst.pop()
                        check = z3.sat
                    else:
                        x = [k for k in range(1, 10)]
                        random.shuffle(x)
                        tryVal = x.pop()
                        check = self.check_condition(i, j, tryVal)
                    while check != z3.sat:
                        if check == z3.unknown:
                            s_new = self.new_solver()
                            check = s_new.check_condition(i, j, tryVal)

                            # Record to log path *********
                            if self._hard_smt_logPath:
                                self.write_to_smt_and_sudoku_file((i, j), tryVal, check)
                            else:
                                print("TimeOut and a logPath is not provided")

                            if check == z3.unknown:
                                raise 'Timeout happened twice, don\'t know how to continue!'
                            elif self._verbose:
                                print(f'unsolvable problem was {check} for ({i},{j}) is {tryVal}')
                        else:  # check == z3.unsat
                            assert (check == z3.unsat)
                            if len(x) == 0:
                                print(f'check: {check} {i},{j},{tryVal}')
                                print(f'Current row: {self._nums}')
                                raise 'Tried all values, no luck, check gen_solved_sudoku'
                            tryVal = x.pop()
                            check = self.check_condition(i, j, tryVal)
                    self._nums[i][j] = int(tryVal)
                    if self._no_num:
                        self._solver.add(self._grid[i][j][tryVal - 1])
                    else:
                        self._solver.add(self._grid[i][j] == tryVal)

                if self._verbose:
                    print(f'Finished with row {i} and filled \n {self._nums[i]}')
        else:  # not per_col
            # Start by filling the number 1,2,3...9
            for num in range(1, 10):
                if self._verbose:
                    print(f'Filling number {num}')
                if num == 9:
                    for r in range(9):
                        for c in range(9):
                            if self._nums[r][c] == 0:
                                self._nums[r][c] = int(num)
                                if self._no_num:
                                    self._solver.add(self._grid[r][c][num - 1])
                                else:
                                    self._solver.add(self._grid[r][c] == int(num))
                else:
                    cols = [i for i in range(9)]
                    for r in range(9):

                        random.shuffle(cols)
                        for c in cols:
                            # prefill num = 1s
                            if num == 1 and self._prefill:
                                if self._nums[r][c] == 0:
                                    self.add_constaint(r, c, num)
                                    self._nums[r][c] = num
                                    cols.remove(c)
                                    break
                                elif self._nums[r][c] == num:
                                    cols.remove(c)
                                    break
                            if self._nums[r][c] == 0:
                                condition = self.check_condition(r, c, num)
                                if condition == z3.sat:
                                    self.add_constaint(r, c, num)
                                    cols.remove(c)
                                    self._nums[r][c] = num
                                    break
                                else:
                                    if condition == z3.unknown:
                                        s_new = self.new_solver()
                                        check = s_new.check_condition(r, c, num)

                                        if self._hard_smt_logPath:
                                            self.write_to_smt_and_sudoku_file((r, c), num, check)
                                        else:
                                            print("TimeOut and a logPath is not provided")

                                        if check == z3.unknown:
                                            raise 'Timeout happened twice, don\'t know how to continue!'
                                        elif self._verbose:
                                            print(f'unsolvable problem was {check} for ({r},{c}) is {num}')
                                        if check == z3.sat:
                                            self.add_constaint(r, c, num)
                                            # self._solver.add(condition)
                                            cols.remove(c)
                                            break

                            elif self._nums[r][c] == num:
                                cols.remove(c)
                                break
        if self._verbose:
            print("Generated a solved sudoku")
            print(self._nums)
        return self._nums, self._penalty

    def solve_and_generate_smt2(self, output_file):
        self.load_constraints()
        self._solver.start_recording()

        nums, penalty = self.gen_solved_sudoku()

        # if nums is not None:
        #     print("Sudoku solved successfully!")
        #     print("Solution:")
        #     for row in nums:
        #         print(row)
        # else:
        #     print("Sudoku has no solution.")

        self._solver.generate_smtlib(output_file)
        print(f"SMT2 file generated: {output_file}")

        # Generate SMT2 output using z3.Solver.to_smt2()
        z3_smt2_output = self._solver.to_smt2()
        z3_output_file = "z3_sudoku_solved.smt2"
        with open(z3_output_file, "w") as file:
            file.write(z3_smt2_output)
        print(f"Z3 SMT2 output generated: {z3_output_file}")

        # Compare the generated files
        with open(output_file, "r") as file1, open(z3_output_file, "r") as file2:
            content1 = file1.read()
            content2 = file2.read()
            if content1 == content2:
                print("The generated SMT2 files are identical.")
            else:
                print("The generated SMT2 files are different.")


    def write_to_smt_and_sudoku_file(self, pos, value, sat):
        """Write self._solver as a smt file to _log_path

        When reading the constraints:
        t = z3.Solver()
        t.from_file(_log_path)
        print(t, t.check())
        """
        # check directory exist
        par_dir = Path(self._hard_smt_logPath).parent
        if not os.path.exists(par_dir):
            os.makedirs(par_dir)
        time_str = time.strftime("%m_%d_%H_%M_%S") + str(time.time()) # making sure no repetition in file name
        # record as smt file
        with open(self._hard_smt_logPath + time_str, 'w') as myfile:
            print(self._solver.to_smt2(), file=myfile)

        # check directory exist
        par_dir = Path(self._hard_sudoku_logPath).parent
        if not os.path.exists(par_dir):
            os.makedirs(par_dir)
        # record sudoku as string file
        with open(self._hard_sudoku_logPath, 'a+') as myfile:
            sudoku_lst = ''.join(str(ele) for rows in self._nums for ele in rows)
            print(f'{sudoku_lst}\t{self.condition_tpl}\t{pos}\t{value}\t{sat}\n', file=myfile)

    def generate_smt_with_additional_constraint(self, index: (int, int), try_val: int, is_sat: bool,
                                                smt_dir: str) -> str:
        """
        Add an additional constraint to the Sudoku problem, generate an SMT file, and return the file path.

        :param index: Tuple (row, column) of the cell for the additional constraint.
        :param try_val: The value to assign or not assign at the given index.
        :param is_sat: If True, the cell at index should be try_val; if False, it should not be try_val.
        :param smt_dir: Directory to store the generated SMT file.
        :return: The path to the generated SMT file.
        """
        self.load_constraints()

        # Add the specific condition for the cell at 'index'
        i, j = index
        if is_sat:
            self.add_constaint(i,j,try_val)
        else:
            self.add_not_equal_constraint(i,j,try_val)


        # Generate the file path for the SMT file
        file_name = f"sudoku_smt_{time.strftime('%m_%d_%H_%M_%S')}_{str(time.time())}.smt2"
        file_path = os.path.join(smt_dir, file_name)

        # Write the SMT-LIB representation to the file
        with open(file_path, 'w') as smt_file:
            smt_file.write(self._solver.to_smt2())

        return file_path




def generate_puzzle(solved_sudokus, classic: bool, distinct: bool, per_col: bool, no_num: bool, prefill: bool, seed,
                    log_path="", print_progress=False):
    """
    Generates puzzle with holes

    :param print_progress:
    :param log_path:
    :param solved_sudokus: MUST BE a 3D list
    :param classic:
    :param distinct:
    :return: [[time_rec], [penalty_lst]] list of lists
    """
    time_rec = []
    penalty_lst = []
    for puzzle in solved_sudokus:
        if print_progress:
            print(f'Solving puzzle: ')
            print(puzzle)
        st = time.time()
        penalty = 0
        for i in range(9):
            for j in range(9):
                s = Sudoku(puzzle.reshape(-1), classic, distinct, per_col, no_num, prefill, hard_smt_logPath=log_path, seed=seed)
                removable, temp_penalty = s.removable(i, j, puzzle[i][j])
                if removable:
                    puzzle[i][j] = 0
                penalty += temp_penalty
        et = time.time()
        time_rec.append(et - st)
        penalty_lst.append(penalty)
        print('Successfully generated one puzzle')
        # **** REMOVE
        print(puzzle)
    # **** REMOVE
    # np.save('sudoku_puzzle', solved_sudokus)
    assert len(time_rec) == len(penalty_lst), "Bug in generate_puzzle"

    return time_rec, penalty_lst

def pure_constraints(classic: bool, distinct: bool, per_col: bool, no_num: bool, prefill: bool, seed, num_iter=1,
                     log_path="logFile"):
    empty_list = [0 for i in range(9) for j in range(9)]
    s = Sudoku(empty_list, classic, distinct, per_col, no_num, prefill, hard_smt_logPath=log_path, seed=seed)
    s.generate_smt2_file("./output.smt2")


def gen_solve_sudoku(classic: bool, distinct: bool, per_col: bool, no_num: bool, prefill: bool, seed, num_iter=1,
                     log_path="logFile"):
    '''
    First creates a solved sudoku, then generate a sudoku puzzle. returns time for each

    :param prefill:
    :param classic:
    :param distinct:
    :param per_col:
    :param no_num:
    :param num_iter:
    :return: (solve_time, solve_penalty, gen_time, gen_penalty) all are 1D lists
    '''
    ret_solve_time = []
    store_solved_sudoku = []
    solve_penalty = []
    for i in range(num_iter):
        empty_list = [0 for i in range(9) for j in range(9)]
        st = time.time()
        s = Sudoku(empty_list, classic, distinct, per_col, no_num, prefill, hard_smt_logPath=log_path, seed=seed)
        nums, penalty = s.gen_solved_sudoku()
        et = time.time()
        store_solved_sudoku.append(nums)
        ret_solve_time.append(et - st)
        solve_penalty.append(penalty)
    # np.save('solved_sudoku', store_solved_sudoku)
    store_holes = deepcopy(store_solved_sudoku)
    store_holes = np.array(store_holes)
    print("Start generating puzzles")
    ret_holes_time, holes_penalty = generate_puzzle(store_holes, classic, distinct, per_col, no_num, prefill,seed=seed)
    assert len(ret_solve_time) == len(solve_penalty), "error in gen_solve_sudoku"
    return ret_solve_time, solve_penalty, ret_holes_time, holes_penalty


def append_list_to_file(file_path, lst: list[int]):
    par_dir = Path(file_path).parent
    if not os.path.exists(par_dir):
        os.makedirs(par_dir)
    with open(file_path, 'a+') as f:
        f.write(str(lst) + "\n")


def gen_full_sudoku(*constraints, seed, hard_smt_logPath='smt2_files/', store_sudoku_path="", hard_sudoku_logPath="") -> (
float, int):
    """
    append generated full sudoku to the designated path as a string
    
    :param hard_smt_log_path:
    :param constraints: classic, distinct, percol, no_num, prefill
    :param store_sudoku_path:
    :return: (time, penalty)
    """
    empty_list = [0 for i in range(9) for j in range(9)]
    st = time.time()
    s = Sudoku(empty_list, *constraints, hard_smt_logPath=hard_smt_logPath, hard_sudoku_logPath=hard_sudoku_logPath, seed=seed)
    nums, penalty = s.gen_solved_sudoku()
    et = time.time()
    # Write to file
    append_list_to_file(store_sudoku_path, sum(nums, []))  # flatten 2D nums into 1D
    return et - st, penalty


def gen_holes_sudoku(solved_sudoku: list[int], *constraints, seed, hard_smt_logPath='smt2_files/', store_sudoku_path="",
                     hard_sudoku_logPath="", print_progress=False):
    """
    Reads sudokus as a string from store_sudoku_path
    :param solved_sudoku: 1D list of an already solved sudoku grid
    :param hard_instances_log_path:
    :param constraints: classic, distinct, percol, no_num, prefill
    :param store_sudoku_path:
    :return: (time, penalty)
    """
    if print_progress:
        print(f'Solving puzzle: ')
        print(solved_sudoku)
    st = time.time()
    penalty = 0
    for i in range(9):
        for j in range(9):
            s = Sudoku(solved_sudoku, *constraints, hard_smt_logPath=hard_smt_logPath,
                       hard_sudoku_logPath=hard_sudoku_logPath,seed=seed)
            removable, temp_penalty = s.removable(i, j, solved_sudoku[i * 9 + j])
            if removable:
                solved_sudoku[i * 9 + j] = 0
            penalty += temp_penalty
    et = time.time()
    time_rec = et - st

    if print_progress:
        print('Successfully generated one puzzle')
        print(solved_sudoku)
    # np.save('sudoku_puzzle', solved_sudokus)
    append_list_to_file(store_sudoku_path, solved_sudoku)
    return time_rec, penalty


def check_condition_index(sudoku_grid: list[int], condition, index: (int, int), try_val: int, is_sat: str, seed: float) -> (int, int):
    """

    :param sudoku_grid:
    :param condition:
    :param index:
    :param try_val:
    :param is_sat:
    :return: (time,penalty)
    """
    s = Sudoku(sudoku_grid, *condition, seed=seed)
    s.load_constraints()
    start = time.time()
    penalty = 0
    if is_sat:
        if z3.unknown == s.check_condition(index[0], index[1], try_val):
            penalty = 1

    else:
        if z3.unknown == s.check_not_removable(index[0], index[1], try_val):
            penalty = 1
    end = time.time()
    return end - start, penalty


def generate_smt(grid: str, constraint: list, index: (int, int), try_val: int, is_sat: bool, smt_dir: str, seed: float) -> str:
    """
    Add an additional constraint to the Sudoku problem, generate an SMT file, and return the file path.
    :param index: Tuple (row, column) of the cell for the additional constraint.
    :param try_val: The value to assign or not assign at the given index.
    :param is_sat: If True, the cell at index should be try_val; if False, it should not be try_val.
    :param smt_dir: Directory to store the generated SMT file.
    :return: The path to the generated SMT file.
    """
    solver = Sudoku(list(map(int,(grid))),*constraint,seed=seed)
    file_path = solver.generate_smt_with_additional_constraint(index,try_val,is_sat,smt_dir)

    return file_path



if __name__ == "__main__":
    # Test classic case
    # classic, distinct, per_col, no_num
    # solve_time, solve_penalty, gen_time, gen_penalty = gen_solve_sudoku(False, True, True,
    #                                                                     False, True, num_iter=100,
    #                                                                     log_path='DataCollection/')
    # pure_constraints(classic=True, distinct=False, per_col=True, no_num=False, prefill=True, num_iter=2,seed=4321)
    # print(gen_solve_sudoku(classic=True, distinct=False, per_col=True, no_num=False, prefill=True, num_iter=2,seed=4321
    #                        ))

    # empty_list = [0 for i in range(9) for j in range(9)]
    # s = Sudoku(empty_list, classic=False, distinct=True, per_col=True, no_num=False, log_path="DataCollection/")
    # s.gen_solved_sudoku()

    # store_holes = np.load('solved_sudoku.npy')
    # ret_holes_time = generate_puzzle(store_holes, True, True, False, False)
    empty_list = [0 for i in range(9) for j in range(9)]
    s = Sudoku(empty_list, classic=True, distinct=True, per_col=True, no_num=False, prefill=True,seed=1234)
    s.solve_and_generate_smt2("my-smt.smt2")

    print("Process finished")



# fill when grid is almost full
    # check the time to fill the grid when it's almost full

# helper to rerun experiment


# s = SolverFor("QF_LIA")


# full smt files
# encode the numbers not as numbers, but as new constants
# >= part distinct numbers -> add it to the contraints variations
# smt to string mapping
