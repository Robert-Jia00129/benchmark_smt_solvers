(set-logic ALL)
(set-info :status sat)
(declare-const x (Bag Int))
(declare-const x8 (Bag Int))
(assert (= 0 (mod 0 (+ (bag.card (bag.union_disjoint x8 x8)) (div (bag.card (bag.union_disjoint x8 x)) (bag.card (bag.union_disjoint x8 x8)))))))
(check-sat)
