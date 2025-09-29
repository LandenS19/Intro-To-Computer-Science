;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname simple-racket-game) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;World Struct: (World Time, Raindrop X, Raindrop Y
(define-struct WS (time x y score lives is-living clicked-state clicked-time))

(define WORLD (overlay/align "middle" "bottom"                                ;The Background for the world with the ground
                              GROUND-SCALED
                              (rectangle W-WIDTH W-HEIGHT 'solid "skyblue")))











(define (main ws-init)
  (big-bang ws-init
    [to-draw ...]
    [on-tick tock]
    [on-mouse ...]
    [on-key ...]
    [stop-when ...]))