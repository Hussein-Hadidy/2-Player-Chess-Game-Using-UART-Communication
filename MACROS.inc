DrawBoard MACRO i,j,startpos,endpos,startrowpos,endrowpos

    MOV AH,0ch
    MOV CX,0
    MOV DX,0



mov al,7
mov bl,8 
mov si,0

 OuterLoop: ;alternates on 8 rows

 add endrowpos,60
 
mainLoop: ;prints row of alternating colours

mov cx,startpos
Mov dx,startrowpos 
add endpos,60

; Drawing loop
drawLoopboard:
    INT 10h 
    INC CX
    ;INC BX
    CMP CX,endpos
JNE drawLoopboard 
	
    MOV CX , startpos
    INC DX
    CMP DX , endrowpos
JNE drawLoopboard

mov dx,startrowpos
Xchg al,bl
Add startpos,60
dec i
cmp i,0
jnz mainloop   

mov startpos,0
mov endpos,0
add startrowpos,60
mov i,8
xchg al,bl
dec j
cmp j,0
jnz OuterLoop


ENDM DrawBoard
    
ShowString  MACRO  STR
    push ax
    push dx
    mov ah,9h
    mov dx,offset STR
    int 21h       
    pop dx
    pop ax
ENDM ShowString 

MoveCursor MACRO  xcursor, ycursor
    push ax
    push dx
    push bx
    mov ah,2
    mov dl,xcursor
    mov dh,ycursor
    mov bx,0
    int 10h
    pop bx
    pop dx
    pop ax
ENDM MoveCursor

takeName MACRO
mov cx,15
mov si,0 

getname:
mov ah,0
int 16h 
cmp ah,01h
jne skipexit 
MOV AH,4CH
INT 21H  
skipexit:
cmp ah,28
je endname
cmp al,41h
jb skipchar
cmp al,7Ah
ja  skipchar 
cmp al,5Bh
je skipchar          
cmp al,5Ch
je skipchar 
cmp al,5Dh
je skipchar 
cmp al,5Eh
je skipchar 
cmp al,5Fh
je skipchar
cmp al,60h
je skipchar 
mov ah,2
mov dl,al
int 21h  

mov username[si], al
inc si

loop getname 
MoveCursor  4,13
ShowString entertocont
finishname:
mov ah,0
int 16h
cmp ah,28
je endname
jmp finishname
skipchar:
cmp cx,0
je endname
jmp getname

endname:  
mov username[si],'$'  ;To be able to print the username

mov ax, alphabet[0]
mov timervar,ax

endm takeName


InitialPiecies MACRO


    movecursor 61,5
    showstring username
    movecursor 81,5
    showstring othername
    lea ax,Filename

mov fileaddress,ax  
;start

mov startposx,0
mov startposy,0
mov cx,8

 drawRow:
mov ax,startposx
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
push cx
CALL  drawpieces
pop cx
add startposx,60
add fileaddress,8


loop drawRow

lea ax,Filename9

mov fileaddress,ax  
;start

mov startposx,0
mov startposy,60
mov cx,8

 drawRow2:
 
 
mov ax,startposx
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
push cx
CALL  drawpieces
pop cx
add startposx,60



loop drawRow2

lea ax,Filename17

mov fileaddress,ax  
;start

mov startposx,0
mov startposy,360
mov cx,8

 drawRow3:
mov ax,startposx
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
push cx
CALL  drawpieces
pop cx
add startposx,60

loop drawRow3

lea ax,Filename25

mov fileaddress,ax  
;start

mov startposx,0
mov startposy,420
mov cx,8

 drawRow4:
mov ax,startposx
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
push cx
CALL  drawpieces
pop cx
add startposx,60
add fileaddress,8
loop drawRow4

  
mov startposx,0
mov startposy,0
mov endposx,60
mov endposy,60
mov bordercolor,14

;;THIS SHOULD BE CHECKED AFTER TAKING USERNAMES INITIALLY TO DRAW FRAMES INITIALLY RIGHT, highlightp1 IS ZEROO FOR BOTH NOW
cmp highlightp1,1
je skipyellini
call drawpBorder   ; draw yellow frame first time
skipyellini:

mov startposx,0
mov startposy,420
mov endposx,60
mov endposy,480
mov bordercolor,3 ;cyan color

;;THIS SHOULD BE CHECKED AFTER TAKING USERNAMES INITIALLY TO DRAW FRAMES INITIALLY RIGHT, highlightp1 IS ZEROO FOR BOTH NOW
cmp highlightp1,1
jne skipcyanini
call drawpBorder2   ; draw cyan frame first time
skipcyanini:

mov ah,0
endm InitialPiecies

adjustyellowFrame MACRO
 
cmp startframexnew,420
ja skipdrawborder

cmp startframeynew,420
ja skipdrawborder
   
call setcurrFrame

mov bordercolor,14  ;cyan color
cmp highlightp1,1
je skipyell
call drawpBorder ; moves cyan frame

skipyell:
push bx
mov bx,startframexold
mov startposx,bx
mov bx,endframexold
mov endposx,bx
mov bx,startframeyold
mov startposy,bx
mov bx,endframeyold
mov endposy,bx
pop bx

cmp checkframemove,1
je moveoldframe


;procedure to move yellow frame

;jmp gameloop

moveoldframe:
cmp checkframemove,1
jne retlabel
push bx
mov bl,bordercolorold
mov bordercolor,bl
pop bx
cmp highlightp1,1
je skipyell2
call drawpBorder
skipyell2:
mov ah,0h  ;for yellow frame not to do movement more than once


skipdrawborder:

cmp startframexnew,420
ja resetcoordinates
cmp startframeynew,420
ja resetcoordinates
jmp retlabel
resetcoordinates:
mov checkframemove,0
mov ax,startframexold
mov startframexnew,ax

mov ax,startframeyold
mov startframeynew,ax

mov ax,endframexold
mov endframexnew,ax

mov ax,endframeyold
mov endframeynew,ax
retlabel:

endm adjustyellowFrame

 adjustcyanFrame MACRO
 
cmp startframe2xnew,420
ja skipdrawborder2

cmp startframe2ynew,420
ja skipdrawborder2

call setcurrFrame2

mov bordercolor,3  ;cyan color
cmp highlightp1,1
jne skipbor
call drawpBorder2 ; moves cyan frame
skipbor:
push bx
mov bx,startframe2xold
mov startposx,bx
mov bx,endframe2xold
mov endposx,bx
mov bx,startframe2yold
mov startposy,bx
mov bx,endframe2yold
mov endposy,bx
pop bx

cmp checkframe2move,1
je moveoldframe2


;procedure to move yellow frame

;jmp gameloop

moveoldframe2:
cmp checkframe2move,1
jne retlabel2
push bx
mov bl,bordercolorold2
mov bordercolor,bl
pop bx
cmp highlightp1,1
jne skipbor2
call drawpBorder2
skipbor2:
mov ah,0h  ;for yellow frame not to do movement more than once


skipdrawborder2:

cmp startframe2xnew,420
ja resetcoordinates2
cmp startframe2ynew,420
ja resetcoordinates2
jmp retlabel2
resetcoordinates2:

mov checkframe2move,0
mov ax,startframe2xold
mov startframe2xnew,ax

mov ax,startframe2yold
mov startframe2ynew,ax

mov ax,endframe2xold
mov endframe2xnew,ax

mov ax,endframe2yold
mov endframe2ynew,ax
retlabel2:
 endm adjustcyanFrame

EmptyMessage MACRO

MoveCursor 1,34
ShowString emptyMes

endm EmptyMessage




calcGameTime MACRO timershow

mov ah,2ch
int 21h  ; interupt to Get current system time in Dh-->seconds   Cl-->Minutes

mov al,cl
mov bl,60   
mul Bl ;result in ax contains curr time in seconds

mov dl,dh
mov dh,0
add ax,dx ;adds (minutes*60)+seconds
mov currgameTime,ax

sub ax,startTime  ;now ax has timer to display
 
MoveCursor  48,30
call print

endm calcGameTime

