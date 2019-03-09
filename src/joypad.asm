; ==============
; MANAGE JOYPADS
; ==============

    ; tells both joypad to latch buttons
    ; read inputs of both controllers
    set_addr $0100, JOYPAD_1

; allow to handle axis inputs for both players
handle_axis .macro
    ldx \2 ; prepare vertical position

    lda \1 ; negative button (UP, LEFT)
    and #%00000001
    beq .read_joy_neg_done\@
    dex
    stx \2
.read_joy_neg_done\@:

    lda \1 ; positive button (DOWN, RIGHT)
    and #%00000001
    beq .read_joy_pos_done\@
    inx
    stx \2
.read_joy_pos_done\@:
    .endm

    ; joypad player 1

    lda JOYPAD_1 ; A
    and #%00000001
    beq read_joy1_A_done ; skip process if button is not pressed
read_joy1_A_done: ; finish reading this button

    lda JOYPAD_1 ; B
    lda JOYPAD_1 ; SELECT
    lda JOYPAD_1 ; START

    handle_axis JOYPAD_1, char_1 + 1
    handle_axis JOYPAD_1, char_1

    ; joypad player 2

    lda JOYPAD_2 ; A
    and #%00000001
    beq read_joy2_A_done ; skip process if button is not pressed
read_joy2_A_done: ; finish reading this button

    lda JOYPAD_2 ; B
    lda JOYPAD_2 ; SELECT
    lda JOYPAD_2 ; START

    handle_axis JOYPAD_2, char_2 + 1
    handle_axis JOYPAD_2, char_2