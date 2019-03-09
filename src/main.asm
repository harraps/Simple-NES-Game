; ======
; BANK 0
; ======
; define start location of bank 0 at $c000 (hex)
    .bank 0    ; select bank 0

    ; declare variables
    .include "src/var.asm"

    ; start main programs
    .org $8000

; ==============
; INITIALIZATION
; ==============
RESET:           ; start of program
    sei          ; disable IRQs
    cld          ; disable decimal mode
    ldx #$40     ; 
    stx APU_IRQ  ; disable APU frame IRQ
    ldx #$ff     ; 
    txs          ; set up stack
    inx          ; > x == 0
    stx PPU_CTRL ; disable NMI
    stx PPU_MASK ; disable rendering
    stx DMC_IRQ  ; disable DMC IRQs

vblank_wait1: ; first wait for vblank
    bit PPU_STAT
    bpl vblank_wait1

clear_memory:
    lda #0
    sta $0000, x
    sta $0100, x
    sta $0200, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x
    lda #$fe
    sta SPR_ADDR_Y, x ; move all sprites off screen
    inx
    bne clear_memory

vblank_wait2: ; second wait for vblank, PPU is ready
    bit PPU_STAT
    bpl vblank_wait2


; =============
; LOAD PALETTES
; =============
    set_ppu_addr $3f10

; Load the palette data
    ldx #0
pal_loop:
    lda pal_data, x ; load data from src/data.asm
    sta PPU_DATA    ; write to PPU
    inx             ; 
    cpx #32         ; always load 32 colors
    bne pal_loop    ; while x != 16 -> loop


; ============
; LOAD SPRITES
; ============
    ldx #0
spr_loop:
    lda spr_data, x
    sta SPR_ADDR_Y, x
    inx
    cpx #32
    bne spr_loop

; ===============
; LOAD BACKGROUND
; ===============
    .include "src/draw_bg.asm"

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

; =================
; LOAD PICTURE DATA
; =================
; transfer picture data from CPU memory to PPU memory
NMI:
    lda #$00     ; 
    sta OAM_ADDR ; set low  byte of RAM address
    lda #$02     ; 
    sta OAM_DMA  ; set high byte of RAM address (start transfer)

    ; game loop is defined here
    .include "src/joypad.asm"
    .include "src/update.asm"

    rti ; return from interrupt




