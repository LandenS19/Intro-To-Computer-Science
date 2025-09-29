;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Arithmetic_With_Strings_HW_1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;Make a Palindrome
;palindrome: string->string

(define (palindrome half-palindrome)
  (string-append half-palindrome
                 (list->string(reverse (string->list(substring half-palindrome 0 2)))))) ;reverses the first to letters of the given string

;Half a Palindrome
;last-half: string->string

(define (last-half palindrome)
  (substring palindrome (/ (- (string-length palindrome) 1) 2)))

;Big Word, Big Oval
;text-oval: string->image

(define (text-oval word) (place-image (text word 15 "black") ;takes a string input
             (* 5 (string-length word)) 50 ;uses the string length to position the word in the center
             (ellipse (* 10 (string-length word)) 100 "solid" "grey"))) ;makes an oval using the length of the string as the width