DATAS SEGMENT
    A db  01000101B
    B dw 0000001101100001B
    s db 'ascii:$'
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    lea dx,s
    ;mov ah,09h
    ;mov bl,0a5h
    ;mov cx,17
    int 10h
    int 21h
    
    mov DL,A  ;ÿ��λ�ж�һ��
    CALL PANDUAN
    MOV BX,B
    MOV DL,BL
    CALL PANDUAN
    MOV DL,BH
    CALL PANDUAN
    MOV AH,4CH;
    INT 21H;
    
 PANDUAN:
 	CMP DL,09H ;0-9 +30h
 	JBE L1
 	CMP DL,0FH ;10-15 +37h
 	JBE L2
 	MOV AH,02H
 	INT 21H
 	RET
 L1:
 	ADD DL,30H
 	MOV AH,02H
 	INT 21H
 	RET
 L2:
 	ADD DL,37H
 	MOV AH,02H
 	INT 21H
    RET
CODES ENDS
    END START