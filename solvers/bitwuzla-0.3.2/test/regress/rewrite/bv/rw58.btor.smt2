(set-logic QF_BV)
(set-info :status sat)
(declare-const v0 (_ BitVec 1))
(declare-const v1 (_ BitVec 4))
(declare-const v2 (_ BitVec 4))
(declare-const v3 (_ BitVec 4))
(assert (= #b1 (bvor (bvnot (ite (= (ite (= v0 #b1) (bvudiv v1 v2) (bvudiv v2 v3)) (bvudiv (ite (= v0 #b1) v1 v3) v2)) #b1 #b0)) (bvnot (ite (= (ite (= v0 #b1) (bvudiv v2 v3) (bvudiv v1 v2)) (bvudiv (ite (= v0 #b1) v3 v1) v2)) #b1 #b0)))))
(check-sat)
