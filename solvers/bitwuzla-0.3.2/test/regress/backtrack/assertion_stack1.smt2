(declare-fun c () (_ BitVec 32))
(assert (and true (= c (_ bv0 32))))
(push 1)
(assert (= c (_ bv0 32)))
(push 1)
(set-info :status sat)
(check-sat)
(pop 1)
