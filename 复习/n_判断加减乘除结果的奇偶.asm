DATAS SEGMENT
    result db 'the result is:$'
    ou db 'this is an even num!$'
    Ji db 'this is an odd num!'
    crlf db 0ah,0dh,'$'
    X dw 10h
    Y DW 12h
    Z DW 51H
DATAS ENDS
STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS
;test ax,01 与操作判断奇偶
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ah,09h
    LEA dx,result
    INT 21H
    MOV AX,X
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
    
    CMP AX,09H
    JBE L1
    CMP AX,0FH
    JBE L2
    CMP AX,7EH
    JBE L3
    
L1:;小于9,+30h
	ADD AX,30H
	MOV DX,AX
	MOV AH,02H
	INT 21H
	SUB AX,30H
	TEST AX,01
	JNZ JISHU
	JMP OUSHU
	
    
L2:
	ADD AX,37H
	MOV DX,AX
	MOV AH,02H
	INT 21H
	SUB AX,37H
	TEST AX,01
	JNZ JISHU
	JMP OUSHU
    
L3:
	MOV DX,AX
	MOV AH,02H
	INT 21H
	TEST AX,01
	JNZ JISHU
	JMP OUSHU

OUSHU:
	MOV AH,09H
	lea dx,crlf
	int 21h
	LEA DX,OU
	INT 21H
	MOV Ax,4C00H
	INT 21H
JISHU:
	MOV AH,09H
	lea dx,crlf
	int 21h
	LEA DX,JI
	INT 21H
	MOV Ax,4C00H
    INT 21H
CODES ENDS
    END START