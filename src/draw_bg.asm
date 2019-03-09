; draw tiles and choose their attributes
; to draw the map on the screen

; screen resolution is 256x240 pixels
; => 32 x 30 tiles

; ===========
; PLACE TILES
; ===========
    set_ppu_addr $2000

    ; TEST: draw zzzz...
    ldx #0
    lda #$23
loop_tile:
    sta PPU_DATA
    inx
    cpx #255
    bne loop_tile

; ===============
; SET ATTRIBUTES
; ===============
    set_ppu_addr $23c0

    ; set all tiles to palette 0
    ; (each byte encode the colors for 4 tiles)
    ldx #0
    lda #%00000000
loop_attr:
    sta PPU_DATA
    inx
    cpx #(64 - 8)
    bne loop_attr
