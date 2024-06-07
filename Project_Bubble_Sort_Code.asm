; LC-3 Bubble Sort Program for 8 numbers

.ORIG x3000

; Storage allocation
ARRAY .BLKW 8               ; Array to store the input numbers
PROMPT .STRINGZ "Enter a number: "
NEWLINE .FILL x0A           ; ASCII value for newline

; Main program
MAIN
    LEA R0, PROMPT          ; Load address of prompt
    PUTS                    ; Display prompt
    LD R6, NEWLINE          ; Load newline character
    ADD R6, R6, #0          ; Initialize stack pointer
    
    ; Read 8 numbers
    LD R1, ARRAY            ; Load base address of array
    LD R2, #8               ; Load count of numbers to read
READ_LOOP
    JSR READ_NUMBER         ; Read a number
    STR R0, R1, #0          ; Store number in array
    ADD R1, R1, #1          ; Move to next array position
    ADD R2, R2, #-1         ; Decrement count
    BRp READ_LOOP
    
    ; Sort the numbers
    JSR BUBBLE_SORT
    
    ; Display sorted numbers
    LD R1, ARRAY            ; Load base address of array
    LD R2, #8               ; Load count of numbers to display
DISPLAY_LOOP
    LDR R0, R1, #0          ; Load number from array
    JSR DISPLAY_NUMBER      ; Display number
    PUTS                    ; Display newline
    ADD R1, R1, #1          ; Move to next array position
    ADD R2, R2, #-1         ; Decrement count
    BRp DISPLAY_LOOP
    
    HALT                    ; End of program

; Subroutine to read a number from console
READ_NUMBER
    ; Assume user inputs valid integers for simplicity
    GETC                    ; Get character from console
    OUT                     ; Display character (echo)
    LD R4, ASCII_ZERO       ; Load ASCII value of '0'
    NOT R4, R4
    ADD R4, R4, #1
    ADD R0, R0, R4          ; Convert ASCII to integer
    RET

; Subroutine to display a number on console
DISPLAY_NUMBER
    ; Assume single-digit numbers for simplicity
    ADD R0, R0, R4          ; Convert integer to ASCII
    OUT                     ; Display character
    RET

; Bubble sort subroutine
BUBBLE_SORT
    LD R1, ARRAY            ; Load base address of array
    LD R2, #8               ; Load count of numbers
    ADD R3, R2, #-1         ; R3 = n-1
    
SORT_OUTER_LOOP
    ADD R4, R3, #0          ; R4 = n-1
SORT_INNER_LOOP
    ADD R5, R1, R4          ; R5 = &array[n-1]
    LDR R6, R5, #0          ; Load array[n-1]
    LDR R7, R5, #-1         ; Load array[n-2]
    BRn NO_SWAP             ; If array[n-2] <= array[n-1], no swap
    STR R6, R5, #-1         ; Swap array[n-1] and array[n-2]
    STR R7, R5, #0
NO_SWAP
    ADD R4, R4, #-1         ; Decrement inner loop counter
    BRp SORT_INNER_LOOP     ; Continue inner loop if R4 > 0
    
    ADD R3, R3, #-1         ; Decrement outer loop counter
    BRp SORT_OUTER_LOOP     ; Continue outer loop if R3 > 0
    RET

; Constants
ASCII_ZERO .FILL x0030      ; ASCII value of '0'

.END
