DATAS SEGMENT
    SHU DB  05H,69H,6BH,45H,6CH,42H,68H 
    COUNT EQU $-SHU
    S DB 'THE MIN IS:$'
DATAS ENDS

STACKS SEGMENT
    db 100 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV CX,COUNT-1   ;;;比较次数要-1
    lea si,SHU
    mov al,[si]

compare:   ;;;注意compare位置
    cmp al,[si+1]
    jbe CONTINUE
    XCHG al,[si+1]

CONTINUE:
    inc si
    LOOP COMPARE
    CMP al,09h
    JBE OUT1
    CMP al,0FH
    JBE OUT2
    call out3
OUT1:
    add al,30H
    call out3
OUT2:
    add al,37H
    call out3

out3:
    lea dx,S
    mov ah,09H
    mov bl,0e4h
    mov cx,12   ;;;;;;;cx别自己瞎改
    int 10h
    int 21h
    mov dl,al
    mov ah,02H
    int 21h
    mov ah,4ch
    int 21h
CODES ENDS
    END START