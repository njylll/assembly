data segment
    s1 db '������һ����ĸ:$'
    s2 db 'the result is:$'
    S3 db '����Ĳ��Ǵ���ĸ$'
    H  db 0ah,0dh,'$'; ��������
    s db '$'
data ends

code segment

assume cs:code,ds:data 

start:
 mov ax,data
 mov ds,ax
  mov ah,09h ;��dx��ʾ�ַ���s1
  mov dx,offset s1
  int 21h
  mov ah,0ah ;dos���ܣ��Ӽ�������һ���ַ�����dx,��һ���ֽ������������,�ڶ����ֽڴ��ʵ�������ֽ���
  lea dx,s
  int 21h
  lea si,s+1     ;���ڵ�[si]�洢����ʵ��������ֽ���
  xor cx,cx             ;�Ѽ�����cx��0  ������ͬ�����Ϊ0  
  mov cl,[si]           ;��ʵ�������ֽ�����cl,ʵ��ѭ���ж�
LP:
  inc si  ;�ⲽ��,ds:[si]Ϊ�洢�����һ���ַ�
  mov al,[si]
  cmp al,'A'
  jb L3 ;˵�����Ǵ���ĸ
  cmp al,'Z'
  ja L2 ;˵�����Ǵ�д��ĸ
  add al,20h
  mov [si],al
  jmp next
L2: cmp al,'a'
    jb L3 ;Ҳ����Сд��ĸ
    cmp al,'z'
    ja L3 ;Ҳ����Сд��ĸ
    sub al,20h ;ת��Ϊ��д��ĸ,ascii��-20h
    mov [si],al
    jmp next  
next:
  LOOP LP           ;CX=CX-1,CX������0�����ѭ��
  mov ah,09
  lea dx,h
  int 21h                   
  mov ah,09
  lea dx,s2
  int 21h
  mov byte ptr [si+1],'$'  ;�ڽ�β���Ͻ�����
  lea dx,s+2 ;���
  mov ah,09
  int 21h
  mov ah,4ch
  int 21h
L3: mov ah,09 
  lea dx,h;�������
  int 21h
  mov ah,09
  lea dx,s3;���������ʾ
  int 21h
   mov ah,4ch
  int 21h
code ends
end start