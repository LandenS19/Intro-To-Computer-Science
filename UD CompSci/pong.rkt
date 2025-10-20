;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname pong) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;World Struct 
(define-struct WS (ballX ballY Xdirection Ydirection playerY score))

;World Bounds Variables
(define W-WIDTH 800)
(define W-HEIGHT 500)

;Image Componets
(define PLAYER-WIDTH (/ W-WIDTH 100))
(define PLAYER-HEIGHT (/ W-HEIGHT 5))
(define PLAYER (rectangle PLAYER-WIDTH PLAYER-HEIGHT 'solid "white"))
(define PLAYER-X 15)
(define BALL-SIZE 20)
(define BALL (circle BALL-SIZE 'solid "white"))
(define BALL-OUTLINE (circle (+ 2 BALL-SIZE) 'solid "orange"))
(define BALL-INIT (make-posn (+ (random (- W-WIDTH 400)) 200) (random W-HEIGHT)))
(define BACKGROUND (rectangle W-WIDTH W-HEIGHT 'solid "black"))
(define TEXT-SIZE 75)

;Game Componets   
(define BALL-SPEED-X (+ 5 (random 8)))
(define BALL-SPEED-Y (+ 3 (random 8)))
(define PLAYER-HITBOX-X (/ PLAYER-WIDTH 2))
(define PLAYER-HITBOX-Y (/ PLAYER-HEIGHT 2))

(define WS-INIT (make-WS (posn-x BALL-INIT) (posn-y BALL-INIT) 1 1 250 0))


(define (render ws)
  (place-images
   (list
    BALL
    BALL-OUTLINE
    PLAYER
    (text (number->string (WS-score ws)) TEXT-SIZE "white"))
   (list
    (make-posn (WS-ballX ws) (WS-ballY ws))
    (make-posn (WS-ballX ws) (WS-ballY ws))
    (make-posn PLAYER-X (WS-playerY ws))
    (make-posn (/ W-WIDTH 2) (/ W-HEIGHT 2)))
   BACKGROUND))

(define (hit-player x y py)
  (and (<= x (+ PLAYER-X (* BALL-SIZE 2))) (>= x PLAYER-X)
       (>= y (- py (/ PLAYER-HEIGHT 2))) (<= y (+ py (/ PLAYER-HEIGHT 2)))))

(define (hit-right-wall x)
  (>= x (- W-WIDTH (* BALL-SIZE 2))))

(define (hit-bottom-wall y)
  (>= y (- W-HEIGHT (* BALL-SIZE 2))))

(define (hit-top-wall y)
  (<= y (+ 0 (* BALL-SIZE 2))))

(define (tock ws)
  (cond
    
    [(hit-player (WS-ballX ws) (WS-ballY ws) (WS-playerY ws))
     (make-WS
      (+ (WS-ballX ws) BALL-SPEED-X)
      (WS-ballY ws)
      (* (WS-Xdirection ws) -1)
      (WS-Ydirection ws)
      (WS-playerY ws)
      (+ (WS-score ws) 1))]
    
    [(hit-right-wall (WS-ballX ws))
     (make-WS
      (- (WS-ballX ws) BALL-SPEED-X)
      (WS-ballY ws)
      (* (WS-Xdirection ws) -1)
      (WS-Ydirection ws)
      (WS-playerY ws)
      (WS-score ws))]
    
    [(hit-bottom-wall (WS-ballY ws))
     (make-WS
      (WS-ballX ws)
      (- (WS-ballY ws) BALL-SPEED-Y)
      (WS-Xdirection ws)
      (* (WS-Ydirection ws) -1)
      (WS-playerY ws)
      (WS-score ws))]

    [(hit-top-wall (WS-ballY ws))
     (make-WS
      (WS-ballX ws)
      (+ (WS-ballY ws) BALL-SPEED-Y)
      (WS-Xdirection ws)
      (* (WS-Ydirection ws) -1)
      (WS-playerY ws)
      (WS-score ws))]
       
    [else
     (make-WS
      [+ (WS-ballX ws) (* BALL-SPEED-X (WS-Xdirection ws))]
      [+ (WS-ballY ws) (* BALL-SPEED-Y (WS-Ydirection ws))]
      [WS-Xdirection ws]
      [WS-Ydirection ws]
      [WS-playerY ws]
      [WS-score ws])]))



(define (key ws ke)
  (cond
    [(and (or (key=? ke "up") (key=? ke "w")) (>= (WS-playerY ws) (+ 0 (/ PLAYER-HEIGHT 2))))
     (make-WS
      [WS-ballX ws]
      [WS-ballY ws]
      [WS-Xdirection ws]
      [WS-Ydirection ws]
      [- (WS-playerY ws) 15]
      [WS-score ws])]
    [(and (or (key=? ke "down") (key=? ke "s")) (<= (WS-playerY ws) (- W-HEIGHT (/ PLAYER-HEIGHT 2))))
     (make-WS
      [WS-ballX ws]
      [WS-ballY ws]
      [WS-Xdirection ws]
      [WS-Ydirection ws]
      [+ (WS-playerY ws) 15]
      [WS-score ws])]
    [else ws]))

(define (out ws)
  (if (<= (WS-ballX ws) 0) true false))

(define (game-over ws)
  (place-images
   (list
    (text (number->string (WS-score ws)) TEXT-SIZE "white")
    (text "GAME OVER" TEXT-SIZE "RED"))
   (list
    (make-posn (/ W-WIDTH 2) (/ W-HEIGHT 2))
    (make-posn (/ W-WIDTH 2) (- (/ W-HEIGHT 2) TEXT-SIZE)))
   BACKGROUND))


(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-key key]
    [on-tick tock]
    [stop-when out game-over]
    ))
(main WS-INIT)