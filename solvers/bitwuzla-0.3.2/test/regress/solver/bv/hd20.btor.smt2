(set-logic QF_BV)
(set-info :status unsat)
(declare-const v0 (_ BitVec 32))
(assert (= #b1 (bvnot (ite (= (bvsrem v0 (_ bv8 32)) (bvsub v0 (bvand (bvadd v0 (bvlshr (bvashr v0 ((_ zero_extend 27) (_ bv2 5))) ((_ zero_extend 27) (_ bv29 5)))) (bvneg (_ bv8 32))))) #b1 #b0))))
(check-sat)
