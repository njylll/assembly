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
       JG L1        ;AX>0跳转
       MOV CX,0
       SUB CX,AX
       MOV AL,'-'
       MOV DL,AL
       MOV AH,02H
       INT 21H
       MOV AX,CX
    L1:
         IDIV W      ;除100，分离出百位数，十位数和个位数一起送入AH
       PUSH AX
       CMP AL,0    ;百位数为0跳转
       JZ AA
       MOV BX,1
       CALL L2    
    AA:
        POP AX
       MOV AL,AH   ;AH中的十位数和个位数一起送入AL
       MOV AH,0
       IDIV W+1    ;除10，分离出十位数送入AL，个位数送入AH idiv为带符号除法
       PUSH AX
       CMP BX,1
       JZ CC
       CMP AL,0   ;十位数为0跳转
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
