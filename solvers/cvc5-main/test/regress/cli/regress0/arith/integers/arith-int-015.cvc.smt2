; EXPECT: sat
(set-logic ALL)
(set-option :incremental false)
(declare-fun x0 () Int)
(declare-fun x1 () Int)
(declare-fun x2 () Int)
(declare-fun x3 () Int)
(assert (> (+ (+ (+ (* (- 22) x0) (* (- 3) x1)) (* 9 x2)) (* (- 13) x3)) (- 31)))
(assert (> (+ (+ (+ (* 31 x0) (* (- 17) x1)) (* 28 x2)) (* (- 16) x3)) (- 28)))
(check-sat)
