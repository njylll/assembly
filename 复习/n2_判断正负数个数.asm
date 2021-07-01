DATAS SEGMENT
    da1 db 1,2,0,-3,2,-6,0,8
    count equ $-da1
    plus db 'plus:$'
    min db 'minus:$'
    zero db 'zero:$'
    p db 0
    m db 0
    z db 0
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
    lea si,da1
    mov cx,count
 compare:
    mov al,[si]
    cmp al,0
    jz ZZ
    jg PP
    jl MM

zz: 
    inc Z
    inc si 
    jmp output
pp:
    inc P
    inc si
    jmp output

MM:
    inc m
    inc si
    jmp output

output:
    loop compare
     mov ah,09H
     lea dx,PLUS
     int 21H
     mov dl,P
     call out1
  
    
     mov ah,09H
     lea dx,min
     int 21H
     mov dl,m
     call out1

  
      mov ah,09H
     lea dx,zero
     int 21H
     mov dl,z
     call out1


    MOV AH,4CH
    INT 21H
out1:
    add dl,30h
     mov ah,02H
     int 21h
    call endl
    ret

endl:
    mov ah,09H
    lea dx,crlf
    int 21H
    ret
CODES ENDS
    END START