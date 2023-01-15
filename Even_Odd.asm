dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
numb db "Enter Number :: $"
E db "Even Number!$"
O db "Odd Number!$"
.code
main proc
mov ax , @data
mov ds ,ax

print numb
mov ah , 1
int 21h
mov bl , 2
div bl 
cmp ah , 0
je l1
call nextline
print O
mov ah , 4ch
int 21h

l1:
call nextline
print E
mov ah , 4ch 
int 21h

nextline proc
mov dl ,10
mov ah , 2
int 21h
ret
nextline endp
main endp
end main