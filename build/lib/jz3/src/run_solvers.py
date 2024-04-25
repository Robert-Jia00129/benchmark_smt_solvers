import subprocess
import time


def run_cvc5(smt2_file, time_out:int=5):
    cvc_path = "../../solvers/cvc5-macOS-arm64"
    command = [cvc_path,smt2_file,"--lang","smt2"]
    start_time = time.time()
    did_timeout = False
    try:
        result = subprocess.run(command,
                                capture_output=True, text=True, timeout=time_out)
        combined_output = ((result.stdout if result.stdout is not None else "") +
                           (result.stderr if result.stderr is not None else ""))  # capture all output
    except subprocess.TimeoutExpired as exc:
        did_timeout = True
        combined_output = ((exc.stdout.decode('utf-8') if exc.stdout else "") +
                           (exc.stderr.decode('utf-8') if exc.stderr else ""))  # capture all output
    ans = "timeout"

    end_time = time.time()

    if not did_timeout:
        if "unsat" in combined_output:
            ans = "unsat"
        elif "sat" in combined_output:
            ans = "sat"
        else:
            ans = "unknown"
    return (end_time - start_time, did_timeout, ans)

def run_z3(smt2_file: str, time_out:int = 5):
    """
    :param smt_log_file_path:
    :param time_out: in seconds
    :return:
    """
    start_time = time.time()
    did_timeout = False
    try:
        result = subprocess.run(["z3", "-smt2", smt2_file],
                                capture_output=True, text=True, timeout=time_out)
        combined_output = ((result.stdout if result.stdout is not None else "") +
                           (result.stderr if result.stderr is not None else ""))  # capture all output
    except subprocess.TimeoutExpired as exc:
        did_timeout = True
        result = exc
    ans = "timeout"
    end_time = time.time()

    if not did_timeout:
        if "unsat" in combined_output:
            ans = "unsat"
        elif "sat" in combined_output:
            ans = "sat"
        else:
            ans = "unknown"
    return (end_time - start_time, did_timeout, ans)



def run_yices(smt2_file):
    command = f"yices-smt2 {smt2_file}"
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

# Dictionary to map solver names to their corresponding functions
solvers = {
    "cvc5": run_cvc5,
    "z3": run_z3
    # "yices": run_yices
}

def run_solvers(smt2_file,verbose=False):
    results = {}

    for solver, run_function in solvers.items():
        if verbose:
            print(f"Running {solver}...")
        result = run_function(smt2_file)
        results[solver] = result

    return results



