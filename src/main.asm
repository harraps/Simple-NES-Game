; ======
; BANK 0
; ======
; define start location of bank 0 at $c000 (hex)
    .bank 0    ; select bank 0

    ; declare variables
    .include "src/var.asm"

    ; start main programs
    .org $8000

; start of program code
RESET:
    sei ; disable IRQs
    cld ; disable decimal mode


; =============
; LOAD PALETTES
; =============
    set_ppu_addr $3f10

; Load the palette data
    ldx #$00
pal_loop:
    lda pal_data, x ; load data from src/data.asm
    sta PPU_DATA    ; write to PPU
    inx             ; 
    cpx #32         ; always load 32 colors
    bne pal_loop    ; while x != 16 -> loop


; ===============
; DRAW BACKGROUND
; ===============
    jsr draw_bg ; jump to src/draw_bg.asm
    

    ; TEST: draw a sprite
    draw_sprite 0, 50, 50, $64, %00000000
    draw_sprite 1, 58, 58, $64, %00000001
    draw_sprite 2, 66, 66, $64, %00000010
    draw_sprite 3, 74, 74, $64, %00000011

; =======
; SET PPU
; =======
;     7 =   1: Execute NMI on VBlank
;     6 =   0: PPU Selection is unused
;     5 =   0: Sprite Size is 8x8
;     4 =   1: Background Pattern Table Address is $1000
;     3 =   0: Sprite     Pattern Table Address is $0000
;     2 =   0: PPU address increment is 1
;   1,0 =  00: Name Table Address is $2000
    lda #%10010000 ; 
    sta PPU_CTRL   ; put in PPU Ctrl Reg #1

    ; fixes the negative scroll
    lda #$00
    sta PPU_SCRL
    sta PPU_SCRL

; 7,6,5 = 000: Full Background Color is black
;     4 =   1: Display Sprites
;     3 =   1: Display Background
;     2 =   1: No Sprite     Clipping
;     1 =   1: No Background Clipping
;     0 =   0: Color Display
    lda #%00011110 ; 
    sta PPU_MASK   ; put in PPU Ctrl Reg #2

; once the initialization process is done,
; the program will be stuck in this loop 
; until the NMI is called 60 times per second
forever:
    jmp forever

;;; we can define blocks of instructions here
;;; we just need to define a label to start the block
;;; and an other to go back into the main block


    .include "src/draw_bg.asm"


; =================
; LOAD PICTURE DATA
; =================
; transfer picture data from CPU memory to PPU memory
NMI:
    lda #$00     ; 
    sta OAM_ADDR ; set low  byte of RAM address
    lda #$02     ; 
    sta OAM_DMA  ; set high byte of RAM address (start transfer)

    ;; real-time code is here
    .include "src/update.asm"

    rti ; return from interrupt




