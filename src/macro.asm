; =========
; CONSTANTS
; =========

; IRQ addresses
APU_IRQ = $4017
DMC_IRQ = $4010

; PPU addresses
PPU_CTRL = $2000
PPU_MASK = $2001
PPU_STAT = $2002
PPU_SCRL = $2005
PPU_ADDR = $2006
PPU_DATA = $2007

; OAM addresses
OAM_ADDR = $2003
OAM_DATA = $2004
OAM_DMA  = $4014

; controllers addresses
JOYPAD_1 = $4016
JOYPAD_2 = $4017

; sprite addresses
SPR_ADDR   = $0200
SPR_ADDR_Y = $0200 ; y position
SPR_ADDR_S = $0201 ; sprite to use
SPR_ADDR_A = $0202 ; attributes
SPR_ADDR_X = $0203 ; x position

; ======
; MACROS
; ======

; store address at specified location
; param: value to store, address to set
set_addr .macro
    lda #high(\1)
    sta \2
    lda #low(\1)
    sta \2
    .endm

; set address of PPU
; param: address to set
set_ppu_addr .macro
    lda PPU_STAT ; set latch to high
    lda #high(\1)
    sta PPU_ADDR
    lda #low(\1)
    sta PPU_ADDR
    .endm


; ==============
; GAME CONSTANTS
; ==============

WALL_TOP    = $20
WALL_BOTTOM = $e0
WALL_LEFT   = $04
WALL_RIGHT  = $f4

CENTER_X = $80
CENTER_Y = $80

; TODO: remove
; draw sprite at location
; 1: sprite to set (0 - 64)
; 2: x position
; 3: y position
; 4: sprite to use
; 5: attributes
draw_sprite .macro
    lda #\3
    sta SPR_ADDR_Y + (\1 << 2)
    lda #\4
    sta SPR_ADDR_S + (\1 << 2)
    lda #\5
    sta SPR_ADDR_A + (\1 << 2)
    lda #\2
    sta SPR_ADDR_X + (\1 << 2)
    .endm
    ; ( <<2 is an optimized *4)