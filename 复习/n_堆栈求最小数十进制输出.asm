DATAS SEGMENT
	X dw 99h
	Y dw 65h
	Z dw 70h
	D db 100,10
	S db 'the min is:$'
DATAS ENDS
;0的ASCII码是30H,1的ACII码是31H,一直到9的ASCII码是39H,所以,数值0-9要显示在屏幕上,
;就要变成它的ASCII码,加上30H就可以了.

;A的ASCII码是41H,十进制10对应十六进制的A, A H + 37 H =41H
;B的ASCII码是42H,十进制11对应十六进制的B, B H + 37 H =42H

;XCHG 交换
STACKS SEGMENT
    dw 100 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ax,stacks
    mov ss,ax
    lea dx,s
    mov ah,09h
    mov bl,0a4h
    mov cx,15
    int 10h
    int 21h
    mov ax,X
    mov bx,Y
    cmp ax,bx
    jl XIAOYU
    XCHG ax,bx
XIAOYU:
	mov bx,Z
	cmp ax,bx
	jl judge
	XCHG ax,bx
	
judge:
	cmp ax,0
	jg judge2;为正数
	mov cx,0
	sub cx,ax
	mov dl,'-'
	mov ah,02h
	int 12h
	mov ax,cx
	
judge2:;push ax 在判断跳转之前
	idiv d;al百位,ah十位个位
    push ax
	cmp al,0
	jz judge3;判断十位
	mov bx,1;标志百位不为0
	call outal

judge3:
	POP AX
	mov al,ah
	mov ah,0
	idiv d+1
    push ax
	cmp bx,1
	jz outten;输出10位
	cmp al,0
	jz outah
outten:
	call outal
outah:
	pop ax
	add ah,30h
	mov dl,ah
	mov ah,02h
	int 21h
	mov ax,4c00h
	int 21h

outal:
	add al,30h
	mov dl,al
	mov ah,02h
	int 21h
	ret
CODES ENDS
    END START