DATAS SEGMENT
    result db 'the result is:$'
    JISHU db 'this is an odd number!$'
    oushu db 'this is an even number!$'
    crlf db 0ah,0dh,'$'
    X dw 10h
    Y DW 12h
    Z DW 51H
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
    lea dx,result
    int 21H

    mov ax,X
    ADD AX,Y
    MOV BX,AX
    SAL AX,1
    sal ax,1
    ADD AX,BX
    SAL AX,1
    MOV BX,Z
    DEC BX
    MOV CX,BX
    SAL BX,1
    ADD BX,CX
    SUB AX,BX
    SAR AX,1 ;运算出结果
    mov ax,07;

    cmp ax,09H
    jbe L1
    cmp ax,0Fh
    jbe L2
    cmp ax,7eh
    JBE l3                    ;;;;;jbe 不是jbz

l1:
    add ax,30H
    mov dx,ax
    mov ah,02H
    int 21H
    sub ax,30H
    test ax,01
    jnz ji
    jmp ou

l2:
    add ax,37H
    mov dx,ax
    mov ah,02H
    int 21H
    sub ax,37H
    test ax,01
    jnz ji
    jmp ou
l3:
    mov ah,02H
    mov dx,ax
    int 21H
    test ax,01
    jnz ji
    jmp ou

ou:
    mov ah,09H
    lea dx,oushu
    int 21H
    mov ah,4CH
    int 21h

ji:
    mov ah,09H
    lea dx,JISHU
    int 21H
    mov ah,4ch
    int 21H
CODES ENDS
    END START