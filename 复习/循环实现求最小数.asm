DATA SEGMENT
       SHU DB  46H,69H,6BH,45H,6CH,42H,68H
        COUNT EQU $-SHU
         M DB '��С������:$'
       
DATA ENDS
STACK SEGMENT
         DB 100 DUP(?)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:
    MOV  AX,DATA
    MOV  DS,AX
    MOV  CX,COUNT-1            ;��ѭ����������CX
    MOV  SI,OFFSET SHU   ;SIԴ��ַ�Ĵ��������ڴ��DS��Դ��������ƫ�Ƶ�ַ����Դ��ַָ�룬SI���������Զ���������
    MOV  AL,[SI]            ;[SI]�ǼĴ������Ѱַ����ָSI�е�ַ�����ݣ������ǽ���һ��������AL��
  L1:CMP  AL,[SI+1]     ; CMPָ�����P160�����������������ͨ����־λ��״̬����Ӧ�����������Ĵ�С����ɵ�һ�����͵ڶ������ıȽ�
    JBE  L2              ;AL<=[SI+1] ��ת��L2ִ��
    XCHG  AL,[SI+1]          ; ��С��������AL��
  L2:INC  SI               ; INC�Զ���1ָ��൱��SIָ���������
     LOOP L1            
 NEXT: CMP AL,09h
         JBE P
        CMP AL,0fh
	  JBE P1
	MOV DL,AL 
	CALL P2 
    p:  add al,30h
        MOV DL,AL   
       CALL P2
     p1: add al,37h
          MOV DL,AL
          CALL P2  
     P2: 
	  MOV  DX,OFFSET M
          MOV  AH,09H
	  mov bl,0e3h 
          mov cx,12
          int 10h
          int 21h
	  mov ah,02h
	  int 21h 
          mov ax,4c00h  
          int 21h   
code ends
end start
