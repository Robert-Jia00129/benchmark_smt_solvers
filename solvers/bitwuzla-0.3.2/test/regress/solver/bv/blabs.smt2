(set-logic QF_BV)
(declare-fun x () (_ BitVec 32))
(declare-fun a () (_ BitVec 32))
(declare-fun b () (_ BitVec 32))
(assert (= a (ite (bvslt x (_ bv0 32)) (bvneg x) x)))
(assert (= b (let (($sign (bvashr x (_ bv31 32))))
                  (bvsub (bvxor x $sign) $sign))))
(assert (distinct a b))
(check-sat)
(exit)
