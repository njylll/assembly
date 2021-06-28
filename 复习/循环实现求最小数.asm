DATA SEGMENT
       SHU DB  46H,69H,6BH,45H,6CH,42H,68H
        COUNT EQU $-SHU
         M DB '最小的数是:$'
       
DATA ENDS
STACK SEGMENT
         DB 100 DUP(?)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:
    MOV  AX,DATA
    MOV  DS,AX
    MOV  CX,COUNT-1            ;把循环次数送入CX
    MOV  SI,OFFSET SHU   ;SI源变址寄存器，用于存放DS段源操作数的偏移地址，是源变址指针，SI的内容有自动更换功能
    MOV  AL,[SI]            ;[SI]是寄存器间接寻址，是指SI中地址的内容，这里是将第一个数放入AL中
  L1:CMP  AL,[SI+1]     ; CMP指令（见书P160）两个操作数相减后，通过标志位的状态来反应两个操作数的大小，完成第一个数和第二个数的比较
    JBE  L2              ;AL<=[SI+1] 跳转到L2执行
    XCHG  AL,[SI+1]          ; 将小的数存入AL中
  L2:INC  SI               ; INC自动加1指令，相当于SI指向第三个数
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
