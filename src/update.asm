; ======
; UPDATE
; ======

    ; set sprite position
    lda char_1
    sta SPR_ADDR_X
    lda char_1 + 1
    sta SPR_ADDR_Y

    ; apply vertical velocity
    lda char_1 + 1
    adc char_1 + 2
    sta char_1 + 1

    ; when character is on the ground
    lda char_1 + 1
    cmp #WALL_BOTTOM
    bcs stay_on_ground

    ; apply gravity
    lda char_1 + 2
    cmp #GRAVITY
    beq apply_gravity_done ; do not apply gravity when velocity == 4
    adc #1
    sta char_1 + 2
apply_gravity_done:
    jmp update_done


; set the velocity to zero
stay_on_ground:
    lda #WALL_BOTTOM
    sta char_1 + 1


update_done: