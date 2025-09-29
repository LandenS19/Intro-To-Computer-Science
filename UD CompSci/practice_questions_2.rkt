;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname practice_questions_2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Q1
; greeting-maker: string, string -> string

(define (greeting-maker firstname lastname)
  (string-append "Hello " firstname " G. " lastname))

;checks for the greeting-maker function
(check-expect (greeting-maker "Landen" "Summers") "Hello Landen G. Summers")

;Q2
; over-the-line: posn-> string

(define (over-the-line P)
  (if (> (posn-x P) 10)
      "Over the line"
      "Not over the line"))

;checks for the over-the-line function
(check-expect (over-the-line (make-posn 20 10)) "Over the line")
(check-expect (over-the-line (make-posn 5 10)) "Not over the line")

;Q3
; two-squares: number, number -> image

(define (two-squares s1 s2)
  (beside (square s1 'solid 'blue)
  (square s2 'solid 'red)))

;check for the two-squares function
(check-expect (two-squares 10 20)
              (beside (square 10 'solid 'blue)
                      (square 20 'solid 'red)))

