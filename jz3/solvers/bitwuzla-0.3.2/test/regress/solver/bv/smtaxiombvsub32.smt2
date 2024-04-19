(set-logic QF_BV)
(set-info :status unsat)
(declare-fun s () (_ BitVec 32))
(declare-fun t () (_ BitVec 32))
(assert (not (= (bvsub s t) (bvadd s (bvneg t)))))
(check-sat)
(exit)