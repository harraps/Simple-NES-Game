
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


; define the overall structure of the script

    .include "src/macro.asm"
    .include "src/main.asm"
    .include "src/data.asm"

; NESASM macros:
; https://github.com/thentenaar/nesasm/blob/master/documentation/usage.txt