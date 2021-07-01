DATAS SEGMENT
     score db 89,45,90,69,75,99,79
     	   db 91,80,74,93,82,85,66
     count equ $-score
     yx db 0
     youxiu db 'youxiu:$'
     hg db 0
     hege db 'hege:$'
     bjg db 0
     bujige db 'bujige:$'
     crlf db 0ah,0dh,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    lea si,score
    mov cx,count

s:
    mov AL,[si]        ;;;;字节数据类型,用al!!!!!!!!
    cmp AL,90
    jae L1
    cmp AL,70
    jae L2
    cmp AL,60
    jae L3
    inc bjg
    inc si
    loop S
    jmp outt

L1:
    inc yx
    inc si
    loop S
    jmp outt
l2:
    inc si
    loop S
    jmp outt

l3:
    inc hg
    inc si
    loop S

outt:
    mov ah,09H
    lea dx,youxiu
    int 21H
    mov dl,yx
    call OUT1
    call outln

    mov ah,09h
    lea dx,hege
    int 21H
    mov dl,hg
    call out1
    call outln

    mov ah,09h
    lea dx,bujige
    int 21H
    mov dl,bjg
    call out1
    call outln
    call exit
    
out1:
    add dl,30h
    mov ah,02H
    int 21h
    ret
    
outln:
    mov ah,09h
    lea dx,crlf
    int 21h
    ret




exit:
 MOV AH,4CH
    INT 21H
CODES ENDS
    END START