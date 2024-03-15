(set-logic QF_ALL)
(set-info :status sat)
(set-option :sets-ext true)
(declare-const universe (Set (Array Int Int)))
(declare-const A (Set (Array Int Int)))
(declare-const B (Set (Array Int Int)))
(assert (= (set.card universe) 3))
(assert (= (set.card A) 1))
(assert (= (set.card B) 2))
(assert (= (set.inter A B) (as set.empty (Set (Array Int Int)))))
(assert (= universe (as set.universe (Set (Array Int Int)))))
(check-sat)
