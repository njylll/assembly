DATAS SEGMENT
    s1 db 'please input string:$'
    s2 db 'the result is:$'
    s3 db 'error input$'
    crlf db 0ah,0dh,'$'   ;;;�ַ�����β������ $
    buf db  '$'  ;;���������,��ֹ������ַ���������


DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AH,09h
    LEA DX,s1
    INT 21h
;INPUT
    MOV AH,0AH
    lea DX,buf
    INT 21h
    LEA si,buf+1
    XOR CX,CX              ;�������ⲽ
    mov cl,[si]

L:
    inc si
    mov al,[si]              ;;;asciiһ���ֽ�,�Ƹ�bl
    cmp al,'A'
    jb L4
    cmp al,'Z'
    ja L2
    add byte ptr [si],20H    ;;ָ��Ϊ�ֽڲ���
    jmp L3

L2:
    cmp al,'a'
    jb L4
    cmp al,'z'
    ja L4
    sub byte ptr [si],20H
    jmp L3

L3:
    loop L
    inc si
    mov byte ptr [si],'$' ;;;ָ���������ݴ�С
    mov ah,09H
    lea dx,crlf
    int 21H
    lea dx,s2
    int 21H
    lea dx,buf+2
    int 21H
    mov ah,4CH
    int 21h



L4:
    mov ah,09H
    LEA DX,CRLF
    INT 21h
    lea dx,s3
    int 21H
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START