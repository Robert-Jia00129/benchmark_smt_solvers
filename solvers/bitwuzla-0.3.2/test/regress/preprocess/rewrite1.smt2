(declare-fun a () (_ BitVec 1))
(declare-fun b () (_ BitVec 1))
(declare-fun c () (_ BitVec 1))
(declare-fun d () (_ BitVec 1))
(assert (= b (ite (= (_ bv1 1) (bvand c b d a)) (_ bv0 1) (_ bv1 1))))
(set-info :status sat)
(check-sat)
