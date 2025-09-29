;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname structures_finger_exercises) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct posn3 [x y z])

;posn3-average: struct-> number
(define (posn3-average posn3)
  (/ (+ (posn3-x posn3) (posn3-y posn3) (posn3-z posn3)) 3))
 
;Check for the function posn3-average
(check-expect (posn3-average (make-posn3 5 2 2)) 3)

;Interpretation: (Mario's x, Mario's y, Player score)
(define-struct WS [x y score])

;move-right: struct-> struct
(define (move-right WS)
  (make-WS
   (+ (WS-x WS) 30)
   (WS-y WS)
   (WS-score WS)))

;Check for the move-right function
(check-expect (move-right (make-WS 10 10 0)) (make-WS 40 10 0))
