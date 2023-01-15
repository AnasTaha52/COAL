dosseg
.model small
.stack 100h
.data
ev db 'divisible by 2$'
od db 'divisible by 3$'
.code
main proc
mov ax,@data
mov ds,ax
mov ah,1
int 21h
mov bl,2
div bl
cmp ah,0
je IsEven
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
mov dx,offset od
mov ah,9
int 21h
mov ah,4ch
int 21h
IsEven:
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
mov dx,offset ev
mov ah,9
int 21h
mov ah,4ch
int 21h
main endp
end main