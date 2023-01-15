dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
arr db 7 dup (?)
inputs db "Enter Array Elements :: $"
outputs db "Unsorted Array :: $"
ascen db "Ascending Order :: $"
s1 db "Desending Order :: $"
.code
main proc
mov ax , @data
mov ds , ax

print inputs
mov cx , 7
mov si , offset arr
l1:
mov ah , 1
int 21h
mov [si] , al
inc si
loop l1

call nextline
print outputs
mov cx, 7
mov si , offset arr
l2:
mov dl , [si]
add dl , 0
mov ah , 2
int 21h
call space
inc si
loop l2


mov cx , 7
dec cx
l3:
mov bx , cx
mov si , 0
comploop:
mov al , arr[si]
mov dl , arr[si+1]
cmp al , dl
jc noSwap
mov arr[si] , dl
mov arr[si+1] , al
noSwap:
inc si
dec bx
jnz comploop
loop l3

call nextline
print ascen
mov cx, 7
mov si , offset arr
l4:
mov dl , [si]
add dl , 0
mov ah , 2
int 21h
call space
inc si
loop l4


mov cx , 7
dec cx
lA:
mov bx , cx
mov si , 0
cmploop:
mov al , arr[si]
mov dl , arr[si+1]
cmp al , dl
jnc notswap
mov arr[si] , dl
mov arr[si+1] , al
notswap:
inc si
dec bx
jnz cmploop
loop lA


call nextline
print s1
mov cx, 7
mov si , offset arr
lB:
mov dl , [si]
add dl , 0
mov ah , 2
int 21h
call space
inc si
loop lB

mov ah , 4ch
int 21h

nextline proc
mov dl , 10
mov ah , 2
int 21h
ret
nextline endp

space proc
mov dl , 32
mov ah , 2
int 21h
ret
space endp


main endp
end main
