(set-logic QF_BV)
(set-info :status unsat)
(declare-const v0 (_ BitVec 1))
(declare-const v1 (_ BitVec 32))
(assert (= #b1 (bvor (bvnot (ite (= (ite (= v0 #b1) (bvnot v1) (bvadd (_ bv1 32) (bvnot v1))) (bvadd (bvnot v1) ((_ zero_extend 31) (bvnot v0)))) #b1 #b0)) (bvnot (ite (= (ite (= v0 #b1) (bvadd (_ bv1 32) (bvnot v1)) (bvnot v1)) (bvadd (bvnot v1) ((_ zero_extend 31) v0))) #b1 #b0)))))
(check-sat)
