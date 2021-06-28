data segment
          x dw 10h
	  y dw 12h
	  z dw 51h
	  S Db 'the result is:','$ '
         hh db 0dh,0ah,'$'
	  sj db 'qishu!','$'
	  os db 'oushu!','$'
	
	 
data ends
;0的ASCII码是30H,1的ACII码是31H,一直到9的ASCII码是39H,所以,数值0-9要显示在屏幕上,
;就要变成它的ASCII码,加上30H就可以了.

;A的ASCII码是41H,十进制10对应十六进制的A, A H + 37 H =41H
;B的ASCII码是42H,十进制11对应十六进制的B, B H + 37 H =42H
stack segment
        dw 20h dup(0)
stack ends

code segment
    assume cs:code,ds:data,ss:stack
start:
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax

    mov ah,09h
    lea dx,s
     ;mov bl,0a4h
;	mov cx,15
;	int 10h
     int 21h

     mov ax,x 
     add ax,y
     mov bx,ax 
     sal ax,1
     sal ax,1 
     add ax,bx
      sal ax,1
     mov bx,z
     dec bx
     mov cx,bx
     sal bx,1
     add  bx,cx
     sub ax,bx
     sar ax,1
     mov ax,7bh
      cmp ax,09h           
    JBE L1     ;+30h输出   
    cmp ax,0Fh
    JBE L2    ;加37h输出
    cmp ax,7Eh
    JBE L3
 L1:
     add ax,30h
     mov dx,ax
    ; mov bl,0a4h
    ; mov cx,1
    ; int 10h
   mov ah,02h
     int 21h  ;输出结果


     mov ax,dx
     sub ax,30h ;恢复ax的大小
     test ax,01 ;与操作
     JNE J
     mov ah,09
     mov dx,offset hh
     int 21h
     mov dx,offset OS
       
       ; mov bl,0d2h
       ;  mov cx,13
	 ;int 10h
      int 21h  
    mov ah,4ch
    int 21h
 L2:
    add ax,37h
     mov dx,ax
     ;mov bl,0a4h
     ;mov cx,1
     ;int 10h
   mov ah,02h
     int 21h
     mov ax,dx
     sub ax,37h
     test ax,01
     JNE J
     mov ah,09
     mov dx,offset hh
     int 21h 
     mov dx,offset OS
        ;mov bl,0d2h
         ;mov cx,13 
	; int 10h
      int 21h  
    mov ah,4ch
    int 21h
 L3:
     mov dx,ax
    
     ;mov bl,0a4h
    ; mov cx,1
     ;int 10h
   mov ah,02h
     int 21h;输出结果
     mov ax,dx
     test ax,01
     JNE J
     mov ah,09
     mov dx,offset hh
     int 21h
     mov dx,offset OS
       mov ah,09
      ;  mov bl,0d2h
      ;   mov cx,13
	; int 10h
      int 21h  
    mov ah,4ch
    int 21h
J:;输出是奇数
    mov ah,09
     mov dx,offset hh
     int 21h
       lea dx,sj
        ;mov bl,0e2h
        ; mov cx,13
	; int 10h
      int 21h  
      mov ah,4ch
        int 21h          
code ends
end start
