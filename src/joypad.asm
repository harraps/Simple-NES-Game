; ==============
; MANAGE JOYPADS
; ==============

    ; tells both joypad to latch buttons
    set_addr $0100, JOYPAD

    lda JOYPAD ; A
    and #%00000001
    beq read_joy1_A_done ; skip process if button is not pressed
    lda char_1 + 1
    cmp #WALL_BOTTOM
    bne read_joy1_A_done ; skip process if not on ground
    lda #JUMP_FORCE
    sta char_1 + 2
read_joy1_A_done: ; finish reading this button

    lda JOYPAD ; B
    lda JOYPAD ; SELECT
    lda JOYPAD ; START
    lda JOYPAD ; UP
    lda JOYPAD ; DOWN

    ; prepare horizontal position
    ldx char_1

    ; read inputs of both controllers
    lda JOYPAD ; LEFT
    and #%00000001
    beq read_joy1_left_done ; skip process if button is not pressed
    dex
    stx char_1
read_joy1_left_done: ; finish reading this button

    lda JOYPAD ; RIGHT
    and #%00000001
    beq read_joy1_right_done ; skip process if button is not pressed
    inx
    stx char_1
read_joy1_right_done: ; finish reading this button
