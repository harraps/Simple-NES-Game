; =========
; VARIABLES
; =========

    .org $0010

; screen resolution: 256x240

; for each character, store:
; - position on screen
; - sprites to display
char_1: .byte CENTER_X, CENTER_Y, 0
char_2: .byte CENTER_X, CENTER_Y, 0

; tile:    .byte 0
; counter: .byte 0
; step:    .byte 0

; declare variables with label: .byte 0,...