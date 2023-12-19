
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model small
.stack 100h

.data   
asciiArt db "  \ \      / /__| | ___ ___  _ __ ___   ___   ", 0Dh, 0Ah
         db "   \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \  ", 0Dh, 0Ah
         db "    \ V  V /  __/ | (_| (_) | | | | | |  __/  ", 0Dh, 0Ah
         db "     \_/\_/ \___|_|\___\___/|_| |_| |_|\___|  ", 0Dh, 0Ah, 24h
mess1 db 'Welcome to the Self Serving Kiosk of our Restaurant!', 0Dh, 0Ah, 24h
mess2 db 'Delight in the art of fine dining, where exceptional meals and outstanding service takes the center stage', 0Dh, 0Ah, 24h
invalid db 'Sorry! Invalid Choice', 0Dh, 0Ah, 24h
more db 'Any more orders? (yes - 1)', 0Dh, 0Ah, 24h
qty db 'Enter the quantity :', 0Dh, 0Ah, 24h 
cst db 'The cost is : Rs ', 24h 
bill db 'The bill amount is : Rs ', 24h
final db 'Order Placed! Hope you have a good meal!', 0Dh, 0Ah, 24h      
prompt db 'Options galore! Take your pick and dive in.', 0Dh, 0Ah, 24h
pick db 'Pick One!', 0Dh, 0Ah, 24h
menu db '1. Indian', 0Dh, 0Ah
     db '2. Chinese', 0Dh, 0Ah  
     db '3. Italian', 0Dh, 0Ah
     db '4. Exit', 0Dh, 0Ah, 24h
     db '$' 
Imenu db '1. Dosa', 0Dh, 0Ah
      db '2. Idli', 0Dh, 0Ah  
      db '3. Pongal', 0Dh, 0Ah
      db '4. Change Cuisine', 0Dh, 0Ah, 24h
      db '$'
Cmenu db '1. Mapo Tofu', 0Dh, 0Ah
      db '2. Chow Mein', 0Dh, 0Ah  
      db '3. Char Siu', 0Dh, 0Ah
      db '4. Change Cuisine', 0Dh, 0Ah, 24h
      db '$'
Itmenu db '1. Panzenella', 0Dh, 0Ah
       db '2. Bruschetta', 0Dh, 0Ah  
       db '3. Tiramisu', 0Dh, 0Ah
       db '4. Change Cuisine', 0Dh, 0Ah, 24h
       db '$'      
nl db  0Dh, 0Ah, 24h    
amt db 0
pr db 0
flag db 0
q db 0
r db 0
x dw 0
y dw 0
z dw 0                                                                                                                                  


.code
main PROC 
    
    mov ax, @data
    mov ds, ax  
    
    mov ah, 09h
    lea dx, asciiArt
    int 21h   
    
    call newline
    
    mov ah, 09h
    lea dx, mess1
    int 21h 
    
    call newline
    
    mov ah, 09h
    lea dx, mess2
    int 21h
    
 L: call newline
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    mov ah, 09h
    lea dx, menu
    int 21h 
    
    mov ah, 1
    int 21h
    sub al, '0'
    
    cmp al, 1
    je Indian
    cmp al, 2
    je Chinese
    cmp al, 3
    je Italian
    cmp al, 4
    je Payment
    
    
    call newline                          
    mov ah, 09h
    lea dx, invalid
    int 21h
    jmp exit_kiosk  
    
Indian: call newline
   
        mov ah, 09h
        lea dx, pick
        int 21h 
 
        mov ah, 09h
        lea dx, Imenu
        int 21h 
        
        mov ah, 1
        int 21h
        sub al, '0'
        
        cmp al, 1
        je Dosa
        cmp al, 2
        je Idli
        cmp al, 3
        je Pongal
        cmp al, 4
        je L 
        call newline                          
        mov ah, 09h
        lea dx, invalid
        int 21h
        jmp exit_kiosk
         
   Dosa: call newline 
         mov al, 10 
         mov flag, 1
         call dish 
         
   Idli: call newline 
         mov al, 5 
         mov flag, 1
         call dish 
   
 Pongal: call newline 
         mov al, 15
         mov flag, 1
         call dish   
         
Chinese: call newline
   
         mov ah, 09h
         lea dx, pick
         int 21h 
 
         mov ah, 09h
         lea dx, Cmenu
         int 21h 
        
         mov ah, 1
         int 21h
         sub al, '0'
        
         cmp al, 1
         je MapoTofu
         cmp al, 2
         je ChowMein
         cmp al, 3
         je CharSiu
         cmp al, 4
         je L
         call newline                          
         mov ah, 09h
         lea dx, invalid
         int 21h
         jmp exit_kiosk 
         
MapoTofu: call newline 
          mov al, 20 
          mov flag, 2
          call dish
          
ChowMein: call newline 
          mov al, 25 
          mov flag, 2
          call dish
          
 CharSiu: call newline 
          mov al, 30 
          mov flag, 2
          call dish                              

Italian: call newline
   
         mov ah, 09h
         lea dx, pick
         int 21h 
 
         mov ah, 09h
         lea dx, Itmenu
         int 21h 
        
         mov ah, 1
         int 21h
         sub al, '0'
        
         cmp al, 1
         je Panzenella
         cmp al, 2
         je Bruschetta
         cmp al, 3
         je Tiramisu
         cmp al, 4
         je L 
         call newline                          
         mov ah, 09h
         lea dx, invalid
         int 21h
         jmp exit_kiosk
         
Panzenella: call newline 
            mov al, 35 
            mov flag, 3
            call dish 
         
Bruschetta: call newline 
            mov al, 40 
            mov flag, 3
            call dish 
   
Tiramisu: call newline 
          mov al, 45 
          mov flag, 3
          call dish                   
    
   
Payment: call newline
         mov ah, 09h
         lea dx, bill
         int 21h  
         mov dx,0000 
         mov ah, 0
         mov al,amt
         mov bx,100 
         div bx
         mov x,ax
         mov y,dx
         mov dx,00
         mov ax,y
         mov bx,10
         div bx
         mov y,ax
         mov z,dx  
         add x, 30h
         add y, 30h
         add z, 30h  
         mov dx, x
         mov ah, 02
         int 21h    
         mov dx, y
         mov ah, 02
         int 21h 
         mov dx, z
         mov ah, 02
         int 21h
         call newline
         mov ah, 09h
         lea dx, final
         int 21h  
         jmp exit_kiosk

exit_kiosk: mov ah, 0
            int 16H 
            ret
    
main ENDP

newline PROC 
    mov dx, offset nl
    mov ah, 09h
    int 21h
    ret
newline ENDP 

cost PROC 
    mov dx, offset cst
    mov ah, 09h
    int 21h
    ret
cost ENDP 

dish PROC 
    
    mov pr, al
    add amt, al
    push ax
    call cost 
    pop ax 
    mov ah, 0
    mov bl, 10
    div bl
    mov q, al
    mov r, ah   
    add q, 30h
    add r, 30h
    mov ah, 2
    mov dl, q
    int 21h 
    mov ah, 2
    mov dl, r
    int 21h 
    call newline
    mov ah, 09h
    lea dx, qty
    int 21h 
    mov ah, 1
    int 21h 
    sub al, '0'
    mov bl, al 
    mov al, pr
    mul bl
    sub al, pr
    add amt, al        
    call newline
    mov ah, 09h
    lea dx, more
    int 21h
    mov ah, 1
    int 21h
    sub al, '0'
    cmp al, 1
    je label
    jmp Payment 
    
label: cmp flag, 1
       jz Indian
       cmp flag, 2
       jz Chinese
       cmp flag, 3
       jz Italian 
   
    ret
    
dish ENDP    

END
