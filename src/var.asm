; =========
; VARIABLES
; =========

    .org $0010

; screen resolution: 256x240

; for each character, store:
; - position on screen
; - vertical velocity
; store vertical velocity as 8 fixed point number
char_1: .byte 128, 120, 0
char_2: .byte 128, 120, 0

; tile:    .byte 0
; counter: .byte 0
; step:    .byte 0

; declare variables with label: .byte 0,...