; DISABLE-TESTER: lfsc
(set-option :incremental false)
(set-info :status unsat)
(set-logic QF_BV)
(declare-fun v1 () (_ BitVec 1))
(check-sat-assuming ( (let ((_let_0 ((_ zero_extend 9) v1))) (not (= (bvmul (bvmul (_ bv416 10) ((_ zero_extend 9) (ite (bvsgt _let_0 _let_0) (_ bv1 1) (_ bv0 1)))) ((_ sign_extend 9) v1)) (_ bv0 10)))) ))
