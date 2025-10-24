;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname list_functions_1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;LISTS-------------------------
(define numbers (list 2 3 4 5 6))
(define strings (list "good" "bad" "good" "bad" "good" "good" "bad"))
(define long-strings (list "Nationality" "humor" "abracadabra" "pears" "trot" "pineapple" "boardwalk"))



(define (double-all lon)
  (cond
    [(empty? lon) empty]
    [else (cons (* (first lon) 2) (double-all (rest lon)))]))

(define (stringify lon)
  (cond
    [(empty? lon) ""]
    [(empty? (rest lon))(number->string (first lon))] 
    [else (string-append (number->string (first lon))  " " (stringify (rest lon)))]))

(define (santas-list-check los)
  (cond
    [(empty? los) 0]
    [(string=? (first los) "good") (+ 1 (santas-list-check (rest los)))]
    [else (+ 0 (santas-list-check (rest los)))]))

(define (remove-long-w los)
  (cond
    [(empty? los) ""]
    [(>= (string-length (first los)) 8) (remove-long-w (rest los))]
    [(empty? (rest los)) (first los)]
    [else (string-append (first los) " " (remove-long-w (rest los)))]))

(define (add-evens lon)
  (cond
    [(empty? lon) 0]
    [(odd? (first lon)) (+ 0 (add-evens (rest lon)))]
    [else (+ (first lon) (add-evens (rest lon)))]))

(define (squarify lon)
  (cond
    [(empty? lon) (square 0 'solid "blue")]
    [else (beside (square (first lon) 'solid "blue") (squarify (rest lon)))]))