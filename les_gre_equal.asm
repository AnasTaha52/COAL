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
s3 db "Equal Numbers! $"
s4 db "Greater Number$!"
s5 db "Lesser Numbers$"
.code 
main proc
mov ax, @data
mov ds , ax

print s1
mov ah , 1
int 21h
mov bl , al
call nextline
print s2
mov ah , 1
int 21h
mov cl , al
cmp bl , cl

je Equal
jg Greater
jl Lesser

Equal:
call nextline
print s3
jmp exit

Greater:
call nextline
print s4
jmp exit
Lesser:
call nextline
print s5
jmp exit

exit:
mov ah , 4ch
int 21h



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