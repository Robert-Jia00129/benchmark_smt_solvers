(set-info :status sat)
(set-logic QF_BV)
(declare-fun v1 () (_ BitVec 11))
(declare-fun v2 () (_ BitVec 15))
(declare-fun v3 () (_ BitVec 15))
(declare-fun v4 () (_ BitVec 11))
(assert (let ((_let_0 (concat (_ bv0 4) v1))) (= (_ bv0 1) (bvand (bvand (ite (= (_ bv1 1) (ite (= (_ bv1 1) (ite (= (_ bv1 1) (ite (= v2 v3) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1)) (ite (= (_ bv0 1) (ite (= (_ bv1 1) (ite (bvult (_ bv0 1) (ite (= (_ bv1 1) (ite (bvult (_ bv0 10) ((_ extract 9 0) v1)) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (ite (= (_ bv1 1) (ite (= (_ bv1 1) (ite (bvult ((_ extract 2 0) ((_ zero_extend 2) ((_ extract 1 0) (concat (_ bv0 3) (ite (= (_ bv1 1) (ite (= v2 _let_0) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1)))))) ((_ extract 2 0) (concat (_ bv0 3) (ite (= (_ bv1 1) (ite (= (concat (_ bv0 10) (ite (= (_ bv1 1) (ite (= v3 _let_0) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) ((_ extract 10 0) (bvlshr (_ bv1 16) ((_ zero_extend 12) ((_ extract 3 0) v4))))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))) (_ bv1 1) (_ bv0 1))))))
(check-sat)

