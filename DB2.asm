dosseg
print macro st
            lea dx,st
            mov ah,9
            int 21h
endm
; print a single character 
printCh macro n
              mov dl,n
              add dl,48
              mov ah,2
              int 21h
endm
inputCh macro n
              mov ah,1
              int 21h
              sub al,48
              mov n,al
endm
.model small
.stack 100h
.data
      inp  db "Input a 2-digit number : $"
      num1 db ?
      num2 db ?
      deci db "Decimal Number = $"
      bin  db "Binary Number  = $ "
      line db 13,10,"$"
.code
main proc
            mov     ax,@data
            mov     ds,ax

            print   inp
            inputCh num1
            inputCh num2
            print   line
            print   deci
            printCh num1
            printCh num2
            print   line
            print   bin
            xor     dx,dx
            mov     bx,2
            mov     cl,0
            mov     ah,num1
            mov     al,num2
            AAD
      again:
            div     bx
            push    dx
            inc     cl
            mov     ah,0      
            cmp     ax,0
            jnz     again
    
      ; print binary number
      L1:   
            pop     dx
            add     dx,48
            mov     ah,2
            int     21h
            loop    L1
            mov     ah,4ch
            int     21h
main endp
end main