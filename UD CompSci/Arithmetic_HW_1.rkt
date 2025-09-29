;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Arithmetic_HW_1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;Add the numbers

(define (add x y) (+ x y)) 



;Move the Bullet

(define (bullet x_initial v)   ;Draws the bullet on a white background using the result of the movement function
  (place-image
   (circle 2 'solid "red")
   (movement x_initial v) 0
   (empty-scene 50 50)))

(define (movement x_initial v)  ;Finds the movement value of the bullet
  (+ x_initial (* v 2)))

;Big Number, Small Square

(define (draw-square n r) (square (make-square n r) 'solid "BLUE")) ;Draws the square

(define (make-square n r) (* r (sqrt (- 105 n))))  ;Finds the side length of the square
