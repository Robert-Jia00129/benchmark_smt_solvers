(set-option :incremental false)
(set-info :source "MathSat group")
(set-info :status unsat)
(set-info :category "random")
(set-info :difficulty "3")
(set-logic QF_UFLRA)
(declare-fun f0_1 (Real) Real)
(declare-fun f0_2 (Real Real) Real)
(declare-fun f0_3 (Real Real Real) Real)
(declare-fun f0_4 (Real Real Real Real) Real)
(declare-fun f1_1 (Real) Real)
(declare-fun f1_2 (Real Real) Real)
(declare-fun f1_3 (Real Real Real) Real)
(declare-fun f1_4 (Real Real Real Real) Real)
(declare-fun x0 () Real)
(declare-fun x1 () Real)
(declare-fun x2 () Real)
(declare-fun x3 () Real)
(declare-fun x4 () Real)
(declare-fun x5 () Real)
(declare-fun x6 () Real)
(declare-fun x7 () Real)
(declare-fun x8 () Real)
(declare-fun x9 () Real)
(declare-fun P0 () Bool)
(declare-fun P1 () Bool)
(declare-fun P2 () Bool)
(declare-fun P3 () Bool)
(declare-fun P4 () Bool)
(declare-fun P5 () Bool)
(declare-fun P6 () Bool)
(declare-fun P7 () Bool)
(declare-fun P8 () Bool)
(declare-fun P9 () Bool)
(check-sat-assuming ( (let ((_let_0 (* 22.0 x9))) (let ((_let_1 (- (- (* 18.0 x5) (* 20.0 x9)) (* 27.0 x4)))) (let ((_let_2 (- (- (* (/ (- 0 3) 1) x3) (* 12.0 x6)) (* 12.0 x2)))) (let ((_let_3 (- (- (* (/ (- 0 17) 1) x6) (* 23.0 x3)) (* 14.0 x0)))) (let ((_let_4 (f0_1 x0))) (let ((_let_5 (+ (+ (* 20.0 x4) (* 9.0 x2)) (* 27.0 x7)))) (let ((_let_6 (+ (- (* 13.0 _let_1) (* 20.0 x4)) (* 29.0 (f1_2 x2 x1))))) (let ((_let_7 (f0_2 x7 x4))) (let ((_let_8 (f1_1 (f0_2 x3 (f0_1 x3))))) (let ((_let_9 (f1_1 _let_7))) (let ((_let_10 (- (+ (* 18.0 x1) (* 12.0 x5)) (* 2.0 x2)))) (let ((_let_11 (= (f0_2 x3 (f0_1 x3)) _let_6))) (let ((_let_12 (< _let_1 7.0))) (let ((_let_13 (= _let_10 (f1_2 x2 x3)))) (let ((_let_14 (< _let_1 12.0))) (let ((_let_15 (< _let_9 19.0))) (let ((_let_16 (< _let_4 26.0))) (let ((_let_17 (< _let_4 (/ (- 0 26) 1)))) (let ((_let_18 (= x6 (f0_1 (+ (+ (* 6.0 x0) (* 15.0 x3)) (* 10.0 x4)))))) (let ((_let_19 (< _let_10 (/ (- 0 27) 1)))) (let ((_let_20 (< x0 (/ (- 0 23) 1)))) (let ((_let_21 (< _let_6 (/ (- 0 4) 1)))) (let ((_let_22 (< x3 (/ (- 0 22) 1)))) (let ((_let_23 (< x4 3.0))) (let ((_let_24 (< (+ (+ (* 6.0 x0) (* 15.0 x3)) (* 10.0 x4)) 7.0))) (let ((_let_25 (= _let_7 x3))) (let ((_let_26 (< (f0_1 x3) 21.0))) (let ((_let_27 (< _let_3 (/ (- 0 27) 1)))) (let ((_let_28 (< _let_2 0.0))) (let ((_let_29 (< (f0_2 x1 x5) (/ (- 0 16) 1)))) (let ((_let_30 (= _let_6 (+ (+ (* 4.0 x8) (* 23.0 x7)) (* 4.0 x5))))) (let ((_let_31 (< x7 (/ (- 0 7) 1)))) (let ((_let_32 (< (+ (- (* (/ (- 0 24) 1) x9) (* 13.0 x2)) (* 18.0 x5)) 17.0))) (let ((_let_33 (< (+ (- (* (/ (- 0 20) 1) x8) (* 13.0 x4)) (* 2.0 x1)) (/ (- 0 14) 1)))) (let ((_let_34 (= _let_3 _let_4))) (let ((_let_35 (< _let_1 0.0))) (let ((_let_36 (< (f1_2 x2 x1) (/ (- 0 15) 1)))) (let ((_let_37 (< x4 (/ (- 0 24) 1)))) (let ((_let_38 (= (f0_1 x1) _let_6))) (let ((_let_39 (< _let_5 (/ (- 0 10) 1)))) (let ((_let_40 (< x7 1.0))) (let ((_let_41 (< x4 26.0))) (let ((_let_42 (< (+ (+ (* 6.0 x0) (* 15.0 x3)) (* 10.0 x4)) 16.0))) (let ((_let_43 (= (f0_1 x3) _let_4))) (let ((_let_44 (< _let_8 6.0))) (let ((_let_45 (< (f0_1 (- (- (* (/ (- 0 8) 1) x8) _let_0) (* 6.0 x3))) 20.0))) (let ((_let_46 (< _let_2 (/ (- 0 17) 1)))) (let ((_let_47 (< (f0_1 x3) 8.0))) (let ((_let_48 (= _let_1 x6))) (let ((_let_49 (not (< x6 (/ (- 0 21) 1))))) (let ((_let_50 (not _let_22))) (let ((_let_51 (not (< _let_2 28.0)))) (let ((_let_52 (not _let_43))) (let ((_let_53 (or _let_52 _let_30))) (let ((_let_54 (not (< (f1_2 x2 x3) 7.0)))) (let ((_let_55 (not _let_17))) (let ((_let_56 (not _let_36))) (let ((_let_57 (or _let_22 _let_56))) (let ((_let_58 (not _let_21))) (let ((_let_59 (not _let_28))) (let ((_let_60 (not _let_19))) (let ((_let_61 (not _let_41))) (let ((_let_62 (not _let_24))) (let ((_let_63 (not _let_12))) (let ((_let_64 (not _let_15))) (let ((_let_65 (not (< (f1_2 _let_3 _let_2) 1.0)))) (let ((_let_66 (not _let_27))) (let ((_let_67 (not _let_44))) (let ((_let_68 (not _let_39))) (let ((_let_69 (not _let_14))) (let ((_let_70 (not _let_26))) (let ((_let_71 (not _let_38))) (let ((_let_72 (not _let_48))) (let ((_let_73 (not (< (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8)) 21.0)))) (let ((_let_74 (or _let_73 _let_68))) (let ((_let_75 (not _let_29))) (let ((_let_76 (not _let_45))) (let ((_let_77 (not _let_25))) (let ((_let_78 (not _let_40))) (let ((_let_79 (not (< _let_9 0.0)))) (let ((_let_80 (not _let_31))) (let ((_let_81 (not _let_34))) (let ((_let_82 (not _let_16))) (let ((_let_83 (not _let_23))) (let ((_let_84 (not _let_46))) (let ((_let_85 (not _let_35))) (let ((_let_86 (not _let_13))) (let ((_let_87 (not (< _let_5 4.0)))) (let ((_let_88 (not _let_18))) (let ((_let_89 (not (< (+ (- (* 16.0 (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8))) (* 14.0 (- (+ (* (/ (- 0 17) 1) x5) (* 4.0 x9)) (* 4.0 x3)))) (* 20.0 x1)) 24.0)))) (let ((_let_90 (not _let_42))) (let ((_let_91 (not _let_32))) (let ((_let_92 (not (< (+ (- _let_0 (* 20.0 x7)) (* 18.0 x6)) 2.0)))) (let ((_let_93 (not (< x4 28.0)))) (let ((_let_94 (not _let_11))) (let ((_let_95 (not _let_47))) (let ((_let_96 (not _let_30))) (let ((_let_97 (not (< _let_8 (/ (- 0 9) 1))))) (let ((_let_98 (not _let_33))) (let ((_let_99 (or _let_68 _let_31))) (let ((_let_100 (or _let_76 _let_16))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (or (or _let_49 _let_50) _let_51) (or _let_53 _let_54)) (or (or _let_55 (< _let_8 (/ (- 0 9) 1))) P4)) (or _let_57 P5)) (or (or _let_27 _let_58) P0)) (or (or P1 _let_59) _let_60)) (or (or (< _let_9 0.0) _let_61) (< x6 (/ (- 0 21) 1)))) (or (or _let_62 _let_44) _let_15)) (or (or (not P3) _let_21) _let_54)) (or (or (not P8) _let_37) _let_16)) (or (or _let_28 _let_63) _let_64)) (or (or _let_65 (< _let_8 (/ (- 0 9) 1))) P8)) (or (or P2 _let_66) _let_21)) (or (or (not P1) _let_18) _let_34)) (or (or _let_67 _let_59) _let_14)) (or (or _let_49 P2) _let_68)) (or (or _let_69 _let_70) (not P4))) (or (or _let_64 P1) _let_71)) (or (or _let_72 _let_27) _let_63)) (or _let_74 _let_49)) (or (or _let_12 (< _let_2 28.0)) P2)) (or (or _let_75 (not P7)) _let_76)) (or (or (< (f1_2 x2 x3) 7.0) _let_28) _let_17)) (or (or _let_72 _let_70) P8)) (or (or _let_37 (not P8)) (not P9))) (or (or _let_50 (< (+ (- (* 16.0 (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8))) (* 14.0 (- (+ (* (/ (- 0 17) 1) x5) (* 4.0 x9)) (* 4.0 x3)))) (* 20.0 x1)) 24.0)) _let_31)) (or (or P7 _let_77) (not P6))) (or (or _let_59 _let_78) _let_65)) (or (or P2 _let_79) P6)) (or (or _let_80 _let_16) _let_43)) (or (or _let_36 _let_18) _let_24)) (or (or _let_22 _let_81) _let_82)) (or (or _let_52 _let_61) _let_27)) (or (or _let_56 _let_31) _let_59)) (or (or _let_83 _let_29) P3)) (or (or (not P5) _let_24) _let_37)) (or (or _let_65 (< (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8)) 21.0)) _let_84)) (or (or _let_85 (< x6 (/ (- 0 21) 1))) _let_86)) (or (or _let_44 (< _let_8 (/ (- 0 9) 1))) _let_85)) (or (or _let_87 _let_33) (not P9))) (or (or _let_42 (not P6)) _let_68)) (or (or _let_84 _let_65) _let_67)) (or (or _let_80 (< _let_9 0.0)) _let_45)) (or (or _let_88 _let_89) _let_60)) (or (or _let_58 (not P1)) (< (+ (- _let_0 (* 20.0 x7)) (* 18.0 x6)) 2.0))) (or (or P9 _let_32) _let_17)) (or (or _let_75 _let_17) _let_65)) (or (or _let_70 _let_90) _let_79)) (or (or _let_54 (not P4)) _let_42)) (or (or _let_70 _let_91) _let_92)) (or (or _let_87 _let_52) _let_77)) (or (or (< x4 28.0) (< _let_2 28.0)) P2)) (or (or _let_39 _let_13) _let_58)) (or (or _let_52 _let_60) _let_93)) (or (or _let_19 _let_11) P7)) (or (or _let_94 _let_31) (< x6 (/ (- 0 21) 1)))) (or (or _let_51 _let_44) _let_91)) (or (or _let_76 _let_44) P9)) (or (or _let_16 _let_33) _let_19)) (or (or P2 P4) _let_62)) (or (or _let_95 _let_71) _let_96)) (or (or _let_64 _let_97) _let_26)) (or (or _let_94 _let_84) _let_16)) (or (or _let_30 (not P9)) _let_14)) (or (or _let_59 _let_71) _let_82)) (or (or _let_40 (< _let_2 28.0)) (not P5))) (or (or _let_43 (< x4 28.0)) _let_33)) (or (or _let_89 _let_54) _let_81)) (or (or _let_24 _let_56) _let_26)) (or (or _let_16 _let_22) _let_45)) (or (or _let_88 _let_11) (< x4 28.0))) (or (or _let_80 _let_67) _let_12)) (or (or (not P8) _let_33) (not P5))) (or (or _let_77 (not P8)) _let_60)) (or (or _let_33 _let_49) _let_12)) (or (or _let_62 (< x6 (/ (- 0 21) 1))) _let_54)) (or (or _let_39 P6) _let_18)) (or (or _let_36 (not P8)) P1)) (or (or _let_80 _let_54) (not P8))) (or (or _let_54 _let_61) _let_33)) (or (or _let_75 _let_91) _let_58)) (or (or _let_36 _let_72) _let_34)) (or (or _let_68 P6) _let_59)) (or (or _let_45 _let_13) P2)) (or (or _let_51 _let_43) (< (f1_2 x2 x3) 7.0))) (or (or _let_76 _let_27) _let_93)) (or (or (< _let_5 4.0) (< _let_2 28.0)) _let_66)) (or (or _let_49 _let_89) (< (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8)) 21.0))) (or (or _let_88 (< x6 (/ (- 0 21) 1))) _let_89)) (or (or P3 _let_51) _let_67)) (or (or _let_52 P3) P9)) (or (or _let_43 _let_82) _let_37)) (or (or (not P0) (< (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8)) 21.0)) _let_86)) (or (or _let_39 _let_24) _let_55)) (or (or _let_98 _let_41) _let_68)) (or (or (not P3) _let_59) _let_86)) (or (or (< _let_2 28.0) _let_50) (< _let_8 (/ (- 0 9) 1)))) (or (or _let_40 _let_51) (not P5))) (or (or _let_46 _let_80) P1)) (or (or _let_65 _let_95) (not P7))) (or (or _let_24 _let_98) _let_93)) (or (or _let_96 (< _let_2 28.0)) _let_24)) (or (or (not P7) P8) _let_41)) (or (or _let_82 (not P5)) _let_22)) (or _let_99 (not P3))) (or (or _let_20 _let_16) P6)) (or _let_57 _let_44)) (or (or _let_77 _let_90) _let_48)) (or (or _let_61 (< _let_5 4.0)) _let_89)) (or (or P5 (not P7)) _let_45)) (or (or P2 _let_94) _let_35)) (or (or (< (f1_2 _let_3 _let_2) 1.0) _let_30) _let_88)) (or _let_74 _let_82)) (or _let_100 _let_77)) (or (or (not P3) _let_63) P0)) (or (or _let_14 _let_43) (not P6))) (or (or P6 (< _let_2 28.0)) _let_12)) (or (or _let_55 _let_42) _let_79)) (or (or _let_56 _let_62) _let_82)) (or _let_100 (not P7))) (or (or _let_24 P6) _let_54)) (or (or _let_52 _let_83) _let_45)) (or (or _let_36 _let_75) (< x6 (/ (- 0 21) 1)))) (or (or P9 P2) _let_64)) (or (or _let_18 _let_48) _let_84)) (or (or _let_41 _let_64) _let_39)) (or (or P0 _let_49) _let_82)) (or (or _let_67 _let_50) _let_88)) (or (or _let_41 _let_87) _let_67)) (or (or _let_41 _let_22) _let_69)) (or (or _let_55 (not P8)) _let_95)) (or (or _let_86 P2) P4)) (or (or _let_59 _let_22) _let_55)) (or (or _let_42 _let_68) _let_35)) (or (or _let_94 _let_38) (< (f1_2 x2 x3) 7.0))) (or (or P3 _let_82) _let_23)) (or (or (< _let_8 (/ (- 0 9) 1)) _let_47) _let_76)) (or (or _let_78 _let_96) (not P0))) (or (or _let_17 _let_40) P4)) (or (or P4 _let_59) (not P6))) (or (or _let_20 (not P4)) (< (+ (- _let_0 (* 20.0 x7)) (* 18.0 x6)) 2.0))) (or (or _let_33 _let_86) _let_51)) (or (or _let_32 _let_49) _let_75)) (or (or _let_84 (< (+ (- (* 16.0 (- (+ (* 16.0 x4) (* 3.0 x9)) (* 3.0 x8))) (* 14.0 (- (+ (* (/ (- 0 17) 1) x5) (* 4.0 x9)) (* 4.0 x3)))) (* 20.0 x1)) 24.0)) (not P0))) (or (or _let_34 P5) _let_11)) (or (or _let_50 _let_43) _let_54)) (or _let_53 P8)) (or (or _let_25 _let_61) (< x6 (/ (- 0 21) 1)))) (or (or _let_77 _let_92) _let_36)) (or (or _let_39 _let_19) _let_16)) (or (or _let_45 _let_34) _let_12)) (or (or _let_43 _let_71) _let_69)) (or (or _let_78 _let_12) P8)) (or (or _let_25 _let_89) P3)) (or (or (not P4) _let_26) _let_72)) (or (or _let_89 P6) _let_77)) (or (or (not P9) _let_71) _let_22)) (or (or _let_92 _let_79) _let_36)) (or (or (not _let_37) (not P3)) _let_29)) (or (or _let_27 _let_55) _let_37)) (or (or _let_13 P4) _let_80)) (or (or _let_42 (not P7)) _let_69)) (or (or _let_31 _let_46) _let_73)) (or (or _let_45 _let_18) _let_59)) (or (or _let_49 P4) P8)) (or (or _let_30 (< (f1_2 x2 x3) 7.0)) _let_51)) (or (or _let_85 _let_25) _let_45)) (or (or _let_90 _let_79) _let_20)) (or (or (not P7) _let_46) (< (f1_2 _let_3 _let_2) 1.0))) (or (or _let_65 _let_89) _let_70)) (or (or _let_36 _let_49) P8)) (or (or _let_79 _let_47) (< (f1_2 x2 x3) 7.0))) (or (or _let_41 _let_92) _let_50)) (or _let_99 _let_51)) (or (or _let_77 _let_33) _let_30)) (or (or _let_62 _let_70) _let_11)) (or (or P0 P5) _let_84)) (or (or _let_54 _let_11) _let_93)) (or (or (not P2) (not P1)) _let_43)) (or (or _let_54 _let_89) _let_56)) (or (or _let_87 _let_41) _let_24)) (or (or (< _let_9 0.0) _let_21) _let_38)) (or (or _let_25 _let_37) _let_72)) (or (or _let_54 _let_42) _let_11)) (or (or _let_77 (< _let_8 (/ (- 0 9) 1))) _let_37)) (or (or _let_11 _let_97) _let_29)) (or (or _let_42 P5) (not P8))) (or (or _let_40 _let_23) _let_28)) (or (or (not P5) _let_72) _let_66)) (or (or _let_26 _let_94) _let_52)) (or (or _let_79 _let_71) _let_98)) (or (or P7 _let_20) _let_51)) (or (or _let_14 _let_65) P4)) (or (or _let_11 P9) _let_51)) (or (or _let_82 _let_70) (not P3))) (or (or P2 _let_90) _let_15)) (or (or P5 _let_97) _let_48)) (or (or _let_79 _let_63) (not P5))) (or (or P3 _let_27) P7)) (or (or _let_44 _let_25) _let_20))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) ))
