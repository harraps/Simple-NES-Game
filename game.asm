
; name:   game
; author: Olivier Schyns
; desc:   simple two player platformer game

; ======
; HEADER
; ======
; at the beginning, define banks to use
    .inesprg 1 ; one program bank (16KB)
    .ineschr 1 ; one picture bank ( 8KB)
    .inesmir 2 ; single screen
    .inesmap 0 ; use Mapper 0, no bank swapping

; =========
; CONSTANTS
; =========

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

; sprite addresses
SPR_ADDR_Y = $0200 ; y position
SPR_ADDR_S = $0201 ; sprite to use
SPR_ADDR_A = $0202 ; attributes
SPR_ADDR_X = $0203 ; x position

; ======
; MACROS
; ======

; set address of PPU
; param: address to set
set_ppu_addr .macro
    lda PPU_STAT ; set latch to high
    lda #high(\1)
    sta PPU_ADDR
    lda #low(\1)
    sta PPU_ADDR
    .endm

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



; define the overall structure of the script

    .include "src/main.asm"
    .include "src/data.asm"

; NESASM macros:
; https://github.com/thentenaar/nesasm/blob/master/documentation/usage.txt