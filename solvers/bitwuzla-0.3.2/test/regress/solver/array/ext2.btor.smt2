(set-logic QF_ABV)
(set-info :status unsat)
(declare-const a0 (Array (_ BitVec 1) (_ BitVec 1) ))
(declare-const a1 (Array (_ BitVec 1) (_ BitVec 1) ))
(declare-const v0 (_ BitVec 1))
(assert (= #b1 (bvand (ite (= a0 a1) #b1 #b0) (bvnot (ite (= (select a0 v0) (select a1 v0)) #b1 #b0)))))
(check-sat)
