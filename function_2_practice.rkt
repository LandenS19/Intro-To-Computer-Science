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
(define (collage a b c d)
  (above (beside a b) (beside c d)))


;5)
;shape: string -> image
(define (shape-maker name color)
  (cond
    [(string=? name "circle") (circle 50 'solid color)]
    [(string=? name "square") (square 25 'solid color)]
    [(string=? name "rectangle") (rectangle 50 30 'solid color)]
    [else (circle 50 'solid color)]))

;mood-color: string -> string
(define (mood-color mood)
  (cond
    [(string=? mood "sad") "blue"]
    [(string=? mood "mellow") "yellow"]
    [(string=? mood "happy") "orange"]
    [(string=? mood "angry") "red"]
    [else "pink"]))

;mood-viz: string, string -> image 
(define (mood-viz shape mood)
  (shape-maker shape (mood-color mood)))
