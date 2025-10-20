;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname In-class-pong) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct WS [Ball-1 Ball-2 paddle-y paddle2-y score score-2])
(define-struct ball [x y x-direction y-direction])

(define WIDTH 900)
(define HEIGHT 700)
(define b-rad 10)
(define PADDLE-X 20)
(define PADDLE2-X (- WIDTH 20))
(define paddle-width 10)
(define paddle-height 100)
(define player-speed 30)
(define BALL-SPEED-X 10)
(define BALL-SPEED-Y 10)
(define MONEYBALL (overlay (text "$" (* b-rad 2) 'gold) (circle b-rad 'solid 'lightgreen)))
(define PADDLE-IMAGE (rectangle paddle-width paddle-height 'solid 'black))
(define GAME-BOARD (rectangle WIDTH HEIGHT 'solid 'darkgreen))

; WorldState -> Image 
(define (render ws)
  (if (and (>= (+ (WS-score ws) (WS-score-2 ws)) 5) (>= (ball-x (WS-Ball-2 ws)) 0) (<= (ball-x (WS-Ball-2 ws)) WIDTH)) ;If the moneyball is active
      (place-image MONEYBALL (ball-x (WS-Ball-2 ws)) (ball-y (WS-Ball-2 ws))
                   (place-image (text (string-append "P1 Score: " (number->string (WS-score ws))) 44 'white)
                                120
                                30
                                (place-image (text (string-append "P2 Score: " (number->string (WS-score-2 ws))) 44 'white)
                                             (- WIDTH 120)
                                             30
                                             (place-image PADDLE-IMAGE
                                                          PADDLE-X
                                                          (WS-paddle-y ws)
                                                          (place-image PADDLE-IMAGE PADDLE2-X (WS-paddle2-y ws)
                                                                       (place-image (circle b-rad 'solid 'white) (ball-x (WS-Ball-1 ws)) (ball-y (WS-Ball-1 ws)) GAME-BOARD))))))
        
      (place-image (text (string-append "P1 Score: " (number->string (WS-score ws))) 44 'white)
                   120
                   30
                   (place-image (text (string-append "P2 Score: " (number->string (WS-score-2 ws))) 44 'white)
                                (- WIDTH 120)
                                30
                                (place-image PADDLE-IMAGE
                                             PADDLE-X
                                             (WS-paddle-y ws)
                                             (place-image PADDLE-IMAGE PADDLE2-X (WS-paddle2-y ws)
                                                          (place-image (circle b-rad 'solid 'white) (ball-x (WS-Ball-1 ws)) (ball-y (WS-Ball-1 ws)) GAME-BOARD)))))))

; WorldState, key-event -> WorldState 
(define (key-handler ws a-key)
  (cond
    [(string=? a-key "w")
     (if (>= (WS-paddle-y ws) (/ paddle-height 2))
         (make-WS
          (WS-Ball-1 ws)
          (WS-Ball-2 ws)
          (- (WS-paddle-y ws) player-speed)
          (WS-paddle2-y ws)
          (WS-score ws)
          (WS-score-2 ws))
         ws)]
                                
    [(string=? a-key "s")
     (if (<= (WS-paddle-y ws) (- HEIGHT (/ paddle-height 2)))
         (make-WS
          (WS-Ball-1 ws)
          (WS-Ball-2 ws)
          (+ (WS-paddle-y ws) player-speed)
          (WS-paddle2-y ws)
          (WS-score ws)
          (WS-score-2 ws))
         ws)]

    [(string=? a-key "up")
     (if (>= (WS-paddle2-y ws) (/ paddle-height 2))
         (make-WS
          (WS-Ball-1 ws)
          (WS-Ball-2 ws)
          (WS-paddle-y ws)
          (- (WS-paddle2-y ws) player-speed)
          (WS-score ws)
          (WS-score-2 ws))
         ws)]

    [(string=? a-key "down")
     (if (<= (WS-paddle2-y ws) (- HEIGHT (/ paddle-height 2)))
         (make-WS
          (WS-Ball-1 ws)
          (WS-Ball-2 ws)
          (WS-paddle-y ws)
          (+ (WS-paddle2-y ws) player-speed)
          (WS-score ws)
          (WS-score-2 ws))
         ws)]
  
    [else ws]))

;=====================================================================================================
;Collision Checks
;=====================================================================================================

(define (hit-bottom-wall y)        ;Hit Bottom wall Check
  (>= y (- HEIGHT (* b-rad 2))))

(define (hit-top-wall y)           ;Hit Top wall Check
  (<= y (+ 0 (* b-rad 2))))

(define (hit-player x y py)        ;Hit Player 1 Check
  (and (<= x (+ (+ (/ paddle-width 2) PADDLE-X) (* b-rad 2))) (>= x (+ (/ paddle-width 2) PADDLE-X))
       (>= y (- py (/ paddle-height 2))) (<= y (+ py (/ paddle-height 2)))))

(define (hit-player2 x y py)       ;Hit Player 2 Check
  (and (>= x (- (- PADDLE2-X (/ paddle-width 2)) (* b-rad 2))) (<= x (- PADDLE2-X (/ paddle-width 2)))
       (>= y (- py (/ paddle-height 2))) (<= y (+ py (/ paddle-height 2)))))

;======================================================================================================

(define (tock ws)
  (cond
    
    
    ((hit-top-wall (ball-y (WS-Ball-1 ws))) ;Hit top wall Ball-1
     (make-WS
      (make-ball
       (ball-x (WS-Ball-1 ws))
       (+ (ball-y (WS-Ball-1 ws)) BALL-SPEED-Y)
       (ball-x-direction (WS-Ball-1 ws))
       (* (ball-y-direction (WS-Ball-1 ws)) -1))
      (WS-Ball-2 ws)
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws)
      (WS-score-2 ws)))
    
    ((hit-top-wall (ball-y (WS-Ball-2 ws))) ;Hit top wall Ball-2
     (make-WS
      (WS-Ball-1 ws)
      (make-ball
       (ball-x (WS-Ball-2 ws))
       (+ (ball-y (WS-Ball-2 ws)) BALL-SPEED-Y)
       (ball-x-direction (WS-Ball-2 ws))
       (* (ball-y-direction (WS-Ball-2 ws)) -1))
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws)
      (WS-score-2 ws)))
     
    [(hit-bottom-wall (ball-y (WS-Ball-1 ws))) ;Hit bottom wall Ball-1
     (make-WS
      (make-ball
       (ball-x (WS-Ball-1 ws))
       (- (ball-y (WS-Ball-1 ws)) BALL-SPEED-Y)
       (ball-x-direction (WS-Ball-1 ws))
       (* (ball-y-direction (WS-Ball-1 ws)) -1))
      (WS-Ball-2 ws)
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws)
      (WS-score-2 ws))]

    [(hit-bottom-wall (ball-y (WS-Ball-2 ws))) ;Hit bottom wall Ball-2
     (make-WS
      (WS-Ball-1 ws)
      (make-ball
       (ball-x (WS-Ball-2 ws))
       (- (ball-y (WS-Ball-2 ws)) BALL-SPEED-Y)
       (ball-x-direction (WS-Ball-2 ws))
       (* (ball-y-direction (WS-Ball-2 ws)) -1))
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws)
      (WS-score-2 ws))]
    
    [(hit-player (ball-x (WS-Ball-1 ws)) (ball-y (WS-Ball-1 ws)) (WS-paddle-y ws))     ;Hit player-1 Ball-1 
     (make-WS
      (make-ball
       (+ (ball-x (WS-Ball-1 ws)) BALL-SPEED-X)
       (ball-y (WS-Ball-1 ws))
       (* (ball-x-direction (WS-Ball-1 ws)) -1)
       (ball-y-direction (WS-Ball-1 ws)))
      (WS-Ball-2 ws)
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (+ (WS-score ws) 1)
      (WS-score-2 ws))]
    
    [(hit-player (ball-x (WS-Ball-2 ws)) (ball-y (WS-Ball-2 ws)) (WS-paddle-y ws))     ;Hit player-1 Ball-2
     (make-WS
      (WS-Ball-1 ws)
      (make-ball
       (+ (ball-x (WS-Ball-2 ws)) BALL-SPEED-X)
       (ball-y (WS-Ball-2 ws))
       (* (ball-x-direction (WS-Ball-2 ws)) -1)
       (ball-y-direction (WS-Ball-2 ws)))
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (+ (WS-score ws) 5)
      (WS-score-2 ws))]

    [(hit-player2 (ball-x (WS-Ball-1 ws)) (ball-y (WS-Ball-1 ws)) (WS-paddle2-y ws))     ;Hit player-2 Ball-1 
     (make-WS
      (make-ball
       (- (ball-x (WS-Ball-1 ws)) BALL-SPEED-X)
       (ball-y (WS-Ball-1 ws))
       (* (ball-x-direction (WS-Ball-1 ws)) -1)
       (ball-y-direction (WS-Ball-1 ws)))
      (WS-Ball-2 ws)
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws)
      (+ (WS-score-2 ws) 1))]

    [(hit-player2 (ball-x (WS-Ball-2 ws)) (ball-y (WS-Ball-2 ws)) (WS-paddle2-y ws))     ;Hit player-2 Ball-2
     (make-WS
      (WS-Ball-1 ws)
      (make-ball
       (- (ball-x (WS-Ball-2 ws)) BALL-SPEED-X)
       (ball-y (WS-Ball-2 ws))
       (* (ball-x-direction (WS-Ball-2 ws)) -1)
       (ball-y-direction (WS-Ball-2 ws)))
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws) 
      (+ (WS-score-2 ws) 5))]
    
    (else                        ;Constant state outside of collisions  
     (make-WS
      ;Ball-1 WS --------------------------------------------------------------------------
      (make-ball
       (+ (ball-x (WS-Ball-1 ws)) (* BALL-SPEED-X (ball-x-direction (WS-Ball-1 ws))))
       (+ (ball-y (WS-Ball-1 ws)) (* BALL-SPEED-Y (ball-y-direction (WS-Ball-1 ws))))
       (ball-x-direction (WS-Ball-1 ws))
       (ball-y-direction (WS-Ball-1 ws)))
      ;Ball-2 WS --------------------------------------------------------------------------
      (if (and (>= (+ (WS-score ws) (WS-score-2 ws)) 5) (>= (ball-x (WS-Ball-2 ws)) 0) (<= (ball-x (WS-Ball-2 ws)) WIDTH))
          (make-ball
           (+ (ball-x (WS-Ball-2 ws)) (* BALL-SPEED-X (ball-x-direction (WS-Ball-2 ws))))
           (+ (ball-y (WS-Ball-2 ws)) (* BALL-SPEED-Y (ball-y-direction (WS-Ball-2 ws))))
           (ball-x-direction (WS-Ball-2 ws))
           (ball-y-direction (WS-Ball-2 ws)))
          (WS-Ball-2 ws))
      ;------------------------------------------------------------------------------------
      (WS-paddle-y ws)
      (WS-paddle2-y ws)
      (WS-score ws)
      (WS-score-2 ws)
      ))
    ))


(define (done ws)
  (if (or (<= (ball-x (WS-Ball-1 ws)) 5) (>= (ball-x (WS-Ball-1 ws)) WIDTH))
      true false))

(define (game-over ws)
  (place-images
   (list (text (string-append "Player 1 Score: " (number->string (WS-score ws))) 30 'white)
         (text (string-append "Player 2 Score: " (number->string (WS-score-2 ws))) 30 'white)
         (cond
           [(> (WS-score ws) (WS-score-2 ws))
            (text "PLAYER 1 WINS!" 30 'white)]
           [(< (WS-score ws) (WS-score-2 ws))
            (text "PLAYER 2 WINS!" 30 'white)]
           [(= (WS-score ws) (WS-score-2 ws))
            (text "TIE!" 30 'white)]))
   (list
    (make-posn (- (/ WIDTH 2) 150) (/ HEIGHT 2))
    (make-posn (+ (/ WIDTH 2) 150) (/ HEIGHT 2))
    (make-posn (/ WIDTH 2) (- (/ HEIGHT 2) 50)))
   GAME-BOARD))

(define (main ws)
  (big-bang ws
    (to-draw render)
    (on-key key-handler)
    (on-tick tock)
    (stop-when done game-over)))

(define BALL1-INIT (make-ball (/ WIDTH 4) (/ HEIGHT 2) 1 1))
(define BALL2-INIT (make-ball (/ WIDTH 4) (/ HEIGHT 2) 1 1))
(define INITIAL-WORLD (make-WS BALL1-INIT BALL2-INIT (/ HEIGHT 2) (/ HEIGHT 2) 0 0))

(main INITIAL-WORLD)