DATAS SEGMENT
  X DW 90h
  Y DW 80h
  Z DW 91h
  W DB 100,10
  S DB 'the min is:$'
DATAS ENDS
;0��ASCII����30H,1��ACII����31H,һֱ��9��ASCII����39H,����,��ֵ0-9Ҫ��ʾ����Ļ��,
;��Ҫ�������ASCII��,����30H�Ϳ�����.

;A��ASCII����41H,ʮ����10��Ӧʮ�����Ƶ�A, A H + 37 H =41H
;B��ASCII����42H,ʮ����11��Ӧʮ�����Ƶ�B, B H + 37 H =42H

STACKS SEGMENT

   DW 100 DUP(?)

STACKS ENDS

CODES SEGMENT

    ASSUME CS:CODES,DS:DATAS,SS:STACKS

START:
  MOV AX,DATAS
  MOV DS,AX
      lea dx,S
      MOV AH,09
      INT 21H;���S
    	MOV AX,X
    	MOV BX,Y
    	CMP AX,BX
    	JL  XIAOYU1   ;AX<BX��ת,�������ж���ת:jl,jg
    	XCHG AX,BX;����,��ax����С��
XIAOYU1:MOV BX,Z ;X��Z��
   	CMP AX,BX
              JL XIAOYU2;˵��A��С,���A
            XCHG AX,BX;�����Ĵ�������
XIAOYU2:CMP AX,0
              JG judeg1    ;AX>0,ֱ����ת�������
             MOV CX,0
           SUB CX,AX
          MOV DL,'-'
          MOV AH,02H
         INT 21H
           MOV AX,CX
 judeg1: IDIV W      ;��100����λ������al,ʮλ��λ����ah
         PUSH AX     
         CMP AL,0    ;��λ��Ϊ0��ת
         JZ judge2
         MOV BX,1   ;��λ��Ϊ0
         CALL outal
 judge2: POP AX
         MOV AL,AH    ;AH�е�ʮλ���͸�λ��һ������AL
         MOV AH,0
         IDIV W+1      ;��10�������ʮλ������AL����λ������AH
          CMP BX,1 ;
          JZ outten
         CMP AL,0     ;ʮλ��Ϊ0��ת
          JZ outah
     outten: 
        push ax
           CALL outal
    outah: POP AX 
         ADD AH,30H
         MOV DL,AH
         MOV AH,02H
         INT 21H
         MOV AH,4CH
         INT 21H
    outal: ADD AL,30H
         MOV DL,AL ;�ַ�ascii������dl��ʾ
         MOV AH,02H
         INT 21H
         RET
CODES ENDS
 END START