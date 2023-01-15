dosseg
.model small
.stack 100h
.data 
.code
main proc
mov ah , 5
mov al , 1
int 10h
mov ah , 6
mov al , 12 ; al height
mov bh , 10110000b
mov cl , 0 ; starting postion ch , cl
mov dl , 24
mov ch , 24 ; dh bottom
mov dh , 48 ; left dl
int 10h

mov ah , 4ch 
int 21h
main endp
end main