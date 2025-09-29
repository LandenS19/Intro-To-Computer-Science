;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname function_2_practice) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;distance-from-origin: posn -> number
(define (distance-from-origin P)
  (sqrt (+ (sqr (posn-x P)) (sqr (posn-y P)))))

;bigger: number, number -> number
(define (bigger a b)
  (if (> a b) a b))

;bigger-3: number, number, number -> number
(define (bigger-3 a b c)
  (if (and (> a b) (> a c))
      a
      (if (and (> b a) (> b c))
          b c)))

;collage: image, image, image, image -> image


;mood-viz function, string -> image
;(define (mood-viz shape mood)
;  ())