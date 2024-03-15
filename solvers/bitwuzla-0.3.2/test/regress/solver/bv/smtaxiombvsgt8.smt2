(set-logic QF_BV)
(set-info :status unsat)
(declare-fun s () (_ BitVec 8))
(declare-fun t () (_ BitVec 8))
(assert (not (= (bvsgt s t) (bvslt t s))))
(check-sat)
(exit)
