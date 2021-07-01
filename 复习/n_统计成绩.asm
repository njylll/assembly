DATAS SEGMENT
     score db 89,45,90,69,75,99,79
     	   db 91,80,74,93,82,85,66
	       db -1
	 yx db 0
	 youxiu db 'the number of youxiu is:$'
	 hg db 0
	 hege db 'the number of hege is:$'
	 bjg db 0
	 bujige db 'the number of bujige is:$'
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
    lea bx,score
s:
	mov al,[bx]
	cmp al,-1
	jz outt;判断完成,输出
	
	cmp al,90;统计优秀
	jae l1
	cmp al,70
	jae l2
	cmp al,60;统计合格
	jae l3
	inc bjg ;统计不及格
	inc bx
	jmp s
L1:
	inc yx
	inc bx
	jmp s
l2:
	inc bx
	jmp s
l3:
    inc hg
	inc bx
	jmp s
outt:
	lea dx,youxiu
	mov ah,09h
	int 21h
	mov dl,yx
	call output
    call outcrlf
	
    lea dx,hege
	mov ah,09h
	int 21h
    mov dl,hg
	call output
    call outcrlf

	lea dx,bujige
	mov ah,09h
	int 21h
    mov dl,bjg
    call output
	mov ah,4ch
	int 21h
output:
	add dl,30h
	mov AH,02h
	int 21h
	ret
outcrlf:
    lea dx,crlf
    mov ah,09h
    int 21H
    ret
CODES ENDS
    END START