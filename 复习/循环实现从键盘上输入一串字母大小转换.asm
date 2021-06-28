data segment
    s1 db '请输入一串字母:$'
    s2 db 'the result is:$'
    S3 db '输入的不是纯字母$'
    H  db 0ah,0dh,'$'; 用来换行
    s db '$'
data ends

code segment

assume cs:code,ds:data 

start:
 mov ax,data
 mov ds,ax
  mov ah,09h ;从dx显示字符串s1
  mov dx,offset s1
  int 21h
  mov ah,0ah ;dos功能，从键盘输入一个字符串到dx,第一个字节设置最大容量,第二个字节存放实际输入字节数
  lea dx,s
  int 21h
  lea si,s+1     ;现在的[si]存储的是实际输入的字节数
  xor cx,cx             ;把计数器cx置0  两数相同异或结果为0  
  mov cl,[si]           ;把实际输入字节数给cl,实现循环判断
LP:
  inc si  ;这步后,ds:[si]为存储输入第一个字符
  mov al,[si]
  cmp al,'A'
  jb L3 ;说明不是纯字母
  cmp al,'Z'
  ja L2 ;说明不是大写字母
  add al,20h
  mov [si],al
  jmp next
L2: cmp al,'a'
    jb L3 ;也不是小写字母
    cmp al,'z'
    ja L3 ;也不是小写字母
    sub al,20h ;转化为大写字母,ascii码-20h
    mov [si],al
    jmp next  
next:
  LOOP LP           ;CX=CX-1,CX不等于0则继续循环
  mov ah,09
  lea dx,h
  int 21h                   
  mov ah,09
  lea dx,s2
  int 21h
  mov byte ptr [si+1],'$'  ;在结尾加上结束符
  lea dx,s+2 ;输出
  mov ah,09
  int 21h
  mov ah,4ch
  int 21h
L3: mov ah,09 
  lea dx,h;输出换行
  int 21h
  mov ah,09
  lea dx,s3;输出错误提示
  int 21h
   mov ah,4ch
  int 21h
code ends
end start