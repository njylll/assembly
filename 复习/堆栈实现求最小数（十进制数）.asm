DATAS SEGMENT
  X DW 90h
  Y DW 80h
  Z DW 91h
  W DB 100,10
  S DB 'the min is:$'
DATAS ENDS
;0的ASCII码是30H,1的ACII码是31H,一直到9的ASCII码是39H,所以,数值0-9要显示在屏幕上,
;就要变成它的ASCII码,加上30H就可以了.

;A的ASCII码是41H,十进制10对应十六进制的A, A H + 37 H =41H
;B的ASCII码是42H,十进制11对应十六进制的B, B H + 37 H =42H

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
      INT 21H;输出S
    	MOV AX,X
    	MOV BX,Y
    	CMP AX,BX
    	JL  XIAOYU1   ;AX<BX跳转,带符号判断跳转:jl,jg
    	XCHG AX,BX;交换,让ax放最小的
XIAOYU1:MOV BX,Z ;X跟Z比
   	CMP AX,BX
              JL XIAOYU2;说明A最小,输出A
            XCHG AX,BX;交换寄存器内容
XIAOYU2:CMP AX,0
              JG judeg1    ;AX>0,直接跳转输出正数
             MOV CX,0
           SUB CX,AX
          MOV DL,'-'
          MOV AH,02H
         INT 21H
           MOV AX,CX
 judeg1: IDIV W      ;除100，百位数存入al,十位个位存入ah
         PUSH AX     
         CMP AL,0    ;百位数为0跳转
         JZ judge2
         MOV BX,1   ;百位不为0
         CALL outal
 judge2: POP AX
         MOV AL,AH    ;AH中的十位数和个位数一起送入AL
         MOV AH,0
         IDIV W+1      ;除10，分离出十位数送入AL，个位数送入AH
          CMP BX,1 ;
          JZ outten
         CMP AL,0     ;十位数为0跳转
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
         MOV DL,AL ;字符ascii码送入dl显示
         MOV AH,02H
         INT 21H
         RET
CODES ENDS
 END START