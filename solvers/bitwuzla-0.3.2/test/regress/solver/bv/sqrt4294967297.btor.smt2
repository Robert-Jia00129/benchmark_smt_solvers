(set-logic QF_BV)
(set-info :status unsat)
(declare-const v0 (_ BitVec 17))
(assert (= #b1 (ite (= (bvmul ((_ zero_extend 17) v0) ((_ zero_extend 17) v0)) (_ bv4294967297 34)) #b1 #b0)))
(check-sat)
