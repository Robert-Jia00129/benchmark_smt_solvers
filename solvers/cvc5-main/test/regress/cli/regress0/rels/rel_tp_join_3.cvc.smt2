; EXPECT: unsat
(set-option :incremental false)
(set-logic ALL)

(declare-fun w () (Relation Int Int))
(declare-fun x () (Relation Int Int))
(declare-fun y () (Relation Int Int))
(declare-fun z () (Relation Int Int))
(declare-fun r () (Relation Int Int))
(assert (set.member (tuple 7 1) x))
(assert (set.member (tuple 2 3) x))
(assert (set.member (tuple 7 3) y))
(assert (set.member (tuple 4 7) y))
(assert (set.member (tuple 3 4) z))
(assert (set.member (tuple 3 3) w))
(declare-fun a () (Tuple Int Int))
(assert (= a (tuple 4 1)))
(assert (not (set.member a (rel.transpose r))))
(declare-fun zz () (Relation Int Int))
(assert (= zz (rel.join (rel.transpose x) y)))
(assert (not (set.member (tuple 1 3) w)))
(assert (not (set.member (tuple 1 3) (set.union w zz))))
(check-sat)
