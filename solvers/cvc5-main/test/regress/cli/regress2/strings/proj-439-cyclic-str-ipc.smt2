(set-logic QF_SLIA)
(set-info :status unsat)
(declare-const x Int)
(declare-fun u () String)
(assert (and (not (= 0 (ite (str.prefixof "mo" u) 1 0))) (not (= 0 (ite (str.contains (str.substr (str.substr u 10 (str.len u)) 0 (+ 1 (str.indexof (str.substr u 10 (str.len u)) "A" 0))) "W") 1 0))) (= 0 (ite (not (= "aost" (str.++ (str.substr (str.substr u 1 (str.len u)) 0 (str.indexof (str.substr (str.substr u 10 (str.len u)) (+ 1 (str.indexof (str.substr u 10 (str.len u)) "A" 0)) (str.len (str.substr u 0 (str.len u)))) "W" 0)) (str.substr (str.++ (str.replace (str.substr (str.substr u 10 (str.len u)) 0 (+ 1 (str.indexof (str.substr u 10 (str.len u)) "A" 0))) "A" "a") (str.substr u 0 x)) (+ 1 (str.indexof (str.substr (str.substr u 10 (str.len u)) (+ 1 (str.indexof (str.substr u 10 (str.len u)) "A" 0)) (str.len (str.substr u 0 (str.len u)))) "W" 0)) (str.len (str.substr u 0 (str.len u))))))) 1 0))))
(check-sat)
