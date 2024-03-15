(set-logic ALL)
(set-info :status sat)
(set-option :sygus-inference true)
(set-option :sets-infer-as-lemmas false)
(declare-fun a () (Set Int))
(declare-fun b () (Set Int))
(declare-fun c () (Set Int))
(declare-fun d () Int)
(assert (> (set.card (set.minus a (set.inter (set.minus a b) (set.minus a c)))) d))
(check-sat)
