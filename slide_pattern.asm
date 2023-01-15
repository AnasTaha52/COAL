dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
.code
main proc
mov ax, @data
mov ds , ax

; 1234567
; 123456
; 12345
; 1234
; 123
; 12
; 1

mov bx , 7
mov cx , 7
l1:
push cx
mov cx , bx
mov dl ,49
l2:
mov ah  , 2
int 21h
inc dl
loop l2
call nextline
pop cx
dec bx
loop l1

mov ah ,4ch
int 21h

nextline proc
mov dl , 10
mov ah , 2
int 21h
ret
nextline endp

main endp
end main