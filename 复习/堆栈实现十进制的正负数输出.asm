data segment
       A DW -888
       W DB 100,10
      
data ends

stack segment
        ;input stack segment code here
stack ends

code segment
    assume cs:code,ds:data,ss:stack
start:
    mov ax,data
    mov ds,ax
       MOV AX,A
       CMP AX,0
       JG L1        ;AX>0��ת
       MOV CX,0
       SUB CX,AX
       MOV AL,'-'
       MOV DL,AL
       MOV AH,02H
       INT 21H
       MOV AX,CX
    L1:
         IDIV W      ;��100���������λ����ʮλ���͸�λ��һ������AH
       PUSH AX
       CMP AL,0    ;��λ��Ϊ0��ת
       JZ AA
       MOV BX,1
       CALL L2    
    AA:
        POP AX
       MOV AL,AH   ;AH�е�ʮλ���͸�λ��һ������AL
       MOV AH,0
       IDIV W+1    ;��10�������ʮλ������AL����λ������AH idivΪ�����ų���
       PUSH AX
       CMP BX,1
       JZ CC
       CMP AL,0   ;ʮλ��Ϊ0��ת
       JZ BB
   CC: 
         CALL L2
   BB: 
        POP AX
        ADD AH,30H
        MOV DL,AH
        MOV AH,02H
        INT 21H
       MOV AH,4CH
        INT 21H
   L2: 
       ADD AL,30H
       MOV DL,AL
       MOV AH,02H
       INT 21H
       RET
code ends
end start
