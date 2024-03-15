(set-logic QF_BVFP)
(set-info :status sat)
(define-fun fp.neq ((x Float32) (y Float32)) Bool (fp.eq (_ +zero 8 24) y))
(declare-fun x () Bool)
(assert (= x (distinct (ite (fp.neq (_ +zero 8 24) (_ +zero 8 24)) #x00000001 #x00000000) #x00000000)))
(check-sat)
(exit)
