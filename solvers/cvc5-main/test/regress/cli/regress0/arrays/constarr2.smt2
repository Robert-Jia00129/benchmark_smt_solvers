(set-logic QF_ALIA)
(set-info :status unsat)
(declare-const all1 (Array Int Int))
(declare-const all2 (Array Int Int))
(declare-const a Int)
(declare-const i Int)
(assert (= all1 ((as const (Array Int Int)) 1)))
(assert (= all2 ((as const (Array Int Int)) 2)))
(assert (= all1 all2))
(check-sat)
