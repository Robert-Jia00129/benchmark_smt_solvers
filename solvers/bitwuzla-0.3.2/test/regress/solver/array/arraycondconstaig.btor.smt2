(set-logic QF_ABV)
(set-info :status unsat)
(declare-const a0 (Array (_ BitVec 1) (_ BitVec 1) ))
(declare-const a1 (Array (_ BitVec 1) (_ BitVec 1) ))
(declare-const v0 (_ BitVec 1))
(declare-const v1 (_ BitVec 1))
(declare-const v2 (_ BitVec 1))
(assert (= #b1 (bvnot (ite (= (select (ite (= (bvand (bvnot v0) (bvand v0 v1)) #b1) a0 a1) v2) (select (ite (= #b0 #b1) a0 a1) v2)) #b1 #b0))))
(check-sat)
