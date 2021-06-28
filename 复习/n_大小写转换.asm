DATAS SEGMENT
	s1 db 'please input string:$'
	s2 db 'the result is:$'
	s3 db 'input error$'
	crlf db 0ah,0dh,'$'
	buf db '$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ah,09h
    lea dx,s1
    int 21h
    
    mov ah,0ah;输入
    lea  dx,buf
    int 21h
    
    lea si,buf+1
    xor cx,cx
    mov cl,[si] ;获取字符个数
    
l1:
	inc si
	mov al,[si]
	cmp al,'A'
	jb l3
	cmp al,'Z'
	ja l2
	ADD [si],20h
	jmp next
l2:
	cmp al,'a'
	jb l3
	cmp al,'z'
	ja l3
	SUB [si],20H
	jmp next

next:
	loop l1
	mov ah,09h
	inc si
	mov byte ptr [si],'$'
	lea dx,crlf
	int 21h
    lea dx,s2
    int 21h
	lea dx,buf+2
	int 21h
	mov ax,4c00h
	int 21h
	
	
l3:
	mov ah,09h
	lea dx,crlf
	int 21h
    ;mov bl,0a8h
   ; mov cx,17
    ;int 10h
	lea dx,s3
	int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START