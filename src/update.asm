; ======
; UPDATE
; ======

; set sprite position
set_sprite_position .macro
    ; horizontal
    lda \1
    sta SPR_ADDR_X +  0 + \2
    sta SPR_ADDR_X +  8 + \2
    adc #7
    sta SPR_ADDR_X +  4 + \2
    sta SPR_ADDR_X + 12 + \2
    ; vertical
    lda \1 + 1
    sta SPR_ADDR_Y +  0 + \2
    sta SPR_ADDR_Y +  4 + \2
    adc #7
    sta SPR_ADDR_Y +  8 + \2
    sta SPR_ADDR_Y + 12 + \2
    .endm

    ; update player 1 & player 2
    set_sprite_position char_2,  0
    set_sprite_position char_1, 16

    jmp update_done

; put sub-process here...

update_done: