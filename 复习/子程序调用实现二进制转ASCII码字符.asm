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
     INT 21h ;���s

	;MOV AL,A
	MOV BX,B
	MOV DL,A;
	CALL PANDUAN;���a��asc���ַ�
	MOV AH,09h ;����ַ���  
	MOV DL,bl
	CALL PANDUAN
	MOV DL,bh
	CALL PANDUAN
	MOV AH,4CH
	INT 21H
PANDUAN:CMP DL,09H;С��9������
	JBE LA
	CMP DL,0FH;С��15������
	JBE LB
	MOV AH,02H
	INT 21H
	RET         ;���ӳ�������һ��ָ��ָ��ϵ㷵��������
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