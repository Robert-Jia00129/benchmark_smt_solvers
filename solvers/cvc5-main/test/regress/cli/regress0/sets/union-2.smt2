; EXPECT: sat
(set-logic ALL)
(set-info :status sat)
(define-sort SetInt () (Set Int))
(declare-fun A () (Set Int))
(declare-fun B () (Set Int))
(declare-fun x () Int)
(declare-fun y () Int)
(assert (set.member x (set.union A B)))
(assert (not (set.member y A)))
(assert (not (set.member y B)))
(check-sat)
