DATAS SEGMENT
	X dw 99h
	Y dw 65h
	Z dw 70h
	D db 100,10
	S db 'the min is:$'
DATAS ENDS
;0��ASCII����30H,1��ACII����31H,һֱ��9��ASCII����39H,����,��ֵ0-9Ҫ��ʾ����Ļ��,
;��Ҫ�������ASCII��,����30H�Ϳ�����.

;A��ASCII����41H,ʮ����10��Ӧʮ�����Ƶ�A, A H + 37 H =41H
;B��ASCII����42H,ʮ����11��Ӧʮ�����Ƶ�B, B H + 37 H =42H

;XCHG ����
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
	jg judge2;Ϊ����
	mov cx,0
	sub cx,ax
	mov dl,'-'
	mov ah,02h
	int 12h
	mov ax,cx
	
judge2:;push ax ���ж���ת֮ǰ
	idiv d;al��λ,ahʮλ��λ
    push ax
	cmp al,0
	jz judge3;�ж�ʮλ
	mov bx,1;��־��λ��Ϊ0
	call outal

judge3:
	POP AX
	mov al,ah
	mov ah,0
	idiv d+1
    push ax
	cmp bx,1
	jz outten;���10λ
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