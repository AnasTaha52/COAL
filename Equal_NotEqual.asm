dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
s1 db "Enter First Number :: $"
s2 db "Enter Second Number :: $"
s3 db "Equal$"
s4 db "NotEqual$"
.code
main proc
mov ax, @data
mov ds , ax
print s1
mov ah , 1
int 21h
mov bl ,al

call nextline 
print s2
mov ah , 1
int 21h
mov cl ,al

cmp bl , cl
je Equal
jne NotEqual

mov ah , 4ch
int 21h

Equal:
call nextline 
print s3
jmp exit

NotEqual:
call nextline 
print s4
jmp exit

exit:
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