;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname First_Functions_HW_1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;Square a number
;my-square: number->number

(define (my-square x) (sqr x))

;Volume of a Box
; volume: number, number, number->number
(define (volume x y z) (* x y z))

;Average
;average: number, number->number

(define (average x y) (/ (+ x y) 2))

;Distance
;distance: number, number, number, number->number

(define (distance a b c d) (sqrt (+ (sqr (- c a)) (sqr (- b d)))))

;Washer
;washer: number, number-> image
(define (washer a b) 
  (place-image (circle b 'solid "White")
               a a
               (circle a 'solid "Blue")))