data segment
	A DB 01000101B
	B DW 0000001101100001B
                S DB 'ASCII:$'
data ends

stack segment

stack ends

code segment

    assume cs:code,ds:data,ss:stack

start:
    mov ax,data
    mov ds,ax
     MOV AH ,09h
	 lea dx,s
   ;  MOV BL,0a4h
    ; MOV CX,15
    ; INT 10h
     INT 21h ;输出s

	;MOV AL,A
	MOV BX,B
	MOV DL,A;
	CALL PANDUAN;输出a的asc码字符
	MOV AH,09h ;输出字符串  
	MOV DL,bl
	CALL PANDUAN
	MOV DL,bh
	CALL PANDUAN
	MOV AH,4CH
	INT 21H
PANDUAN:CMP DL,09H;小于9的数字
	JBE LA
	CMP DL,0FH;小于15的数字
	JBE LB
	MOV AH,02H
	INT 21H
	RET         ;是子程序的最后一条指令，恢复断点返回主程序
LA:  ADD DL,30H
     MOV AH,02h
     int 21h
     RET   
LB:  ADD DL,37H
     MOV AH,02h
     int 21h
     RET 
code ends
end start