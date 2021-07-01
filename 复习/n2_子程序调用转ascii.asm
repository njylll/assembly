DATAS SEGMENT
    A db  01000101B
    B dw 0000001101100001B
    s db 'ascii:$' 
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ah,09H
    lea dx,S
    int 21H

    xor dx,dx          ;;;;清零
    mov dl,A
    call COMPARE
    mov bx,B
    mov dl,bl
    call COMPARE
    mov dl,BH
    call COMPARE
    mov ah,4CH
    int 21h

COMPARE:
    cmp dl,09H
    jbe L1
    cmp dl,0fh
    jbe L2
    mov ah,02H
    int 21H
    ret
L1:
    add dl,30H
    mov ah,02H
    int 21H
    ret
L2:
    add dl,37H
    mov ah,02H
    int 21H
    ret


    MOV AH,4CH
    INT 21H
CODES ENDS
    END START