; COMMAND-LINE: --mbqi
; EXPECT: unsat
(set-logic HO_ALL)
(assert
(forall ((BOUND_VARIABLE_313 Bool) (BOUND_VARIABLE_314 (-> Int Bool)) (BOUND_VARIABLE_315 (-> Int Int)) (BOUND_VARIABLE_316 Int) (BOUND_VARIABLE_317 (-> Int Bool)) (BOUND_VARIABLE_318 Int)) (! (not (and (not (and (= (ite (and (not (= BOUND_VARIABLE_318 0)) (BOUND_VARIABLE_314 (BOUND_VARIABLE_315 (ite (not (BOUND_VARIABLE_314 0)) 0 (ite BOUND_VARIABLE_313 0 (ite (and (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) (BOUND_VARIABLE_314 0)) 0 (ite (and (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) (or (not BOUND_VARIABLE_313) BOUND_VARIABLE_313)) 0 (ite (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) 0 9)))))))) (ite (BOUND_VARIABLE_317 (BOUND_VARIABLE_315 (ite (not (BOUND_VARIABLE_314 0)) 0 (ite BOUND_VARIABLE_313 0 (ite (and (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) (BOUND_VARIABLE_314 0)) 0 (ite (and (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) (or (not BOUND_VARIABLE_313) BOUND_VARIABLE_313)) 0 (ite (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) 0 9))))))) BOUND_VARIABLE_316 0) 0) 0) (not (BOUND_VARIABLE_314 (BOUND_VARIABLE_315 (ite (not (BOUND_VARIABLE_314 0)) 0 (ite BOUND_VARIABLE_313 0 (ite (and (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) (BOUND_VARIABLE_314 0)) 0 (ite (and (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) (or (not BOUND_VARIABLE_313) BOUND_VARIABLE_313)) 0 (ite (not (or (and BOUND_VARIABLE_313 BOUND_VARIABLE_313) BOUND_VARIABLE_313)) 0 9)))))))))) true)) :pattern (true)))
)
(check-sat)
