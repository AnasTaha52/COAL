dosseg
displayStr macro s1
               lea dx , s1
               mov ah , 9
               int 21h
endm
;macro for displaying char
displayChar macro c1
                mov dl , c1
                mov ah , 2
                int 21h
endm
.model small
.stack 100h
.data
    nM     db "Numerator : $"
    dM     db "Denominator : $"
    qM     db "Quotient : $"
    rM     db "Remainder : $"
    inputM db "Input a number : $"
    ;first 8 bit variable for numerator
    n1     db ?
    ;second 8 bit variable for numerator
    n2     db ?
    d      db ?
    q      db ?
    r      db ?
    
.code
main proc
mov ax , @data
mov ds , ax
;taking input
;since ax is part ah part al
;we can take two 8 bits number in ah and al respectively
;and combine them to for 16 bit ax

displayStr inputM
;first 8 bit input
mov ah , 1
int 21h
mov n1 , al

;second 8 bit input
mov ah , 1
int 21h
mov n2 ,al
call endl
    ;inputting denominator
         displayStr  inputM
         mov         ah , 1
         int         21h
         mov         d , al
         call        endl

    ;displaying the numerator and denominator
         displayStr  nM
         displayChar n1
         displayChar n2
         call        endl
         displayStr  dM
         displayChar d
         call        endl

    ;since we need to combine ah and al
    ;we use AAD
    ;AAD IS ASCII BEFORE DIVISION
    ;it adjusts the value in ah and al to fit ax

         mov         ah , n1
         mov         al , n2
         mov         bl , d
    ;ASCII Correction
         sub         ah , 48
         sub         al , 48
         sub         bl , 48
    ;using the AAD code to make ax for ah and al
         AAD
         div         bl
    ;ASCII Correction
         add         al , 48
         add         ah , 48
         mov         q , al
         mov         r , ah
    ;displaying the results
         displayStr  qM
         displayChar q
         call        endl
         displayStr  rM
         displayChar r
         call        endl

         mov         ah , 4ch
         int         21h
    ;procedure for new line
endl proc
         mov         dl , 10
         mov         ah , 2
         int         21h
         ret
endl endp
main endp
end main
