(set-logic QF_ABV)
(set-info :status sat)
(declare-const a0 (Array (_ BitVec 1) (_ BitVec 1) ))
(assert (= #b1 (bvand (select a0 (_ bv0 1)) (select a0 (_ bv1 1)))))
(check-sat)