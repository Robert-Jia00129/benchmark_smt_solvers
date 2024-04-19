(set-logic QF_ABV)
(set-info :status unsat)
(declare-const a0 (Array (_ BitVec 2) (_ BitVec 1) ))
(declare-const a1 (Array (_ BitVec 2) (_ BitVec 1) ))
(declare-const v0 (_ BitVec 2))
(declare-const v1 (_ BitVec 2))
(declare-const v2 (_ BitVec 2))
(declare-const v3 (_ BitVec 1))
(declare-const v4 (_ BitVec 1))
(assert (= #b1 (bvand (bvand (bvnot (ite (= (select a0 v2) (select a1 v2)) #b1 #b0)) (bvnot (ite (= v0 v2) #b1 #b0))) (bvand (bvnot (ite (= v1 v2) #b1 #b0)) (ite (= (store a0 v0 v3) (store a1 v1 v4)) #b1 #b0)))))
(check-sat)