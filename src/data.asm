; ======
; BANK 1
; ======
; add three interrupts in bank 1
    .bank 1
    .org  $e000

; ============
; PALETTE DATA
; ============
; define colors of palettes
pal_data:
    ; sprite palette:
    .byte $0f,$0c,$16,$30 ; 0: marine
    .byte $0f,$08,$2a,$38 ; 1: jungle
    .byte $0f,$07,$2d,$3d ; 2: rust
    .byte $0f,$11,$23,$34 ; 3: aesthetic
    ; background palette:
    .byte $0f,$0c,$16,$30 ; 0: marine
    .byte $0f,$08,$2a,$38 ; 1: jungle
    .byte $0f,$07,$2d,$3d ; 2: rust
    .byte $0f,$11,$23,$34 ; 3: aesthetic

; ===========
; SPRITE DATA
; ===========
; define sprites animations
spr_data:
    .byte CENTER_Y,$32,%00000001,CENTER_X ; sprite 0
    .byte CENTER_Y,$33,%00000001,CENTER_X ; sprite 1
    .byte CENTER_Y,$42,%00000001,CENTER_X ; sprite 2
    .byte CENTER_Y,$43,%00000001,CENTER_X ; sprite 3

    .byte CENTER_Y,$32,%00000010,CENTER_X ; sprite 4
    .byte CENTER_Y,$33,%00000010,CENTER_X ; sprite 5
    .byte CENTER_Y,$42,%00000010,CENTER_X ; sprite 6
    .byte CENTER_Y,$43,%00000010,CENTER_X ; sprite 7

; other data can be defined here

    .org  $fffA
    .word NMI   ; location of NMI Interrupt
    .word RESET ; code to run at reset (LABEL defined in bank 0)
    .word 0     ; location of VBlank Interrupt

; ======
; BANK 2
; ======
; add picture data in bank 2
    .bank   2
    .org    $0000
    .incbin "data/mario.chr" ; test sprite sheet
    ; .incbin "data/foreground.chr" ; load foreground picture data ($0000)
    ; .incbin "data/background.chr" ; load background picture data ($1000)