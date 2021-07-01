DATAS SEGMENT
    X dw -99h
	Y dw 65h
	Z dw 70h
	D db 100,10
	S db 'the min is:$'
DATAS ENDS

STACKS SEGMENT
    db 100 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ax,stacks
    mov ss,ax
    mov ah,09H
    lea dx,S
    int 21h
    mov ax,X
    mov bx,Y
    cmp ax,bx
    jle nextcompare
    xchg ax,bx

nextcompare:
    mov bx,Z
    cmp ax,bx
    jle judge
    xchg ax,bx

judge:            ;;;;;这里还有一步正负号判断
    cmp ax,0
    jge next     ;;;;greater equal
    mov cx,0
    sub cx,Ax
    mov ah,02H
    mov dl,'-'
    int 21H
    mov ax,cx

next:

    idiv d ;al 百位  ah十位个位
    push ax
    cmp al,0
    jz next2
    mov bx,1;百位是否为0
    call outal
next2:
    pop ax;
    mov al,AH
    mov ah,0
    idiv d+1
    push ax
    cmp bx,1
    jz outten
    cmp al,0
    jz outah

outten:
    call outal;

outah:
    pop ax
    mov dl,AH
    add dl,30H
    mov ah,02H
    int 21h
    
    MOV AH,4CH
    INT 21H

outal:
    mov dl,al
    add dl,30H
    mov ah,02H
    int 21H
    ret          ;;;;ret!!!

CODES ENDS
    END START