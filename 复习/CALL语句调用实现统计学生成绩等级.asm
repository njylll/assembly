data segment
       score db 89,45,90,69,75,99,79
            db 51,80,74,93,82,85,66
	      db -1
	  yx  db ?  
	  yx1 db  'A:','$'    ;90��-100��Ϊ����
         lh db ?
	  HU DB 0dh,0ah,0dh,0ah,'$'                ;�س�����
	  lh1 db  'B:','$'    ;80��-89��Ϊ����
	  zd  db ? 
	 zd1 db  'C:','$'     ;70��-79��Ϊ�е�
       jgg db ?
	jgg1 db  'D:','$'     ;60��-69��Ϊ�ϸ�
	bjg  db ?
	bjg1 db  'E:','$'     ;60������Ϊ������
data ends

stack segment
        ;input stack segment code here
stack ends

code segment
    assume cs:code,ds:data,ss:stack
start:
    mov ax,data
    mov ds,ax
     lea bx ,score
  LP:mov al,[bx]
      cmp al,-1          ;ȡ�ɼ�,��ȡ��,����sc
	JZ SC
	cmp al,90
	JGE LA
	cmp al,80
	JGE LB
	cmp al,70
	JGE LC
	cmp al,60
	JGE LD
	INC bjg   ;INC��1ָ���Ŀ�Ĳ�������1���ͻ�Ŀ�ĵ�ַ��
	JMP NEXT
   LA:INC yx
      JMP NEXT
   LB:INC lh
      JMP NEXT
   LC:INC zd
      JMP NEXT
   LD:INC jgg
 NEXT:INC BX      ;ȡ��һ����
     JMP LP
  SC:MOV DX,OFFSET yx1
     mov ah,09
    ; mov bl,0c8h
     ;mov cx,20
     ;int 10h
     int 21h  ;���yx1
     mov dl,yx
     cmp yx,09h
     jbe A ;С��9,ֱ��+30h���
     JMP BB
  BB:MOV DX,OFFSET HU      ;�س�����
     mov ah,09
     int 21h
     MOV DX,OFFSET lh1
     mov ah,09
    ; mov bl,0e8h
    ; mov cx,20
    ; int 10h
     int 21h 
     mov dl,lh
     cmp lh,09h
     jbe B ;С��9ֱ��+30h���
     jmp ccc
  ccc:MOV DX,OFFSET HU
      mov ah,09
      int 21h
      MOV DX,OFFSET zd1
     mov ah,09
    ; mov bl,0a8h
    ; mov cx,20
     ;int 10h
     int 21h
     mov dl,zd
     cmp zd,09h
     jbe C21
     jmp ddd
  ddd:MOV DX,OFFSET HU
      mov ah,09
      int 21h
      MOV DX,OFFSET jgg1
     mov ah,09
     mov bl,0b8h
     mov cx,20
     int 10h
     int 21h
     mov dl,jgg
     cmp jgg,09h
     jbe D
     JMP ee
   ee:MOV DX,OFFSET HU
      mov ah,09
      int 21h
     MOV DX,OFFSET bjg1
     mov ah,09
     mov bl,0d8h
     mov cx,20
     int 10h
     int 21h
     mov dl,bjg
     cmp bjg,09h
     jbe e
    JMP EXIT
   A:call output
    JMP BB
  B:call output
    JMP ccc
  C21:call output
    JMP DDD
  D:call output
    JMP EE
  E:call output
     JMP EXIT
output:ADD DL,30H ;��ʮ�������
       mov ah,02h
      int 21h
      ret
 EXIT: MOV AH,4CH
      INT 21H
      
code ends
end start