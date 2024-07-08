org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

;
; prints a string to the screen
; Params:
;       - ds:si points to string
;
puts:
    ; save registers that we modify
    push si
    push ax

.loop:
    lodsb   ; loads next character
    or al, al ; 0 flag set
    jz .done
    
    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp .loop
    
.done:
    pop ax
    pop si
    ret

main:

    ; setup data segments
    mov ax, 0   ; can not write to ds/es
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00 ; stack grows down

    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt


msg_hello: db 'Hello world!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h