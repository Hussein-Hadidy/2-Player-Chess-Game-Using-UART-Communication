include MACROS.inc


EXTRN invites:Far
public sentinvitechat,sentinvitegame,recinvitechat,recinvitegame,player1,highlightp1
public SENDKEY
public intializePort
public chatfunc2
public printMenu
public sentchat
public sentgame
public receivedchat
public receivedgame
public othername
public gameblock
public movcursor
public movcursorgame


.Model huge

.Stack 400
.Data

alphabet dw 'A','C','E','G','I','K','M','O','Q','T','V','Z'
loopalpha dw 0
timervar dw  ?


IY DB 1D
IX DB 0D

IY2 DB 6 
IX2 DB 61

OX DB 39D
OY DB 1D

OX2 DB 81D
OY2 DB 6D
VLine db '#'

i1 DB  8
j1 DB  8
timershow  db     "Timer: $"
approveeaten  db  1
approveeaten2 db  1
approveCastleright   db  0
castleMessage db  "Nice Castle!              $"

sentchat db      " was sent a chat invite from you                  $"
receivedchat db  " sent you a chat invite to accept press F1        $"
sentgame db      " was sent a game invite from you                  $"
receivedgame db  " sent you a game invite to accept press F2        $"


approveCastleleft   db  0
approveCastleright2   db  0
approveCastleleft2   db  0
initialkingmove db 0
initialkingmove2 db 0
firstQclick db 0
firstSpaceclick db 0
startpos1 DW 0 
endpos1   DW 0
startrowpos1 DW 0
endrowpos1  DW 0
startposx DW 0
startposy DW 0
endposx DW 0
endposy DW 0  
horsecolumn db 0
horserow db 0

startTime    dw    0
currgameTime dw    0
numTimer     db    ?,'$'
kingcolumn db 0
kingrow db 0
scrollmessage db '                   $'
startframexold DW 0
startframeyold DW 0
endframexold DW 60
endframeyold DW 60

sentinvitechat db 0
sentinvitegame db 0

recinvitechat db 0
recinvitegame db 0

startframexnew DW 0
startframeynew DW 0
endframexnew DW 60     ;yellowframe
endframeynew DW 60


startframe2xold DW 0
startframe2yold DW 420
endframe2xold DW 60     
endframe2yold DW 480

startframe2xnew DW 0
startframe2ynew DW 420
endframe2xnew DW 60     ;yellowframe
endframe2ynew DW 480

readytosend db 0
prevpiecex   dw 0
prevpiecey   dw 0

tempx        dw 0
tempy        dw 0
tempx2        dw 0
tempy2       dw 0
prevpiecex2   dw 0
prevpiecey2  dw 0
loopindex dw 0
fileaddress Dw 0

loopcounter DB 8

bordercolor db ?
prevpiececolor db ?
prevpiececolor2 db ?
bordercolorhighlight db 4
bordercolorhighlight2 db 5
bordercolorold db ?
bordercolorold2 db ?
checkframemove db 0
checkframe2move db 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

player1  db   0
flag     db   0
highlightp1 db 0
receivegame db 0
sendgame    db 0


requestflag  db  0
enterName  db   "Please enter your name: $"
pressEnter db   "Name must not exceed 15 characters, Press Enter key to continue, ESC to exit $"
entertocont db  "Reached max limit, press enter to continue                                   $"
hellouser  db  "Hello "
username db 20 dup(?)  
othername db 20 dup(?)  
finishednames db 0
finishednamer db 0
namecount db ?


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

currPieceDelay db  0
lastpieceDelay db 0
currPieceDelay2 db  0
lastpieceDelay2 db 0


Filename DB  'bRk.bin',0
Filename2 DB 'bKn.bin',0 
Filename3 DB 'bBp.bin',0 
Filename4 DB 'bQu.bin',0 
Filename5 DB 'bKi.bin',0 
Filename6 DB 'bBp.bin',0 
Filename7 DB 'bKn.bin',0 
Filename8 DB 'bRk.bin',0
Filename9 DB 'bPn.bin',0
Filename17 DB 'wPn.bin',0
Filename25 DB 'wRk.bin',0
Filename26 DB 'wKn.bin',0
Filename27 DB 'wBp.bin',0
Filename28 DB 'wQu.bin',0
Filename29 DB 'wKi.bin',0
Filename30 DB 'wBp.bin',0
Filename31 DB 'wKn.bin',0
Filename32 DB 'wRk.bin',0
filetimered db 'redtime.bin',0
filetimeyell db 'yell.bin',0
filetimegreen db 'gre.bin',0
promarr       db 'arr.bin',0
yellowframefile db 'border.bin',0

promotedtime  db   "Powerup decreased delay!  $"
startChattingMessage db   "To start chatting press F1$"
startGame db   "To start the game press F2$"
endProgram db   "To end the program press ESC$"
Status     db     "Status Bar:           $"
gameSarted db     "Game Started          $"
wbishopDied  db   "White Bishop Died         $"
bbishopDied  db   "Black Bishop Died         $"
wkingDied  db     "White King Died           $"
bkingDied  db     "Black King Died           $"
wQueenDied  db    "White Queen Died          $"
bQueenDied  db    "Black Queen Died          $"
wPawnDied  db     "White Pawn Died           $"
bPawnDied  db     "Black Pawn Died           $"
wRookDied  db     "White Rook Died           $"
bRookDied  db     "Black Rook Died           $"
wKnightDied  db   "White Knight Died         $"
bKnightDied  db   "Black Knight Died         $"
wkingInCheck db   "White King Check          $"
bkingInCheck db   "Black King Check          $"
whitepawnpromote db   "White pawn promoted!  $"
blackpawnpromote db   "black pawn promoted!  $"
whitewon     db   "White won!                $"
blackwon     db   "Black won!                $"
emptyMes     db   "                          $"
Notificationbar     db   "--------------------------------------------------------------------------------$"
Notificationbarmess db   " Notification Bar $"

codeDied     dw    0

currPieceCode   dw  0
lastpiececode   dw  0
timepiececode   db  0
currPieceCode2  dw  0
lastpiececode2  dw  0
lastpieceindex  dw  0
currHighindex   dw  0
currHighindex2  dw  0
currPieceIndex2 dw  0
lastpieceindex2 dw  0

currPieceIndex dw  0
borderindex    dw  0
timeindex    dw  0
currPieceName  db  9 Dup(0)


VALUE Db  ?

receivingx  db 0
receivingy  db 0

sendingx  db 0
sendingy  db 0


VirtualBoard LABEL BYTE
; bRk:1  bKn:2  bBp:3  bQu:4  bKi:5  bPw:6       codes for pieces
; wRk:7  wKn:8  wBp:9  wQu:10  wKi:11  wPw:12  
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Vrow1  db   1, 2, 3, 4, 5, 3, 2, 1 
Vrow2  db   6, 6, 6, 6, 6, 6, 6, 6         ;Virtual board: an array of our piece codes in their correct positions on the board
Vrow3  db   0, 0, 0, 0, 0, 0, 0, 0         ;for any piece index, its index +- 8 gives piece directly infront of it
Vrow4  db   0, 0, 0, 0, 0, 0, 0, 0   
Vrow5  db   0, 0, 0, 0, 0, 0, 0, 0   
Vrow6  db   0, 0, 0, 0, 0, 0, 0, 0 
Vrow7  db   12,12,12,12,12,12,12,12 
Vrow8  db   7, 8, 9,10,11, 9, 8, 7   

; board represents highlighted position 1-->highlighted

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Hrow1  db  0,0,0,0,0,0,0,0
Hrow2  db  0,0,0,0,0,0,0,0
Hrow3  db  0,0,0,0,0,0,0,0    ;Black's Highlight array:contains ones in any position legal for a black piece to move to,updated after every attempt to move
Hrow4  db  0,0,0,0,0,0,0,0    ;Index by dividing by 8 quotient-->y(row), remainder-->x(column)
Hrow5  db  0,0,0,0,0,0,0,0
Hrow6  db  0,0,0,0,0,0,0,0
Hrow7  db  0,0,0,0,0,0,0,0
Hrow8  db  0,0,0,0,0,0,0,0

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
H2row1  db  0,0,0,0,0,0,0,0
H2row2  db  0,0,0,0,0,0,0,0
H2row3  db  0,0,0,0,0,0,0,0    ;White's Highlight array:contains ones in any position legal for a white piece to move to,updated after every attempt to move
H2row4  db  0,0,0,0,0,0,0,0    ;Index by dividing by 8 quotient-->y(row), remainder-->x(column)
H2row5  db  0,0,0,0,0,0,0,0
H2row6  db  0,0,0,0,0,0,0,0
H2row7  db  0,0,0,0,0,0,0,0
H2row8  db  0,0,0,0,0,0,0,0

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Trow1  dw  0,0,0,0,0,0,0,0
Trow2  dw  0,0,0,0,0,0,0,0
Trow3  dw  0,0,0,0,0,0,0,0    ;Time array:contains time at which piece moved in same position as the piece in the virtual board
Trow4  dw  0,0,0,0,0,0,0,0    ;Index by dividing by 8 quotient-->y(row), remainder-->x(column)
Trow5  dw  0,0,0,0,0,0,0,0
Trow6  dw  0,0,0,0,0,0,0,0
Trow7  dw  0,0,0,0,0,0,0,0
Trow8  dw  0,0,0,0,0,0,0,0

up1  db      3, 3, 3, 3, 3, 3, 3, 3
up2  db      3, 3, 3, 3, 3, 3, 3, 3
up3  db      3, 3, 3, 3, 3, 3, 3, 3
up4  db      3, 3, 3, 3, 3, 3, 3, 3 ;Index by dividing by 8 quotient-->y(row), remainder-->x(column)
up5  db      3, 3, 3, 3, 3, 3, 3, 3
up6 db       3, 3, 3, 3, 3, 3, 3, 3
up7 db       3, 3, 3, 3, 3, 3, 3, 3
up8 db       3, 3, 3, 3, 3, 3, 3, 3

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Filehandle DW ?

fData DB 60*60 dup(0)
fData2 DB 60*60 dup(0)

;Tracking delays of black pieces
bRooktime       dw   0
bKnighttime     dw   0
bBishoptime     dw   0
bQueentime      dw   0
bKingtime       dw   0
bPawntime       dw   0

currTime       dw    0
pieceTime     dw     0
redTime     dw     0
yellowTime     dw     0
greenTime     dw     0
approvemove   db     0
approvemove2  db     0

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
.Code


configtime proc far
push ax
push bx
push cx
push dx
push si
push di

mov bl,lastpieceDelay
mov up1[si],bl


pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
configtime endp

configtime2 proc far
push ax
push bx
push cx
push dx
push si
push di

mov bl,lastpieceDelay2
mov up1[si],bl

pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
configtime2 endp


randomNum proc far
push ax
push bx
push cx
push dx
push si
push di

   mov cx,5
   mov si,0
   mov bx,0
   fillpower:     
   mov dx,timervar
   mov bx,4
   mov ax,dx
   mul bx
   mov dx,ax
   mov  ax, dx
   xor  dx, dx
   add  bx, 2
   div  bx       ; here dx contains the remainder of the division - from 0 to 9 
   mov si,dx
   mov up1[si],1
   loop fillpower

   mov cx,5
   mov si,0
   mov bx,0
   fillpower2:     
   mov dx,timervar
   mov bx,4
   mov ax,dx
   mul bx
   mov dx,ax
   xor  dx, dx
   add  bx, 2
   div  bx       ; here dx contains the remainder of the division - from 0 to 9 
   mov si,dx
   add si,48d
   mov up1[si],1
   loop fillpower2

  inc loopalpha
  mov di,loopalpha
  mov ax,alphabet[di]
  mov timervar,ax
     
   pop di
   pop si
   pop dx
   pop cx
   pop bx
   pop ax
   
ret
randomNum endp 

resetgame proc far
push ax
push bx
push cx
push dx
push si
push di

mov i1 ,  8
mov j1 ,  8
mov approveeaten  , 1
mov approveeaten2 ,  1
mov approveCastleright   ,  0


mov approveCastleleft   ,  0
mov approveCastleright2   , 0
mov approveCastleleft2   ,  0
mov initialkingmove , 0
mov initialkingmove2 , 0
mov firstQclick , 0
mov firstSpaceclick , 0
mov startpos1 , 0 
mov endpos1   , 0
mov startrowpos1 , 0
mov endrowpos1  , 0
mov startposx , 0
mov startposy , 0
mov endposx , 0
mov endposy , 0  
mov horsecolumn , 0
mov horserow , 0


mov startTime    ,    0
mov currgameTime ,    0
mov numTimer     ,0
mov kingcolumn , 0
mov kingrow , 0

mov startframexold , 0
mov startframeyold , 0
mov endframexold , 60
mov endframeyold , 60

mov sentinvitechat , 0
mov sentinvitegame , 0

mov recinvitechat , 0
mov recinvitegame , 0

mov startframexnew , 0
mov startframeynew , 0
mov endframexnew , 60     ;yellowframe
mov endframeynew , 60


mov startframe2xold , 0
mov startframe2yold , 420
mov endframe2xold , 60     
mov endframe2yold , 480

mov startframe2xnew , 0
mov startframe2ynew , 420
mov endframe2xnew , 60     ;yellowframe
mov endframe2ynew , 480

mov readytosend , 0
mov prevpiecex   , 0
mov prevpiecey   , 0

mov tempx        , 0
mov tempy        , 0
mov tempx2        , 0
mov tempy2       , 0
mov prevpiecex2   , 0
mov prevpiecey2  , 0
mov loopindex , 0
mov fileaddress , 0

mov loopcounter , 8


mov bordercolorhighlight , 4
mov bordercolorhighlight2 , 5

mov checkframemove , 0
mov checkframe2move , 0

mov codeDied     ,    0


mov currPieceDelay  ,0
mov lastpieceDelay  ,0
mov currPieceDelay2 ,0
mov lastpieceDelay2 ,0


mov currPieceCode   ,  0
mov lastpiececode   ,  0
mov timepiececode   ,  0
mov currPieceCode2  ,  0
mov lastpiececode2  ,  0
mov lastpieceindex  ,  0
mov currHighindex   ,  0
mov currHighindex2  ,  0
mov currPieceIndex2 ,  0
mov lastpieceindex2 ,  0

mov currPieceIndex ,  0
mov borderindex    ,  0
mov timeindex    ,  0

mov currTime       ,    0
mov pieceTime     ,     0
mov redTime     ,     0
mov yellowTime     ,     0
mov greenTime     ,     0
mov approvemove   ,     0
mov approvemove2  ,     0
mov iy2,6
mov oy2,6
mov cx,64
mov si,0
mov di,0
resethighlights:
mov hrow1[si],0
mov h2row1[si],0
mov trow1 [di],0
add di,2
inc si

loop resethighlights

mov Vrow1[0],1
mov Vrow1[1],2
mov Vrow1[2],3
mov Vrow1[3],4
mov Vrow1[4],5
mov Vrow1[5],3
mov Vrow1[6],2
mov Vrow1[7],1
mov cx,8
mov si,0
putwpawns:
mov Vrow2[si],6
inc si
loop putwpawns

mov cx,32
mov si,0
putgaps:
mov Vrow3[si],0
inc si
loop putgaps
mov cx,8
mov si,0
putbpawns:
mov Vrow7[si],12
inc si
loop putbpawns

mov Vrow8[0],7
mov Vrow8[1],8
mov Vrow8[2],9
mov Vrow8[3],10
mov Vrow8[4],11
mov Vrow8[5],9
mov Vrow8[6],8
mov Vrow8[7],7



mov cx,64
mov si,0
resetdelay:
mov up1[si] , 3
inc si
loop resetdelay



pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
resetgame endp

movcursor proc far
  push ax
    push dx
    push bx
    mov ah,2
    mov dl,4
    mov dh,20
    mov bx,0
    int 10h
    pop bx
    pop dx
    pop ax
ret
movcursor endp
movcursorgame proc far
  push ax
    push dx
    push bx
    mov ah,2
    mov dl,4
    mov dh,22
    mov bx,0
    int 10h
    pop bx
    pop dx
    pop ax
ret
movcursorgame endp

printMenu proc far
;MAINMENUUU
;Text Mode
mov ah,0 
mov al,3
int 10h
MoveCursor  4,2
showstring hellouser
MoveCursor  10,2
ShowString username
MoveCursor  4,5
ShowString startChattingMessage
MoveCursor  4,9
ShowString startGame
MoveCursor  4,13
ShowString endProgram
movecursor 0,18
showstring Notificationbar
movecursor 0,17
showstring Notificationbarmess

ret
printMenu endp

backspace proc far
push ax
push bx
push cx
push dx
push si
push di

cmp ix,0
jne normalback
cmp iy,1
je returnbackspace
dec iy
mov ix,37

normalback:
cmp ix,0
je specialback 
dec ix 
specialback:
mov AH,2
mov DL,IX
MOV DH,IY
int 10h

 
  mov al,' '  ;try ascii of space if this doesnt work
  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 0     ; Color (blue)
  MOV CX, 1      ; Character count
  INT 10h


returnbackspace:
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
 backspace endp


inlineback proc far
push ax
push bx
push cx
push dx
push si
push di  ;start x=61          ;end x=79              ;start y=0        end y=36

cmp ix2,61
jne normalback2
cmp iy2,6
je returnbackspace2
dec iy2
mov ix2,79

normalback2:
cmp ix2,61
je specialback2
dec ix2
specialback2:
mov AH,2
mov DL,IX2
MOV DH,IY2
int 10h

 
  mov al,' '  ;try ascii of space if this doesnt work
  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 0     ; Color (blue)
  MOV CX, 1      ; Character count
  INT 10h


returnbackspace2:
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
 inlineback endp


 inlinebackrec proc far
push ax
push bx
push cx
push dx
push si
push di     ;start x=81    ;start y=0       ;end x=99     ; end y=36

cmp ox2,81
jne normalbackrec2
cmp oy2,6
je returnbackrec2
dec oy2
mov ox2,99

normalbackrec2:
cmp ox2,81
je specialbackrec2
dec ox2 
specialbackrec2:
mov AH,2
mov DL,oX2
MOV DH,oY2
int 10h

 
  mov al,' '  ;try ascii of space if this doesnt work
  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 0     ; Color (blue)
  MOV CX, 1      ; Character count
  INT 10h


returnbackrec2:
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
 inlinebackrec endp

backspacerec proc far
push ax
push bx
push cx
push dx
push si
push di

cmp ox,39
jne normalbackrec
cmp oy,1
je returnbackrec
dec oy
mov ox,79

normalbackrec:
cmp ox,39
je specialbackrec
dec ox 
specialbackrec:
mov AH,2
mov DL,oX
MOV DH,oY
int 10h

 
  mov al,' '  ;try ascii of space if this doesnt work
  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 0     ; Color (blue)
  MOV CX, 1      ; Character count
  INT 10h


returnbackrec:
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
 backspacerec endp

CursorQueen  proc far
  push ax
    push dx
    push bx
    mov ah,2
    mov dl,1
    mov dh,32
    mov bx,0
    int 10h
    pop bx
    pop dx
    pop ax
ret
CursorQueen endp

exchangecolor proc far
push ax
push bx
mov ax,loopindex
mov bx,8
div bl
cmp ah,7
pop bx
pop ax
je noexchangetime

xchg al,bl ;to alternate between light grey and dark grey whilst traversing the squares
noexchangetime:
ret
exchangecolor endp

delay proc far                ;causes noticable delay in drawing of piece whilst moving so that it appears as if it moves across the board(Animation)
push ax
push bx
push cx
push dx


mov cx,30000         
delayloop:
mov ax,ax
loop delayloop


pop dx
pop cx
pop bx
pop ax
ret 
delay endp
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
compareTimes proc far    ;compare's current computer time with a piece's time in the time array to determine if it can move
mov approvemove,1
push ax
push cx 
push dx
push bx
push si
mov si,lastpieceindex

mov ax,si                    
mov bx,2
mul bl                  ;multiply index by 2 because time array is an array of words i.e 2 bytes each
mov si,ax
mov ax,Trow1[si]

mov piecetime,ax

mov ah,2ch
int 21h  ; interupt to Get current system time in Dh-->seconds   Cl-->Minutes

mov al,cl
mov bl,60   
mul Bl ;result in ax contains curr time in seconds

mov dl,dh
mov dh,0
add ax,dx ;adds (minutes*60)+seconds
mov currTime,ax

sub ax,pieceTime          ;subs piecetime from current time to determine if 3 seconds have passed so that piece can move again i.e approvemove--->1
cmp ax,3
jae approvemoved
mov approvemove,0     
jmp returntimes

approvemoved:
mov Trow1[si],0    ;piece was allowed to move, so we reset the time value in that position to zero
mov ax,currTime
mov si ,currPieceIndex
mov ax,si
mov bx,2
mul bl
mov si,ax
mov ax,currTime
mov di,lastpieceindex
MoveCursor 40,32
ShowString emptyMes
cmp up1[di],1
jne contnorm1
MoveCursor 40,32
ShowString promotedtime
sub ax,2
contnorm1:
mov Trow1[si],ax   ;at piece's new position,time at which it moved is stored in the corresponding slot in time array


returntimes:
pop si
pop bx
pop dx
pop cx
pop ax
ret
compareTimes endp

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

compareTimes2 proc far
mov approvemove2,1
push ax
push cx 
push dx
push bx
push si
mov si,lastpieceindex2
mov ax,si
mov bx,2
mul bl
mov si,ax
mov ax,Trow1[si]

mov piecetime,ax




mov ah,2ch
int 21h  ;Got current system time in Dh-->seconds   Cl-->Minutes

mov al,cl
mov bl,60
mul Bl ;result in ax contains curr time in seconds

mov dl,dh
mov dh,0
add ax,dx ;adds (minutes*60)+seconds
mov currTime,ax

sub ax,pieceTime
cmp ax,3
jae approvemoved2
mov approvemove2,0
jmp returntimes2

approvemoved2:
mov Trow1[si],0
;mov time1[si],0
mov ax,currTime
mov si ,currPieceIndex2
mov ax,si
mov bx,2
mul bl
mov si,ax
mov ax,currTime

mov di,lastpieceindex2

MoveCursor 40,32
ShowString emptyMes

cmp up1[di],1
jne contnorm
sub ax,2
MoveCursor 40,32
ShowString promotedtime
contnorm:
mov Trow1[si],ax
;mov Time1[si],1



returntimes2:
pop si
pop bx
pop dx
pop cx
pop ax
ret
compareTimes2 endp



;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
drawpBorder PROC far   ;draws the frame in a position
dec endposx  ;shifts the border one pixel left
dec endposy   ;shifts the border one pixel up

MOV AH,0ch
mov al,bordercolor
MOV CX,startposx
MOV DX,startposy

horizontal1:
int 10h
inc CX                    
cmp Cx,endposx
jnz horizontal1
vertical1:
int 10h                    ;simply procedure to draw a hollow square to be used as a cursor and in highlighting
inc Dx
cmp Dx,endposy
jnz vertical1
horizontal2:
int 10h
dec Cx
cmp Cx,startposx
jnz horizontal2
vertical2:
int 10h
dec Dx
cmp Dx,startposy
jnz vertical2

RET
drawpBorder ENDP
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
drawpBorder2 PROC far
sub endposx,2  ;shifts the border two pixel left
sub endposy,2   ;shifts the border two pixel 
add startposx,1        ;shifts the border two pixel right
add startposy,1   ; shifts the border two pixel down
MOV AH,0ch
mov al,bordercolor
MOV CX,startposx
MOV DX,startposy
horizontal12:
int 10h
inc CX
cmp Cx,endposx
jnz horizontal12
vertical12:
int 10h
inc Dx
cmp Dx,endposy
jnz vertical12
horizontal22:                ;simply procedure to draw a hollow square to be used as a cursor and in highlighting
int 10h
dec Cx
cmp Cx,startposx
jnz horizontal22
vertical22:
int 10h
dec Dx
cmp Dx,startposy
jnz vertical22

RET
drawpBorder2 ENDP

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
borderatindex proc far  ;calculates x and y coordinates from index then calls drawborder(the function above)

cmp highlightp1,0
je skipdrawp2
ret
skipdrawp2:
push bx
push ax
mov bl,8
mov bh,0
mov ax,borderindex
div bl
mov bh,0
mov bl,ah
mov startposx,bx
mov bh,0                      ;special case of the draw border functions above ,but instead using x and y coordinates directly, it is sent an index 
                              ;from the virtual board to draw in 
mov bl,AL
mov startposy,bx
mov ax,startposx
mov bl,60
MUL Bl ;AX=Al*bl
mov startposx,ax

mov ax,startposy
mov bl,60
MUL Bl ;AX=Al*bl
mov startposy,ax

mov ax,startposx
Add ax,60

mov endposx,ax

mov ax,startposy
Add ax,60
mov endposy,ax
mov al,bordercolorhighlight
mov bordercolor,al  ;commented because clear highlights also uses this function(clear highlights will set bodercolor to 4 when its done)

add startposx,2      ;to let the highlight mark go depper in the  box
sub endposx,2 
add startposy,2
sub endposy,2
CALL drawpBorder
pop ax
pop bx
ret
borderatindex endp

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

borderatindex2 proc far  ;calculates x and y coordinates from index then calls drawborder(the function above)

cmp highlightp1,1
je skipdrawp1
ret
skipdrawp1:
mov bl,8
mov bh,0
mov ax,borderindex
div bl
mov bh,0
mov bl,ah
mov startposx,bx
mov bh,0
mov bl,AL
mov startposy,bx
mov ax,startposx
mov bl,60
MUL Bl ;AX=Al*bl
mov startposx,ax
                              ;special case of the draw border functions above ,but instead using x and y coordinates directly, it is sent an index 
                              ;from the virtual board to draw in
mov ax,startposy
mov bl,60
MUL Bl ;AX=Al*bl
mov startposy,ax

mov ax,startposx
Add ax,60

mov endposx,ax

mov ax,startposy
Add ax,60
mov endposy,ax
mov al,bordercolorhighlight2
mov bordercolor,al  ;commented because clear highlights also uses this function(clear highlights will set bodercolor to 4 when its done)

add startposx,2      ;to let the ehighlight mark go depper in the  box
sub endposx,2 
add startposy,2
sub endposy,2
CALL drawpBorder

ret
borderatindex2 endp
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalRook PROC far  ;marks all legal positions that a black rook can currently move to and stores them in highlight array

mov si,currPieceIndex
rookDown:

add si,8 ;got index down the rook
mov borderindex,si
cmp si,63
ja endrookdown
mov al,Vrow1[si]
cmp al,0
jne endrookdown
Call borderatindex
mov Hrow1[si],1

jmp rookDown

endrookdown:
cmp si,63
ja rookup
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jb rookup
mov borderindex,si
Call borderatindex
mov Hrow1[si],1
rookup:
mov si,currPieceIndex

rookuploop:

sub si,8 ;got index down the rook
mov borderindex,si
cmp si,100
ja endrookup
mov al,Vrow1[si]
cmp al,0
jne endrookup
Call borderatindex
mov Hrow1[si],1
jmp rookuploop

endrookup:
cmp si,100 ;;this indicates number in si register is very large ie negative 
ja rookright ;reached end of board
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jb rookright
mov borderindex,si
Call borderatindex
mov Hrow1[si],1
rookright:

mov si,currPieceIndex

rookrightloop:

inc si
mov borderindex,si
mov ax,si
mov bx,8
div bl
cmp ah,0 ;ie reached the end of the row
je endrookright
mov al,Vrow1[si]
cmp al,0

jne endrookright

Call borderatindex  ;draws frame at this index
mov Hrow1[si],1
jmp rookrightloop

endrookright:
mov ax,si
mov bx,8
div bl
cmp ah,0
je rookleft
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jb rookleft
mov borderindex,si
Call borderatindex
mov Hrow1[si],1
rookleft:

mov si,currPieceIndex

rookleftloop:

dec si
mov borderindex,si
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7 ;ie reached the end of the row
je endrookleft
mov al,Vrow1[si]
cmp al,0

jne endrookleft

Call borderatindex
mov Hrow1[si],1
jmp rookleftloop

endrookleft:
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7
je endendrook
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jb endendrook
mov borderindex,si
Call borderatindex
mov Hrow1[si],1
endendrook:


ret
markLegalRook endp
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
markLegalRook2 PROC far  ;marks all legal positions that a white rook can currently move to and stores them in highlight array

mov si,currPieceIndex2

rookDown2:

add si,8 ;got index down the rook
mov borderindex,si
cmp si,63
ja endrookdown2
mov al,Vrow1[si]
cmp al,0
jne endrookdown2
Call borderatindex2
mov H2row1[si],1

jmp rookDown2

endrookdown2:
cmp si,63
ja rookup2
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jae rookup2
mov borderindex,si
Call borderatindex2
mov H2row1[si],1
rookup2:
mov si,currPieceIndex2

rookuploop2:

sub si,8 ;got index down the rook
mov borderindex,si
cmp si,100
ja endrookup2
mov al,Vrow1[si]
cmp al,0
jne endrookup2
Call borderatindex2
mov H2row1[si],1
jmp rookuploop2

endrookup2:
cmp si,100 ;;this indicates number in si register is very large ie negative 
ja rookright2 ;reached end of board
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jae rookright2
mov borderindex,si
Call borderatindex2
mov H2row1[si],1
rookright2:

mov si,currPieceIndex2

rookrightloop2:

inc si
mov borderindex,si
mov ax,si
mov bx,8
div bl
cmp ah,0 ;ie reached the end of the row
je endrookright2
mov al,Vrow1[si]
cmp al,0

jne endrookright2

Call borderatindex2
mov H2row1[si],1
jmp rookrightloop2

endrookright2:
mov ax,si
mov bx,8
div bl
cmp ah,0
je rookleft2
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jae rookleft2
mov borderindex,si
Call borderatindex2
mov H2row1[si],1
rookleft2:

mov si,currPieceIndex2

rookleftloop2:

dec si
mov borderindex,si
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7 ;ie reached the end of the row
je endrookleft2
mov al,Vrow1[si]
cmp al,0

jne endrookleft2

Call borderatindex2
mov H2row1[si],1
jmp rookleftloop2

endrookleft2:
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7
je endendrook2
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jae endendrook2
mov borderindex,si
Call borderatindex2
mov H2row1[si],1
endendrook2:


ret
markLegalRook2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalBishop PROC far  ;marks all legal positions that a black bishop can currently move to and stores them in highlight array


mov si,currPieceIndex

bishopdownright:       ;checks lower right diagonal of bishop
add si,9
mov borderindex,si
cmp si,63
ja endbishopdownright

mov ax,si
mov bx,8
div bl
cmp ah,0 ;ie reached the end of the row
je endbishopdownright
mov al,Vrow1[si]
cmp al,0
jne endbishopdownright
Call borderatindex
mov Hrow1[si],1
jmp bishopdownright
endbishopdownright:  
mov ax,si
mov bx,8
div bl
cmp ah,0
je bishopupleft
cmp si,63
ja bishopupleft
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jb bishopupleft
mov borderindex,si
Call borderatindex
mov Hrow1[si],1
bishopupleft:        ;checks upper left diagonal of bishop
mov si ,currPieceIndex
bishopupleftloop:
sub si,9
mov borderindex,si
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7
je endbishopupleft
cmp si,100
ja endbishopupleft
mov al,Vrow1[si]
cmp al,0       ;to see if a piece is infront of the bishop or not
jne endbishopupleft
Call borderatindex
mov Hrow1[si],1
jmp bishopupleftloop
endbishopupleft:
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7
je bishopupright
cmp si,100
ja bishopupright
mov al,Vrow1[si]
cmp al,7
jb bishopupright
Call borderatindex
mov Hrow1[si],1
        
bishopupright:       ;checks upper left diagonal of bishop

mov si ,currPieceIndex
bishopuprightloop:
sub si,7
mov borderindex,si
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,0
je endbishopupright
cmp si,100
ja endbishopupright
mov al,Vrow1[si]
cmp al,0
jne endbishopupright
Call borderatindex
mov Hrow1[si],1
jmp bishopuprightloop
endbishopupright:
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,0
je bishopdownleft
cmp si,100
ja bishopdownleft
mov al,Vrow1[si]
cmp al,7             ;only marks if piece is an enemy
jb bishopdownleft
Call borderatindex
mov Hrow1[si],1

bishopdownleft:
mov si,currPieceIndex
bishopdownleftloop:
add si,7
mov borderindex,si
cmp si,63
ja endbishopdownleft

mov ax,si
mov bx,8            ;this block will be seen several times,it is used to make sure we dont go out of the board from left or right 
div bl
cmp ah,7 ;ie reached the end of the row
je endbishopdownleft
mov al,Vrow1[si]
cmp al,0
jne endbishopdownleft
Call borderatindex
mov Hrow1[si],1
jmp bishopdownleftloop

endbishopdownleft:
mov ax,si
mov bx,8
div bl
cmp ah,7
je endendbishop
cmp si,63
ja endendbishop
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jb endendbishop
mov borderindex,si
Call borderatindex
mov Hrow1[si],1
endendbishop:

ret

markLegalBishop endp 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
markLegalBishop2 PROC far ;marks any legal positions a white bishop can go to depending on its current index


mov si,currPieceIndex2

bishopdownright2:
add si,9
mov borderindex,si
cmp si,63
ja endbishopdownright2

mov ax,si
mov bx,8
div bl
cmp ah,0 ;ie reached the end of the row
je endbishopdownright2
mov al,Vrow1[si]
cmp al,0
jne endbishopdownright2
Call borderatindex2
mov H2row1[si],1
jmp bishopdownright2
endbishopdownright2:
mov ax,si
mov bx,8
div bl
cmp ah,0
je bishopupleft2
cmp si,63
ja bishopupleft2
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jae bishopupleft2
mov borderindex,si
Call borderatindex2
mov H2row1[si],1
bishopupleft2:
mov si ,currPieceIndex2
bishopupleftloop2:
sub si,9
mov borderindex,si
mov ax,si
mov ah,0
mov bx,8
div bl   ;same block as mentioned above ,used to make sure we dont exit from the board left or right
cmp ah,7
je endbishopupleft2
cmp si,100
ja endbishopupleft2
mov al,Vrow1[si]
cmp al,0
jne endbishopupleft2
Call borderatindex2
mov H2row1[si],1
jmp bishopupleftloop2
endbishopupleft2:
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,7
je bishopupright2
cmp si,100
ja bishopupright2   ;only marks if piece is an enemy piece by comparing it to 7(the divider between white and black pieces)
mov al,Vrow1[si]
cmp al,7
jae bishopupright2
Call borderatindex2
mov H2row1[si],1
        
bishopupright2:  ;checks upper right diagonal of bishop

mov si ,currPieceIndex2
bishopuprightloop2:
sub si,7
mov borderindex,si
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,0
je endbishopupright2
cmp si,100
ja endbishopupright2
mov al,Vrow1[si]
cmp al,0
jne endbishopupright2
Call borderatindex2
mov H2row1[si],1
jmp bishopuprightloop2
endbishopupright2:
mov ax,si
mov ah,0
mov bx,8
div bl
cmp ah,0
je bishopdownleft2
cmp si,100
ja bishopdownleft2
mov al,Vrow1[si]
cmp al,7
jae bishopdownleft2
Call borderatindex2
mov H2row1[si],1

bishopdownleft2: ;checks lower left diagonal of bishop
mov si,currPieceIndex2
bishopdownleftloop2:
add si,7
mov borderindex,si
cmp si,63
ja endbishopdownleft2

mov ax,si
mov bx,8
div bl
cmp ah,7 ;ie reached the end of the row
je endbishopdownleft2
mov al,Vrow1[si]
cmp al,0
jne endbishopdownleft2
Call borderatindex2
mov H2row1[si],1
jmp bishopdownleftloop2

endbishopdownleft2:
mov ax,si
mov bx,8
div bl
cmp ah,7
je endendbishop2
cmp si,63
ja endendbishop2
mov al,Vrow1[si] ;returns piece code of piece directly down the rook and puts in al
cmp al,7
jae endendbishop2
mov borderindex,si
Call borderatindex2
mov H2row1[si],1
endendbishop2:

ret

markLegalBishop2 endp 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalQueen PROC far
call markLegalBishop  ;as queen moves diagonally like bishop
call markLegalRook  ;as queen also moves up and down like rook 

ret

markLegalQueen endp 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalQueen2 PROC far
call markLegalBishop2
call markLegalRook2

ret

markLegalQueen2 endp 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalhorse PROC far
;Handling the 8 possible general moves of knight, and taking care of going out of  bounds
mov si,currPieceIndex
mov ax, currPieceIndex
mov bx,8
div bl
mov horserow,al
mov horsecolumn,ah

mov bh,horserow
mov bl,horsecolumn
firsthorsemove:
add bh,1
add bl,2
cmp bh,7
ja secondhorsemove
cmp bl,7
ja secondhorsemove
add si,10
mov al,Vrow1[si] ;gets the code of corresponding piece in possible knight move
cmp al,0
je continue1
cmp al,7
jb secondhorsemove ;if below means friend piece
continue1:
mov borderindex,si
call borderatindex 
mov Hrow1[si],1
secondhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
add bh,1
sub bl,2
cmp bh,7
ja thirdhorsemove
cmp bl,7
ja thirdhorsemove
add si,6
mov al,Vrow1[si]
cmp al,0
je continue2
cmp al,7
jb thirdhorsemove
continue2:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
thirdhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
add bh,2
add bl,1
cmp bh,7
ja fourthhorsemove
cmp bl,7
ja fourthhorsemove
add si,17
mov al,Vrow1[si]
cmp al,0
je continue3
cmp al,7
jb fourthhorsemove
continue3:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
fourthhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
add bh,2
sub bl,1
cmp bh,7
ja fifthhorsemove
cmp bl,7
ja fifthhorsemove
add si,15
mov al,Vrow1[si]
cmp al,0
je continue4
cmp al,7
jb fifthhorsemove
continue4:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
fifthhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
sub bh,1
sub bl,2
cmp bh,7
ja sixthhorsemove
cmp bl,7
ja sixthhorsemove
sub si,10
mov al,Vrow1[si]
cmp al,0
je continue5
cmp al,7
jb sixthhorsemove
continue5:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
sixthhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
sub bh,1
add bl,2
cmp bh,7
ja seventhhorsemove
cmp bl,7
ja seventhhorsemove
sub si,6
mov al,Vrow1[si]
cmp al,0
je continue6
cmp al,7
jb seventhhorsemove
continue6:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
seventhhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
sub bh,2
sub bl,1
cmp bh,7
ja eigthhorsemove
cmp bl,7
ja eigthhorsemove
sub si,17
mov al,Vrow1[si]
cmp al,0
je continue7
cmp al,7
jb eigthhorsemove
continue7:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
eigthhorsemove:
mov si,currPieceIndex
mov bh,horserow
mov bl,horsecolumn
sub bh,2
add bl,1
cmp bh,7
ja endendhorse
cmp bl,7
ja endendhorse
sub si,15
mov al,Vrow1[si]
cmp al,0
je continue8
cmp al,7
jb endendhorse
continue8:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
endendhorse:
ret
markLegalhorse endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalhorse2 PROC far

mov si,currPieceIndex2
mov ax, currPieceIndex2
mov bx,8
div bl
mov horserow,al
mov horsecolumn,ah

mov bh,horserow
mov bl,horsecolumn
firsthorsemove2:
add bh,1
add bl,2
cmp bh,7
ja secondhorsemove2
cmp bl,7
ja secondhorsemove2
add si,10
mov al,Vrow1[si]
cmp al,0
je continue12
cmp al,7
jae secondhorsemove2
continue12:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
secondhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
add bh,1
sub bl,2
cmp bh,7
ja thirdhorsemove2
cmp bl,7
ja thirdhorsemove2
add si,6
mov al,Vrow1[si]
cmp al,0
je continue22
cmp al,7
jae thirdhorsemove2
continue22:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
thirdhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
add bh,2
add bl,1
cmp bh,7
ja fourthhorsemove2
cmp bl,7
ja fourthhorsemove2
add si,17
mov al,Vrow1[si]
cmp al,0
je continue32
cmp al,7
jae fourthhorsemove2
continue32:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
fourthhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
add bh,2
sub bl,1
cmp bh,7
ja fifthhorsemove2
cmp bl,7
ja fifthhorsemove2
add si,15
mov al,Vrow1[si]
cmp al,0
je continue42
cmp al,7
jae fifthhorsemove2
continue42:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
fifthhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
sub bh,1
sub bl,2
cmp bh,7
ja sixthhorsemove2
cmp bl,7
ja sixthhorsemove2
sub si,10
mov al,Vrow1[si]
cmp al,0
je continue52
cmp al,7
jae sixthhorsemove2
continue52:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
sixthhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
sub bh,1
add bl,2
cmp bh,7
ja seventhhorsemove2
cmp bl,7
ja seventhhorsemove2
sub si,6
mov al,Vrow1[si]
cmp al,0
je continue62
cmp al,7
jae seventhhorsemove2
continue62:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
seventhhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
sub bh,2
sub bl,1
cmp bh,7
ja eigthhorsemove2
cmp bl,7
ja eigthhorsemove2
sub si,17
mov al,Vrow1[si]
cmp al,0
je continue72
cmp al,7
jae eigthhorsemove2
continue72:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
eigthhorsemove2:
mov si,currPieceIndex2
mov bh,horserow
mov bl,horsecolumn
sub bh,2
add bl,1
cmp bh,7
ja endendhorse2
cmp bl,7
ja endendhorse2
sub si,15
mov al,Vrow1[si]
cmp al,0
je continue82
cmp al,7
jae endendhorse2
continue82:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
endendhorse2:
ret
markLegalhorse2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

checkCastle proc far 
push ax
push bx
push cx
push dx
push si
push di

cmp initialkingmove,1
je endcastleloopright
cmp currPieceIndex,4  ;checks if king in its iniial pos
jne endcastleloopright
mov cx,2
mov si,5
castleloopright:
cmp vrow1[si],0
jne endcastleloopright
inc si
loop castleloopright
cmp vrow1[7],1  ;if rook in position right for castle
jne endcastleloopright
mov hrow1[6],1  
mov approveCastleright,1
mov borderindex,6
call borderatindex
endcastleloopright:
cmp initialkingmove,1
je endcastlecheck
mov cx,3
mov si,3
castleloopleft:  ;checks left possibility of castle
cmp vrow1[si],0
jne endcastlecheck
dec si
loop castleloopleft 
cmp vrow1[0],1  ;if rook in position right for castle
jne endcastlecheck
mov hrow1[2],1
mov approveCastleleft,1
mov borderindex,2
call borderatindex
endcastlecheck:
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
checkCastle endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalKing Proc far
call checkCastle
;checks 8 possible moves for king
mov si,currPieceIndex
mov ax, currPieceIndex
mov bx,8
div bl
mov kingrow,al
mov kingcolumn,ah

mov bh,kingrow
mov bl,kingcolumn
firstkingmove:
add bh,1
cmp bh,7
ja secondkingmove
add si,8
mov al,Vrow1[si]
cmp al,0  ;if no piece present
je continueking1
cmp al,7  ;checks if the possible location contains a friend or an enemy
jb secondkingmove
continueking1:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
secondkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
sub bh,1
cmp bh,7
ja thirdkingmove
sub si,8
mov al,Vrow1[si]
cmp al,0
je continueking2
cmp al,7
jb thirdkingmove
continueking2:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
thirdkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
add bl,1
cmp bl,7
ja fourthkingmove
add si,1
mov al,Vrow1[si]
cmp al,0
je continueking3
cmp al,7
jb fourthkingmove
continueking3:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
fourthkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
sub bl,1
cmp bl,7
ja fifthkingmove
sub si,1
mov al,Vrow1[si]
cmp al,0
je continueking4
cmp al,7
jb fifthkingmove
continueking4:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
fifthkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
add bh,1
add bl,1
cmp bh,7
ja sixthkingmove
cmp bl,7
ja sixthkingmove
add si,9
mov al,Vrow1[si]
cmp al,0
je continueking5
cmp al,7
jb sixthkingmove
continueking5:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
sixthkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
sub bh,1
sub bl,1
cmp bh,7
ja seventhkingmove
cmp bl,7
ja seventhkingmove
sub si,9
mov al,Vrow1[si]
cmp al,0
je continueking6
cmp al,7
jb seventhkingmove
continueking6:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
seventhkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
sub bh,1
add bl,1
cmp bh,7
ja eigthkingmove
cmp bl,7
ja eigthkingmove
sub si,7
mov al,Vrow1[si]
cmp al,0
je continueking7
cmp al,7
jb eigthkingmove
continueking7:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
eigthkingmove:
mov si,currPieceIndex
mov bh,kingrow
mov bl,kingcolumn
add bh,1
sub bl,1
cmp bh,7
ja endendking
cmp bl,7
ja endendking
add si,7
mov al,Vrow1[si]
cmp al,0
je continueking8
cmp al,7
jb endendking
continueking8:
mov borderindex,si
call borderatindex
mov Hrow1[si],1
endendking:


ret 
markLegalKing endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

checkCastle2 proc far
push ax
push bx
push cx
push dx
push si
push di

cmp initialkingmove2,1
je endcastleloopright2
cmp currPieceIndex2,60
jne endcastleloopright2
mov cx,2
mov si,61
castleloopright2:
cmp vrow1[si],0
jne endcastleloopright2
inc si
loop castleloopright2
cmp vrow1[63],7  ;if rook in pos
jne endcastleloopright2
mov h2row1[62],1
mov approveCastleright2,1
mov borderindex,62
call borderatindex2
endcastleloopright2:
cmp initialkingmove2,1
je endcastlecheck2
mov cx,3
mov si,59
castleloopleft2:
cmp vrow1[si],0
jne endcastlecheck2
dec si
loop castleloopleft2
cmp vrow1[56],7  ;if rook in pos
jne endcastlecheck2
mov h2row1[58],1
mov approveCastleleft2,1
mov borderindex,58
call borderatindex2
endcastlecheck2:
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
checkCastle2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalKing2 Proc far
call checkCastle2
mov si,currPieceIndex2
mov ax, currPieceIndex2
mov bx,8
div bl
mov kingrow,al
mov kingcolumn,ah

mov bh,kingrow
mov bl,kingcolumn
firstkingmove2:
add bh,1
cmp bh,7
ja secondkingmove2
add si,8
mov al,Vrow1[si]
cmp al,0
je continueking12
cmp al,7
jae secondkingmove2
continueking12:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
secondkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
sub bh,1
cmp bh,7
ja thirdkingmove2
sub si,8
mov al,Vrow1[si]
cmp al,0
je continueking22
cmp al,7
jae thirdkingmove2
continueking22:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
thirdkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
add bl,1
cmp bl,7
ja fourthkingmove2
add si,1
mov al,Vrow1[si]
cmp al,0
je continueking32
cmp al,7
jae fourthkingmove2
continueking32:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
fourthkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
sub bl,1
cmp bl,7
ja fifthkingmove2
sub si,1
mov al,Vrow1[si]
cmp al,0
je continueking42
cmp al,7
jae fifthkingmove2
continueking42:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
fifthkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
add bh,1
add bl,1
cmp bh,7
ja sixthkingmove2
cmp bl,7
ja sixthkingmove2
add si,9
mov al,Vrow1[si]
cmp al,0
je continueking52
cmp al,7
jae sixthkingmove2
continueking52:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
sixthkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
sub bh,1
sub bl,1
cmp bh,7
ja seventhkingmove2
cmp bl,7
ja seventhkingmove2
sub si,9
mov al,Vrow1[si]
cmp al,0
je continueking62
cmp al,7
jae seventhkingmove2
continueking62:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
seventhkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
sub bh,1
add bl,1
cmp bh,7
ja eigthkingmove2
cmp bl,7
ja eigthkingmove2
sub si,7
mov al,Vrow1[si]
cmp al,0
je continueking72
cmp al,7
jae eigthkingmove2
continueking72:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
eigthkingmove2:
mov si,currPieceIndex2
mov bh,kingrow
mov bl,kingcolumn
add bh,1
sub bl,1
cmp bh,7
ja endendking2
cmp bl,7
ja endendking2
add si,7
mov al,Vrow1[si]
cmp al,0
je continueking82
cmp al,7
jae endendking2
continueking82:
mov borderindex,si
call borderatindex2
mov H2row1[si],1
endendking2:


ret 
markLegalKing2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalPawn PROC far
;cmp currPieceIndex,15
push ax
mov si,currPieceIndex
add si,8
cmp si,63 ;;to validate pawn reached end of board
ja dontmarkinfront
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of pawn
cmp al,0 
jne dontmarkinfront 
Call borderatindex
mov Hrow1[si],1

dontmarkinfront:
mov ax,currPieceIndex
mov bx,8
div bl
cmp ah,0
je Nodiagonalleft
mov si,currPieceIndex
add si,8
dec si ;to check on diagonally left box
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of pawn
cmp al,7
jb Nodiagonalleft
Call borderatindex
mov Hrow1[si],1

Nodiagonalleft:
mov ax,currPieceIndex
mov bx,8
div bl
cmp ah,7
je Nodiagonalright
mov si,currPieceIndex
add si,8
inc si ;to check on diagonally right box
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of pawn
cmp al,7
jb Nodiagonalright
Call borderatindex
mov Hrow1[si],1
Nodiagonalright:

cmp currPieceIndex,16 ;ie pawn at its initial position
jae notstartpos
mov si,currPieceIndex
add si,16
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of infront of pawn 
cmp al,0
jne notstartpos 
mov si,currPieceIndex
add si,8
mov al,Vrow1[si]      
cmp al,0
jne notstartpos 
add si,8
Call borderatindex
mov Hrow1[si],1

notstartpos:
pop ax
ret 
markLegalPawn endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

markLegalPawn2 PROC far
;cmp currPieceIndex,15
push ax
mov si,currPieceIndex2
sub si,8
cmp si,63 ;;to validate pawn reached end of board
ja dontmarkinfront2
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of pawn
cmp al,0
jne dontmarkinfront2 
Call borderatindex2
mov H2row1[si],1

dontmarkinfront2:
mov ax,currPieceIndex2
mov bx,8
div bl
cmp ah,0
je Nodiagonalleft2
mov si,currPieceIndex2
sub si,8
dec si ;to check on diagonally left box
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of pawn
cmp al,7
jae Nodiagonalleft2
cmp al,0
je Nodiagonalleft2
Call borderatindex2
mov H2row1[si],1

Nodiagonalleft2:
mov ax,currPieceIndex2
mov bx,8
div bl
cmp ah,7
je Nodiagonalright2
mov si,currPieceIndex2
sub si,8
inc si ;to check on diagonally right box
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of pawn
cmp al,7
jae Nodiagonalright2
cmp al,0
je Nodiagonalright2
Call borderatindex2
mov H2row1[si],1
Nodiagonalright2:

cmp currPieceIndex2,47 ;ie pawn at its initial position
jbe notstartpos2
mov si,currPieceIndex2
sub si,16
mov borderindex,si
mov al,Vrow1[si] ;got code of piece infront of infront of pawn 
cmp al,0
jne notstartpos2
mov si,currPieceIndex2
sub si,8
mov al,Vrow1[si] 
cmp al,0
jne notstartpos2 
sub si,8
Call borderatindex2
mov H2row1[si],1

notstartpos2:
pop ax
ret 
markLegalPawn2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


getPieceCode  PROC far
mov ax,currPieceCode
mov lastpiececode,ax  ;Stores a record of piece code that is prone to a move
mov ax,currPieceIndex
mov lastpieceindex,ax ;Stores a record of piece index that is prone to a move

mov al,currPieceDelay
mov lastpieceDelay,al


mov ah,0
mov ax,startframeynew
mov bh,0
mov bl,60
Div bl ;Now al containts startframeynew/60
mov bh,0
mov bl,8
Mul bl  ;ax contains (startframeynew/60)*8
mov si,ax ;moves to si so we can now use ax to divide xpos

mov ah,0
mov ax,startframexnew
mov bh,0
mov bl,60
Div bl ;Now al containts startframexnew/60
Add ax,si
mov si,ax
mov bl,Vrow1[si]  ;gets code of clicked cell
mov currPieceCode,bx
mov currPieceIndex,si 
mov bl,up1[si]
mov currPieceDelay,bl

mov currHighindex,si

cmp firstQclick,1
je return  ;skips the rest of the function as this is the second Q click


cmp currPieceCode,5  ;compares code of cell to all piece codes to call the corresponfing mark legals
je callKing

cmp currPieceCode,2  ;compares code of cell to all piece codes to call the corresponfing mark legals
je callhorse
cmp currPieceCode,6  ;compares code of cell to all piece codes to call the corresponfing mark legals
je callpawn

cmp currpiececode,4  ;compares code of cell to all piece codes to call the corresponfing mark legals
je callqueen

cmp currPieceCode,1  ;compares code of cell to all piece codes to call the corresponfing mark legals
je callRook

cmp currPieceCode,3  ;compares code of cell to all piece codes to call the corresponfing mark legals
je callbishop


callKing:
cmp currPieceCode,5
jne return
Call markLegalKing

callhorse:
cmp currPieceCode,2
jne return
call markLegalhorse
callpawn:
cmp currPieceCode,6
jne return
Call markLegalPawn

callqueen:
cmp currpiececode,4
jne return
call markLegalQueen

callRook:
cmp currPieceCode,1
jne return
Call markLegalRook
callbishop:
cmp currPieceCode,3
jne return
call markLegalBishop

return:
ret
getPieceCode endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

getPieceCode2  PROC far
mov ax,currPieceCode2
mov lastpiececode2,ax
mov ax,currPieceIndex2
mov lastpieceindex2,ax

mov al,currPieceDelay2
mov lastpieceDelay2,al

mov ah,0
mov ax,startframe2ynew
mov bh,0
mov bl,60
Div bl ;Now al containts startframeynew/60
mov bh,0
mov bl,8
Mul bl  ;ax contains (startframeynew/60)*8
mov si,ax ;moves to si so we can now use ax to divide xpos

mov ah,0
mov ax,startframe2xnew
mov bh,0
mov bl,60
Div bl ;Now al containts startframexnew/60
Add ax,si
mov si,ax
mov bl,Vrow1[si]
mov currPieceCode2,bx
mov currPieceIndex2,si 
mov bl,up1[si]
mov currPieceDelay2,bl

mov currHighindex2,si

cmp firstSpaceclick,1
je return  ;skips the rest of the function as this is the second Q click


cmp currPieceCode2,11
je callKing2

cmp currPieceCode2,8
je callhorse2
cmp currPieceCode2,12
je callpawn2

cmp currpiececode2,10
je callqueen2

cmp currPieceCode2,7
je callRook2

cmp currPieceCode2,9
je callbishop2


callKing2:
cmp currPieceCode2,11
jne return2
Call markLegalKing2

callhorse2:
cmp currPieceCode2,8
jne return2
call markLegalhorse2
callpawn2:
cmp currPieceCode2,12
jne return2
Call markLegalPawn2

callqueen2:
cmp currpiececode2,10
jne return2
call markLegalQueen2

callRook2:
cmp currPieceCode2,7
jne return2
Call markLegalRook2
callbishop2:
cmp currPieceCode2,9
jne return2
call markLegalBishop2

return2:
ret
getPieceCode2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawpieces PROC far
   ; Open file
    push ax
    push BX
    push cx
    push DX
    push si
    push di
    MOV AH, 3Dh
    MOV AL, 0 ; read only
    MOV DX, fileaddress
    INT 21h
    
    ; carry = 0 -> successful , file handle -> AX
    ; carry = 1 -> failed , AX -> error code
     
    MOV [Filehandle], AX


    MOV AH,3Fh
    MOV BX, [Filehandle]
    MOV CX,3600 ; number of bytes to read 60*60
    LEA DX, fData
    INT 21h
    
    LEA BX , fData ; BL contains index at the current drawn pixel
    MOV CX,startposx ;Starting points
    MOV DX,startposy ;Starting points
    MOV AH,0ch
	
; Drawing loop
drawLoop:
    MOV AL,[BX]
    cmp al,20h
    jz cont
    INT 10h 
    cont:
    INC CX
    INC BX
    CMP CX, endposx ;starting point + 60
    
JNE drawLoop
    MOV CX , startposx  ;value to cx represents starting point
    INC DX
    CMP DX, endposy ;starting point + 60
JNE drawLoop
MOV AH, 3Eh
	MOV BX, [Filehandle]

	INT 21h
pop di
pop si
pop DX
pop cx
pop BX
pop ax
RET
drawpieces ENDP

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawpieces2 PROC far
;this proc is used to draw 3,2,1 images of timer countdown
   ; Open file
    push ax
    push BX
    push cx
    push DX

    MOV AH, 3Dh
    MOV AL, 0 ; read only
    MOV DX, fileaddress
    INT 21h
    
    ; carry = 0 -> successful , file handle -> AX
    ; carry = 1 -> failed , AX -> error code
     
    MOV [Filehandle], AX


    MOV AH,3Fh
    MOV BX, [Filehandle]
    MOV CX, 225 ; number of bytes to read 15*15
    LEA DX, fData
    INT 21h
    
    LEA BX , fData ; BL contains index at the current drawn pixel
    MOV CX,startposx ;Starting points
    MOV DX,startposy ;Starting points
    MOV AH,0ch
	
; Drawing loop
drawLoop2:
    MOV AL,[BX]
    cmp al,20h
    jz cont2
    INT 10h 
    cont2:
    INC CX
    INC BX
    CMP CX, endposx ;starting point + 25
    
JNE drawLoop2
    MOV CX , startposx  ;value to cx represents starting point
    INC DX
    CMP DX, endposy ;starting point + 25
JNE drawLoop2
MOV AH, 3Eh
	MOV BX, [Filehandle]

	INT 21h
pop DX
pop cx
pop BX
pop ax
RET
drawpieces2 ENDP

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawtimepiece proc far
push ax
push bx
push cx
push dx
push si
push di

drawbrook:
cmp timepiececode,1
jne drawbknight
lea ax,Filename
mov fileaddress,ax


drawbknight:
cmp timepiececode,2
jne drawbbishop
lea ax,Filename2
mov fileaddress,ax


drawbbishop:
cmp timepiececode,3
jne drawbqueen
lea ax,Filename3
mov fileaddress,ax


drawbqueen:
cmp timepiececode,4
jne drawbking
lea ax,Filename4
mov fileaddress,ax


drawbking:
cmp timepiececode,5
jne drawbpawn
lea ax,Filename5
mov fileaddress,ax


drawbpawn:
cmp timepiececode,6
jne drawwrook
lea ax,Filename9
mov fileaddress,ax


drawwrook:
cmp timepiececode,7
jne drawwknight
lea ax,Filename25
mov fileaddress,ax





drawwknight:
cmp timepiececode,8
jne drawwbishop
lea ax,Filename26
mov fileaddress,ax




drawwbishop:
cmp timepiececode,9
jne drawwqueen
lea ax,Filename27
mov fileaddress,ax


drawwqueen:
cmp timepiececode,10
jne drawwking
lea ax,Filename28
mov fileaddress,ax


drawwking:
cmp timepiececode,11
jne drawwpawn
lea ax,Filename29
mov fileaddress,ax


drawwpawn:
cmp timepiececode,12
jne returndrawtime
lea ax,Filename17
mov fileaddress,ax


returndrawtime:

pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
drawtimepiece  endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawbox proc far
;used x,y coordinated and color to draw a box in a specific cell
push cx
push dx
push ax
push bx
push si
push di
mov cx,startposx  
Mov dx,startposy
mov ax,startposx ;define end 60
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
 MOV AH,0ch
 mov al,bordercolor
; Drawing loop
drawboxloop:
    INT 10h 
    INC CX
    ;INC BX
    CMP CX,endposx
JNE drawboxloop 
	
    MOV CX , startposx
    INC DX
    CMP DX , endposy
JNE drawboxloop
pop di
pop si
pop bx
pop ax
pop dx
pop cx
ret
drawbox endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawpersquare  proc far
;Used for animation to traverse from start pos to end pos and draw piece in every cell in between
push ax
push bx
push cx
push dx
push si
push di

mov cx,prevpiecex  ; precpiecex ,y  stores initial pos of piece
mov dx,prevpiecey
mov tempx,cx
mov tempy,dx


mov cx,prevpiecex
mov dx,prevpiecey


loopmove:
;call delay
mov tempx,cx
mov tempy,dx

cmp cx,startframexnew
je compareY
cmp cx,startframexnew
jae checkleftmove
add cx,60
jmp compareY
checkleftmove:
sub cx,60

compareY:
cmp dx,startframeynew
je drawatsquare
cmp dx,startframeynew
jae  Checkupmove
add dx,60
jmp drawatsquare
checkupmove:
sub dx,60
jmp drawatsquare
jmp loopmove

drawatsquare:
mov ax,tempx
mov startposx,ax
mov bx,tempy
mov startposy,bx
push cx
push dx
mov cx,tempx
mov dx,tempy
add cx,3          
add dx,3          
mov ah,0dh
int 10h
pop dx
pop cx
mov bordercolor,al
call drawbox       ;empty the cell left
mov startposx,cx
mov startposy,dx
mov ax,startposx
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
call drawpieces
cmp cx,startframexnew
je comparedx
jmp loopmove
comparedx:
cmp dx,startframeynew
je leavefunc
jmp loopmove



leavefunc:
pop di
pop si
pop dx
pop cx
pop bx 
pop ax



ret
drawpersquare endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawpersquare2  proc far
push ax
push bx
push cx
push dx
push si
push di

mov cx,prevpiecex2
mov dx,prevpiecey2
mov tempx2,cx
mov tempy2,dx

mov cx,prevpiecex2
mov dx,prevpiecey2


loopmove2:
;call delay
mov tempx2,cx
mov tempy2,dx

cmp cx,startframe2xnew
je compareY2
cmp cx,startframe2xnew
jae checkleftmove2
add cx,60
jmp compareY2
checkleftmove2:
sub cx,60

compareY2:
cmp dx,startframe2ynew
je drawatsquare2
cmp dx,startframe2ynew
jae  Checkupmove2
add dx,60
jmp drawatsquare2
checkupmove2:
sub dx,60
jmp drawatsquare2
jmp loopmove2

drawatsquare2:
mov ax,tempx2
mov startposx,ax
mov bx,tempy2
mov startposy,bx
push cx
push dx
mov cx,tempx2
mov dx,tempy2
add cx,3          
add dx,3          
mov ah,0dh
int 10h
pop dx
pop cx
mov bordercolor,al
call drawbox       ;empty the cell left
mov startposx,cx
mov startposy,dx
mov ax,startposx
add ax,60
mov endposx,ax
mov ax,startposy
add ax,60
mov endposy,ax
call drawpieces
cmp cx,startframe2xnew
je comparedx2
jmp loopmove2
comparedx2:
cmp dx,startframe2ynew
je leavefunc2
jmp loopmove2




leavefunc2:
pop di
pop si
pop dx
pop cx
pop bx 
pop ax




ret
drawpersquare2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

boxatindex proc far
push bx
push ax
mov bl,8
mov bh,0
mov ax,timeindex
div bl
mov bh,0
mov bl,ah
mov startposx,bx
mov bh,0
mov bl,AL
mov startposy,bx
mov ax,startposx
mov bl,60
MUL Bl ;AX=Al*bl
mov startposx,ax

mov ax,startposy
mov bl,60
MUL Bl ;AX=Al*bl
mov startposy,ax

mov ax,startposx
Add ax,60

mov endposx,ax

mov ax,startposy
Add ax,60
mov endposy,ax



CALL drawbox
pop ax
pop bx
ret
boxatindex endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
printBlackStatus proc far
push ax
push bx
push cx
push si

;This proc is used to display a message in status bar to show if any piece is dead from black player

mov bx,currPieceCode2
mov codeDied,bx
MoveCursor 1,32  ;moves cursor in specified location for status bar
mov startposx,540
mov endposx,600
mov startposy,0
mov endposy,60

cmp codeDied,1
jne printBlackKnight
ShowString bRookDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename8
mov fileaddress,ax
call drawpieces

printBlackKnight:
cmp codeDied,2
jne printBlackBishop
ShowString bKnightDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename7
mov fileaddress,ax
call drawpieces



printBlackBishop:
cmp codeDied,3
jne printBlackQueen
ShowString bbishopDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename3
mov fileaddress,ax
call drawpieces


printBlackQueen:
cmp codeDied,4
jne printBlackKing
ShowString bQueenDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename4
mov fileaddress,ax
call drawpieces


printBlackKing:
cmp codeDied,5
jne printBlackPawn
ShowString bKingDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename5
mov fileaddress,ax
call drawpieces


printBlackPawn:
cmp codeDied,6
jne endPrintBlack
ShowString bPawnDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename9
mov fileaddress,ax
call drawpieces


endPrintBlack:
pop si
pop cx
pop bx
pop ax
ret
printBlackStatus endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

printWhiteStatus proc far
push ax
push bx
push cx
push si
;This proc is used to display a message in status bar to show if any piece is dead from white player
mov bx,currPieceCode
mov codeDied,bx
MoveCursor 1,32
mov startposx,540
mov endposx,600
mov startposy,0
mov endposy,60

cmp codeDied,7
jne printWhiteKnight
ShowString wRookDied ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox

lea ax,Filename25
mov fileaddress,ax
call drawpieces

printWhiteKnight:
cmp codeDied,8
jne printWhiteBishop
ShowString wKnightDied ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox
lea ax,Filename26
mov fileaddress,ax
call drawpieces


printWhiteBishop:
cmp codeDied,9
jne printWhiteQueen
ShowString wbishopDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox
lea ax,Filename27
mov fileaddress,ax
call drawpieces


printWhiteQueen:
cmp codeDied,10
jne printWhiteKing
ShowString wQueenDied ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox
lea ax,Filename28
mov fileaddress, ax
call drawpieces  

printWhiteKing:
cmp codeDied,11
jne printWhitePawn 
ShowString wkingDied  ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox
lea ax,Filename29
mov fileaddress, ax
call drawpieces  




printWhitePawn:
cmp codeDied,12
jne endPrintWhite
ShowString wPawnDied ;displays the notification in status bar
mov startposx,540
mov startposy,0
mov bordercolor,1
call drawbox
lea ax,Filename17
mov fileaddress, ax
call drawpieces  




endPrintWhite:
pop si
pop cx
pop bx
pop ax
ret
printWhiteStatus endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

checkcheck proc far
push ax
push bx
push cx
push dx
push si
push di

;This proc is used to check if king is under threat from an enemy

mov ax,currHighindex
mov currPieceIndex,ax

;compares codes to call corresponding mark legal procedures

callKingcheck:
cmp lastPieceCode,5
jne callhorsecheck
Call markLegalKing

callhorsecheck:
cmp lastPieceCode,2
jne callpawncheck
call markLegalhorse

callpawncheck:
cmp lastPieceCode,6
jne callqueencheck
Call markLegalPawn

callqueencheck:
cmp lastPieceCode,4
jne callRookcheck
call markLegalQueen

callRookcheck:
cmp lastPieceCode,1
jne callbishopcheck
Call markLegalRook

callbishopcheck:
cmp lastPieceCode,3
jne startcheck
call markLegalBishop

startcheck:
mov cx,64 ;to loop on the whole board to check if king is under threat
mov si,0

checkarray:

cmp hrow1[si],1
je checkkingpos

continuecheck:

inc si
loop checkarray

checkkingpos:
cmp cx,0
je returncheck
cmp Vrow1[si],11
jne continuecheck
MoveCursor 1,34
ShowString wkingInCheck ;display message showing if king in check

returncheck:




pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
checkcheck endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

checkcheck2 proc far
push ax
push bx
push cx
push dx
push si
push di
;This proc is used to check if king is under threat from an enemy

mov ax,currHighindex2
mov currPieceIndex2,ax


;compares codes to call corresponding mark legal procedures

callKingcheck2:
cmp lastPieceCode2,11
jne callhorsecheck2
Call markLegalKing2

callhorsecheck2:
cmp lastPieceCode2,8
jne callpawncheck2
call markLegalhorse2

callpawncheck2:
cmp lastPieceCode2,12
jne callqueencheck2
Call markLegalPawn2

callqueencheck2:
cmp lastPieceCode2,10
jne callRookcheck2
call markLegalQueen2

callRookcheck2:
cmp lastPieceCode2,7
jne callbishopcheck2
Call markLegalRook2

callbishopcheck2:
cmp lastPieceCode2,9
jne startcheck2
call markLegalBishop2

startcheck2:
mov cx,64 ;to loop on the whole board to check if king is under threat
mov si,0

checkarray2:

cmp h2row1[si],1
je checkkingpos2

continuecheck2:

inc si
loop checkarray2

checkkingpos2:
cmp cx,0
je returncheck2
cmp Vrow1[si],5
jne continuecheck2
MoveCursor 1,34
ShowString bkingInCheck ;display message showing if king in check

returncheck2:




pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
checkcheck2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

checkendgame proc far
;This proc is used 
push si
push AX
push bx
push cx
push dx
push di
mov cx,64  ;Loops on whole board to check if black king is still on board if yes, skips the func
mov si,0
loopendgame:
cmp vrow1[si],5
je kingfound
inc si
dec cx
cmp cx,0
jne loopendgame
MoveCursor 1,34
ShowString whitewon ;if no black king found on board ---> White Won!
pop di
pop dx
pop cx
pop bx
pop ax
pop si
call resetgame


mov ah ,0
int 16h
call invites



kingfound:
pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
checkendgame  endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

checkendgame2 proc far
push si
push AX
push bx
push cx
push dx
push di
mov cx,64  ;Loops on whole board to check if black king is still on board if yes, skips the func
mov si,0
loopendgame2:
cmp vrow1[si],11
je kingfound2
inc si
dec cx
cmp cx,0
jne loopendgame2
MoveCursor 1,34
ShowString blackwon ;if no black king found on board ---> White Won!
pop di
pop dx
pop cx
pop bx
pop ax
pop si
call resetgame
mov ah ,0

int 16h
call invites



kingfound2:
pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
checkendgame2  endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

clearhighlights proc far

;Clear the legals marks after executing a move whether or not a move is done

push si
push AX
push bx
push cx
push dx
push di
mov cx,64

mov si,0
mov al,7  ;light grey first square colour
mov bl,8  ; dark grey second square colour
cleararray:
cmp hrow1[si],1
je removehighlight
continuehighlight:
mov hrow1[si],0

push ax
push bx
mov ax,si
mov bx,8
div bl
cmp ah,7
pop bx
pop ax
je noexchange

xchg al,bl ;to alternate between light grey and dark grey whilst traversing the squares
noexchange:

inc si
loop cleararray
removehighlight:
cmp cx,0
je returnhighlight
mov bordercolorhighlight,al
mov borderindex,si  
push cx
push bx
push ax
call borderatindex  ;draws the original border of the box whether light gray or dark gray
pop ax
pop bx    
pop cx
jmp continuehighlight
returnhighlight:

mov bordercolorhighlight,4 ;returns color to original color of marking

pop di
pop dx
pop cx
pop bx
pop ax
pop si

ret
clearhighlights endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


clearhighlights2 proc far
push si
push AX
push bx
push cx
push dx
push di
mov cx,64

mov si,0
mov al,7  ;light grey first square colour
mov bl,8  ; dark grey second square colour
cleararray2:
cmp h2row1[si],1  ;access array of second player
je removehighlight2
continuehighlight2:
mov h2row1[si],0

push ax
push bx
mov ax,si
mov bx,8
div bl
cmp ah,7
pop bx
pop ax
je noexchange2

xchg al,bl ;to alternate between light grey and dark grey whilst traversing the squares
noexchange2:

inc si
loop cleararray2
removehighlight2:
cmp cx,0
je returnhighlight2
mov bordercolorhighlight2,al
mov borderindex,si
push cx
push bx
push ax
call borderatindex2
pop ax
pop bx    
pop cx
jmp continuehighlight2
returnhighlight2:

mov bordercolorhighlight2, 5 ;returns color to original color of marking
pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
clearhighlights2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

promotequeen  proc far
;This func is used to check if a pawn reached the end row infront of it is automatically promoted to queen
push si
push AX
push bx
push cx
push dx
push di

mov cx,8  ;Loops on top row if there is a pawn from enemy change it to queen
mov si,0

promotequeenloop:
cmp vrow1[si],12   ;checks if white pawn reached end
jne continuepromoteloop
mov vrow1[si],10  ;changes its code to queen code in virtual board

;Then draw a box on the cell to remove pawn and then draw a queen instead in same loc
mov al,prevpiececolor2
mov bordercolor,al
mov ax,prevpiecex2
mov startposx,ax
mov ax,prevpiecey2
mov startposy,ax
call drawBox  ;Clears the cell
mov al,bordercolorold2
mov bordercolor,al
mov ax,startframe2xnew
mov startposx,ax
mov ax,startframe2ynew
mov startposy,ax
call drawBox
lea ax,Filename28
mov fileaddress,ax
mov bx,startframe2xnew
mov startposx,bx
add bx,60
mov endposx,bx
mov bx,startframe2ynew
mov startposy,bx
add bx,60
mov endposy,bx
call drawpieces
;MoveCursor 1,32
call CursorQueen
showstring whitepawnpromote ;Outputs a message showing if queen promoted
continuepromoteloop:
inc si
loop promotequeenloop


pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
promotequeen endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

promotequeen2  proc far ;This function loops on bottom row and checks if any white pawn has reached the bottom row he will be promoted to a queen
push si
push AX
push bx
push cx
push dx
push di

mov cx,8
mov si,56

promotequeenloop2:
cmp vrow1[si],6
jne continuepromoteloop2
mov vrow1[si],4
mov al,prevpiececolor
mov bordercolor,al      ;draw box is called to clear the old and new squares occupied by the pawn
mov ax,prevpiecex
mov startposx,ax
mov ax,prevpiecey
mov startposy,ax
call drawBox
mov al,bordercolorold
mov bordercolor,al
mov ax,startframexnew
mov startposx,ax
mov ax,startframeynew
mov startposy,ax
call drawBox
lea ax,Filename4
mov fileaddress,ax  ;the border color old variable stores the colour of the old square previously occupied by the pawn
mov bx,startframexnew
mov startposx,bx
add bx,60
mov endposx,bx
mov bx,startframeynew
mov startposy,bx
add bx,60
mov endposy,bx
call drawpieces     ;draw pieces is called with the code for a queen to finish the promoting process
call CursorQueen
showstring blackpawnpromote
continuepromoteloop2:
inc si
loop promotequeenloop2



pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
promotequeen2 endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drawCastle proc far   ;after the king has moved to its new castled position,
                      ;this function is used to move the rook virtually and physically on the board
push si
push AX
push bx
push cx
push dx
push di


cmp approveCastleright,1
jne checkothercaspos
;cmp initialkingmove,1
;je checkothercaspos
cmp currHighindex,6
jne checkothercaspos
mov vrow1[7],0
mov vrow1[5],1
mov startposx,300
mov endposx,360
mov startposy,0           ;filename containing rook image is loaded
mov endposy,60
lea ax,Filename
mov fileaddress,ax
call drawpieces   ;drawpieces is called to draw the rook in its position
MoveCursor 1,34
ShowString castleMessage        
mov startposx,420
mov startposy,0
mov bordercolor,8
call drawbox
mov approveCastleright,0
jmp endDrawCastle
checkothercaspos:

cmp approveCastleleft,1
jne endDrawCastle
;cmp initialkingmove,1
;je endDrawCastle
cmp currHighindex,2
jne checkothercaspos
mov vrow1[0],0
mov vrow1[3],1
mov startposx,180         
mov endposx,240
mov startposy,0
mov endposy,60
lea ax,Filename
mov fileaddress,ax
call drawpieces
MoveCursor 1,34
ShowString castleMessage
mov startposx,0
mov startposy,0       ;border color now contains the colour of the square to be drawn in
mov bordercolor,7
call drawbox
mov approveCastleleft,0
endDrawCastle:
mov approveCastleleft,0
pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
drawCastle endp

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

movepiece proc far ;this function moves the piece both virtually and physically
mov si,currHighindex
mov bl ,hrow1[si]
mov cl,bl
cmp bl ,1
jne dontmove2
;----------
mov di,lastpieceindex
mov bl,vrow1[di]
cmp bl,0
je dontmove2
;---------------
call compareTimes
cmp approvemove,1
jne dontmove2

mov al,prevpiececolor
mov bordercolor,al
mov ax,prevpiecex
mov startposx,ax
mov ax,prevpiecey
mov startposy,ax
call drawBox
mov al,bordercolorold   ;draw box is called to draw the board's square in its old and new position
mov bordercolor,al
mov ax,startframexnew
mov startposx,ax
mov ax,startframeynew
mov startposy,ax
call drawBox
dontmove2:
cmp cl,1
jne dontmovetemp
mov bx,lastpiececode    ;contains code of piece to be printed


cmp approvemove,1
jne dontmovetemp2

mov vrow1[si],bl ;virtual movement occurs in this line,piece code enters the piece's array
call configtime
mov si ,lastpieceindex
mov vrow1[si],0
call clearhighlights ;called to remove all highlights from the board after a move is attempted
EmptyMessage
CALL checkcheck
CALL printWhiteStatus

mov bx,startframexnew
mov startposx,bx
add bx,60
mov endposx,bx
mov bx,startframeynew
mov startposy,bx
add bx,60
mov endposy,bx

dontmovetemp:
cmp cl,1
jne dontmove1

dontmovetemp2:
cmp approvemove,1
jne dontmove1
cmp lastpiececode,1
je drawrook
cmp lastpiececode,2    ;check on approvemove is done to determine if piece is still time penalised
je drawknight
cmp lastpiececode,3
je drawbishop
cmp lastpiececode,4
je drawqueen
cmp lastpiececode,5
je drawking
cmp lastpiececode,6
je drawpawn

drawrook:
cmp lastpiececode,1
jne dontmovecheck
lea ax,Filename
mov fileaddress,ax
call drawpersquare

dontmovecheck:
cmp lastpiececode,1
jne dontmove

                            ;load's the image file of the correct piece based on its code
drawknight:
cmp lastpiececode,2
jne dontmove
lea ax,Filename2
mov fileaddress,ax
call drawpieces

dontmove1:
cmp approvemove,0
je dontmove
cmp cl,1
jne dontmove

drawbishop:
cmp lastpiececode,3
jne dontmove
lea ax,Filename3
mov fileaddress,ax
call drawpersquare

drawqueen:
cmp lastpiececode,4
jne dontmove
lea ax,Filename4
mov fileaddress,ax
call drawpersquare

drawking:
cmp lastpiececode,5
jne dontmove
lea ax,Filename5
mov fileaddress,ax
call drawpersquare
call drawCastle
mov initialkingmove,1
drawpawn:
cmp lastpiececode,6
jne dontmove
lea ax,Filename9
mov fileaddress,ax
call drawpersquare
call promotequeen2
dontmove:
ret
movepiece endp
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
drawCastle2 proc far; this function relocates the rook to its correct position after its king has castled successfuly
push si
push AX
push bx
push cx
push dx
push di

cmp approveCastleright2,1
jne checkothercaspos2
;cmp initialkingmove,1
;je checkothercaspos
cmp currHighindex2,62
jne checkothercaspos2
mov vrow1[63],0
mov vrow1[61],7
mov startposx,300
mov endposx,360
mov startposy,420
mov endposy,480
lea ax,Filename32          ;rooks file name is loaded to print the rooks image
mov fileaddress,ax
call drawpieces
MoveCursor 1,34
ShowString castleMessage
mov startposx,420
mov startposy,420
mov bordercolor,7    
call drawbox              ;drawbox is called to clear the square before the rook is placed
mov approveCastleright2,0
jmp endDrawCastle2     
checkothercaspos2:

cmp approveCastleleft2,1
jne endDrawCastle2
;cmp initialkingmove,1
;je endDrawCastle
cmp currHighindex2,58
jne checkothercaspos2
mov vrow1[56],0
mov vrow1[59],7
mov startposx,180
mov endposx,240
mov startposy,420     ;note:king isnt allowed to castle if it has already moved before as per the real chess game's rules
mov endposy,480
lea ax,Filename32
mov fileaddress,ax
call drawpieces
MoveCursor 1,34
ShowString castleMessage
mov startposx,0
mov startposy,420
mov bordercolor,8
call drawbox
mov approveCastleleft2,0
endDrawCastle2:
mov approveCastleleft2,0
pop di
pop dx
pop cx
pop bx
pop ax
pop si
ret
drawCastle2 endp
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
movepiece2 proc far     ;this function moves any piece to its destination on the board and in the piece array
mov si,currHighindex2
mov bl ,h2row1[si]
mov cl,bl
cmp bl ,1
jne dontmove22
mov di,lastpieceindex2
mov bl,vrow1[di]
cmp bl,0
je dontmove22
call compareTimes2
cmp approvemove2,1 ;checks if the piece penalty timer has reset or not yet
jne dontmove22

mov al,prevpiececolor2
mov bordercolor,al
mov ax,prevpiecex2
mov startposx,ax
mov ax,prevpiecey2
mov startposy,ax
call drawBox
mov al,bordercolorold2
mov bordercolor,al
mov ax,startframe2xnew
mov startposx,ax
mov ax,startframe2ynew
mov startposy,ax
call drawBox
dontmove22:
cmp cl,1
jne dontmovetemp22
mov bx,lastpiececode2


cmp approvemove2,1
jne dontmove12link

mov vrow1[si],bl ;virtual movement
call configtime2
mov si ,lastpieceindex2
mov vrow1[si],0
call clearhighlights2
EmptyMessage
CALL checkcheck2
CALL printBlackStatus

mov bx,startframe2xnew
mov startposx,bx
add bx,60
mov endposx,bx
mov bx,startframe2ynew
mov startposy,bx
add bx,60
mov endposy,bx

dontmove12link:
cmp approvemove2,1
jne dontmove12

dontmovetemp22:
cmp cl,1
jne dontmove12

cmp lastpiececode2,7
je drawrook2
cmp lastpiececode2,8
je drawknight2
cmp lastpiececode2,9
je drawbishop2
cmp lastpiececode2,10
je drawqueen2
cmp lastpiececode2,11
je drawking2
cmp lastpiececode2,12
je drawpawn2
drawrook2:
cmp lastpiececode2,7
jne dontmove222link
lea ax,Filename25
mov fileaddress,ax
call drawpersquare2


drawknight2:
cmp lastpiececode2,8
jne dontmove222
lea ax,Filename26
mov fileaddress,ax
call drawpieces

dontmove12:
cmp approvemove2,0
je dontmove222
cmp cl,1
jne dontmove222
dontmove222link:
cmp lastpiececode2,7
jne dontmove222
drawbishop2:
cmp lastpiececode2,9
jne dontmove222
lea ax,Filename27
mov fileaddress,ax
call drawpersquare2

drawqueen2:
cmp lastpiececode2,10
jne dontmove222
lea ax,Filename28
mov fileaddress,ax
call drawpersquare2

drawking2:
cmp lastpiececode2,11
jne dontmove222
lea ax,Filename29
mov fileaddress,ax
call drawpersquare2
call drawCastle2
mov initialkingmove2,1
drawpawn2:
cmp lastpiececode2,12
jne dontmove222
lea ax,Filename17
mov fileaddress,ax
call drawpersquare2
call promotequeen
dontmove222:
ret
movepiece2 endp
timeatindex proc far
push bx
push ax
mov bl,8
mov bh,0
mov ax,timeindex
div bl
mov bh,0
mov bl,ah
mov startposx,bx
mov bh,0
mov bl,AL
mov startposy,bx
mov ax,startposx
mov bl,60
MUL Bl ;AX=Al*bl
mov startposx,ax
add startposx,25
mov ax,startposy
mov bl,60
MUL Bl ;AX=Al*bl
mov startposy,ax
add startposy,25
mov ax,startposx
Add ax,15

mov endposx,ax

mov ax,startposy
Add ax,15
mov endposy,ax

call drawpieces2
pop ax
pop bx
ret
timeatindex endp



timeAnimations proc far
push ax
push bx
push cx
push dx
push si
mov loopindex,0

mov ah,2ch
int 21h  ;Got current system time in Dh-->seconds   Cl-->Minutes

mov al,cl
mov bl,60
mul Bl ;result in ax contains curr time in seconds

mov dl,dh
mov dh,0
add ax,dx ;adds (minutes*60)+seconds
mov currTime,ax
mov cx,64

mov si,0
mov al,7  ;light grey first square colour
mov bl,8  ; dark grey second square colour
mov di,0

timeanimeloop:
mov dx,Trow1[si]
mov piecetime,dx

cmp dx,0
je continuetime
add dx,1
cmp currTime,dx
jb red
add dx,1
cmp currTime,dx
jb yellow
add dx,1
cmp currTime,dx
jb green
mov bordercolor,al

mov dx,loopindex
MOV timeindex,di

call boxatindex

mov bx,loopindex
mov dl,vrow1[di]
cmp dl,0
je continuetime
mov timepiececode,dl

call drawtimepiece
call drawpieces

mov trow1[si],0


continuetime:


call exchangecolor

add si,2
inc loopindex
inc di
loop timeanimeloop
red:

cmp cx,0
je returntimeanime
lea dx,filetimered
mov fileaddress,dx

;mov dx,loopindex
MOV timeindex,di

call timeatindex
jmp continuetime
yellow:
cmp cx,0
je returntimeanime
lea dx,filetimeyell
mov fileaddress,dx

mov dx,loopindex
MOV timeindex,di
  
call timeatindex
jmp continuetime
green:
cmp cx,0
je returntimeanime
lea dx,filetimegreen
mov fileaddress,dx

mov dx,loopindex
MOV timeindex,di

call timeatindex
jmp continuetime



returntimeanime:







pop si
pop dx
pop cx
pop bx
pop ax

ret
timeAnimations endp

setcurrFrame2 proc far

push bx
mov bx,startframe2xnew
mov startposx,bx
mov bx,endframe2xnew 
mov endposx,bx
mov bx,startframe2ynew
mov startposy,bx
mov bx,endframe2ynew
mov endposy,bx
pop bx
ret
setcurrFrame2 endp

cyanFrame proc far
push ax
mov cx,endframe2xnew
mov endframe2xold,cx
mov cx,endframe2ynew
mov endframe2yold ,cx

mov checkframe2move,0

mov cx,startframe2xnew
mov startframe2xold,cx
mov dx,startframe2ynew
mov startframe2yold,dx
mov cx,startframe2xold
mov dx,startframe2yold
add cx,3          ;;getting cube colour of cyan frame old position
add dx,3          ;;getting cube colour of cyan frame old position
mov ah,0dh
int 10h
mov bordercolorold2,al
pop ax
cmp firstspaceclick,1
je skip2
mov bx,startframe2xnew
mov prevpiecex2,bx
mov bx,startframe2ynew
mov prevpiecey2,bx
mov bl,bordercolorold2
mov prevpiececolor2,bl
skip2:

cmp al, 3Dh  ;up
je labelup

cmp al,5Dh  ;down
je labeldown

cmp al,5Bh   ;left
je labelleft

cmp al, 5Ch    ;right
je labelright

cmp al, 2Dh  ;ascii of -
jne returncyan  ;no valid input

push ax

CALL getPieceCode2
cmp firstspaceclick,1
jne theXor2

;call checkEaten2
;cmp approveeaten2,0
;je thexor2

call movepiece2
call clearhighlights2

theXor2:
xor firstspaceclick,1 ;sets and resets first spaceclick

pop ax





labelup:
cmp al,3Dh
jne returncyan
mov checkframe2move,1

sub startframe2ynew,60
sub endframe2ynew,60

labelright:
cmp al, 5Ch
jne returncyan
mov checkframe2move,1

add startframe2xnew,60
add endframe2xnew,60

labelleft:
cmp al, 5Bh
jne returncyan
mov checkframe2move,1

sub startframe2xnew,60
sub endframe2xnew,60

labeldown:
cmp al, 5Dh
jne returncyan
mov checkframe2move,1

add startframe2ynew,60
add endframe2ynew,60

returncyan:

ret
cyanFrame endp


setcurrFrame proc far

push bx
mov bx,startframexnew
mov startposx,bx
mov bx,endframexnew 
mov endposx,bx
mov bx,startframeynew
mov startposy,bx
mov bx,endframeynew
mov endposy,bx
pop bx
ret
setcurrFrame endp


yellowframe proc far

push ax
mov cx,endframexnew
mov endframexold,cx
mov cx,endframeynew
mov endframeyold ,cx
mov checkframemove,0
mov cx,startframexnew
mov startframexold,cx
mov dx,startframeynew
mov startframeyold,dx
mov cx,startframexold
mov dx,startframeyold
add cx,3          ;;getting cube colour of yellow frame old position
add dx,3          ;;getting cube colour of yellow frame old position
mov ah,0dh
int 10h
mov bordercolorold,al



cmp firstQclick,1
je skip
mov bx,startframexnew
mov prevpiecex,bx
mov bx,startframeynew
mov prevpiecey,bx
mov prevpiececolor,al
skip:

pop ax


cmp player1,1
jne checkyellow

cmp al, 3Dh  ;up
jne checkdown
push ax
CALL cyanFrame
pop ax
checkdown:
cmp al, 5Dh ;down
jne checkleft
push ax
CALL cyanFrame
pop ax
checkleft:
cmp al, 5Bh   ;left
jne checkright
push ax
CALL cyanFrame
pop ax
checkright:
cmp al, 5Ch    ;right
jne checkspace
push ax
CALL cyanFrame
pop ax
checkspace:
cmp al, 2Dh     ; -
jne checkyellow
push ax
CALL cyanFrame
pop ax

checkyellow:
cmp player1,1
je exityellow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HERE TO CHECK ON PLAYER 2

cmp al, 3Dh ; up
je labelw

cmp al, 5Ch 
je labeld

cmp al, 5Dh
je labels

cmp al, 5Bh
je labela

cmp al, 2Dh   ; -
jne returnlabel1


push ax

CALL getPieceCode
cmp firstQclick,1
jne theXor

;call checkEaten
;cmp approveeaten,0
;je thexor

call movepiece
call clearhighlights

theXor:
xor firstQclick,1 ;sets and resets first qclick

pop ax

exityellow:
cmp player1,1
je returnlabel


returnlabel1:
cmp al, 2Dh  ;scancode of Q
jne returnlabel

labelw:
cmp al, 3Dh 
jne returnlabel
mov checkframemove,1

sub startframeynew,60
sub endframeynew,60

labeld:
cmp al, 5Ch
jne returnlabel
mov checkframemove,1

add startframexnew,60
add endframexnew,60

labela:
cmp al, 5Bh
jne returnlabel
mov checkframemove,1

sub startframexnew,60
sub endframexnew,60

labels:
cmp al, 5Dh
jne returnlabel
mov checkframemove,1

add startframeynew,60
add endframeynew,60

returnlabel:
adjustyellowFrame ;draws yellow frame on itself if not moved and in new pos if moved and if moved draws old

adjustcyanFrame   

call checkendgame
call checkendgame2


ret
yellowframe endp

PRINT PROC far      
     
    ;initialize count
    mov cx,0
    mov dx,0
    label1:
        ; if ax is zero
        cmp ax,0
        je print1     
         
        ;initialize bx to 10
        mov bx,10       
         
        ; extract the last digit
        div bx                 
         
        ;push it in the stack
        push dx             
         
        ;increment the count
        inc cx             
         
        ;set dx to 0
        xor dx,dx
        jmp label1
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit
         
        ;pop the top of stack
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
         
        ;interrupt to print a
        ;character
        mov ah,02h
        int 21h
         
        ;decrease the count
        dec cx
        jmp print1
exit:
ret
PRINT ENDP
calculategametime proc far
push ax 
push bx 
push cx
push dx
push si
push di
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
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret 
calculategametime endp
intializePort proc far
mov dx,3fbh ;line control register
mov al,10000000b ;set divisor latch access bit
out dx,al ;out it

mov dx,3f8h 
mov al,0ch
out dx,al

mov dx,3f9h
mov al,00h
out dx,al

mov dx,3fbh
mov al,00011011b
out dx,al

ret
intializePort endp


SENDKEY PROC far
MOV DX,3F8H
OUT DX,AL
RET
SENDKEY ENDP

inializeScreen proc far

mov iy,1
mov oy,1
mov ix,0
mov ox,39
mov ah,0
mov al,3h          ;to open text mode
int 10h


movecursor 10,0
showstring username
movecursor 50,0
showstring othername
mov ah,2
mov dl,38
mov dh,0
mov cx,25         ;the length of the screen
lp:
	mov ah,2      ;to move the cursor the the values of(dl,dh)
	int 10h
	mov dl,'|'   ;to print | to separate the screen at the middle
	int 21h
	mov dl,38
	inc dh
LOOP lp


ret
inializeScreen endp


screenInline proc far

push ax
push bx
push cx
push dx
push si
push di

mov ah,2
mov dl,80
mov dh,0
mov bx,0
mov cx,38     ;the length of the screen

lp2:
	mov ah,2      ;to move the cursor the the values of(dl,dh)
	int 10h
	mov dl,'X'    ;to print | to separate the screen at the middle
	int 21h
	mov dl,80
    inc dh
    mov bx,0  ;defines page number MUST FOR GRAPHICS MODE
LOOP lp2

pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
screenInline endp


SCROLLInputScreen proc far
	push ax
    push bx
    push cx
    push dx
    push si
    push di

	mov al,1h     ; function 6
	mov ah,6h
   mov bh,07h       ; normal video attribute         
   mov ch,1       ; upper left Y
   mov cl,0        ; upper left X
   mov dh,24    ; lower right Y
   mov dl,37      ; lower right X 
   int 10h  
mov ah,3
mov bh,0
int 10h   
;mov ah,2
;mov dl,' '
;int 21h

pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
SCROLLInputScreen endp


SCROLLInputScreen2 proc far

push ax
push bx
push cx
push dx
push si
push di

mov al,1h     ; function 6
mov ah,6h
mov bh,07h       ; normal video attribute         
mov ch,0       ; upper left Y
mov cl,61        ; upper left X
mov dh,36    ; lower right Y
mov dl,79      ; lower right X 
int 10h 

mov ah,3
mov bh,0
int 10h   
;mov ah,2
;mov dl,' '
;int 21h
movecursor 61,36
showstring scrollmessage

pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
SCROLLInputScreen2 endp

SCROLLOutputScreen proc far
	push ax
    push bx
    push cx
    push dx
    push si
    push di

	mov al,1h     ; function 6
	mov ah,6h
   mov bh,07h       ; normal video attribute         
   mov ch,1       ; upper left Y
   mov cl,39        ; upper left X
   mov dh,24    ; lower right Y
   mov dl,79      ; lower right X 
   int 10h  
mov ah,3
mov bh,0
int 10h   
;mov ah,2
;;mov dl,' '
;int 21h

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
SCROLLOutputScreen endp

SCROLLOutputScreen2 proc far
	push ax
    push bx
    push cx
    push dx
    push si
    push di

	mov al,1h     ; function 6
	mov ah,6h
    mov bh,07h       ; normal video attribute         
    mov ch,0       ; upper left Y
    mov cl,81        ; upper left X
    mov dh,36    ; lower right Y
    mov dl,99      ; lower right X 
   int 10h  
mov ah,3
mov bh,0
int 10h   
movecursor 81,36
showstring scrollmessage
;mov ah,2
;;mov dl,' '
;int 21h

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
SCROLLOutputScreen2 endp

newILine proc far
mov IX,0
cmp IY,24
jae skipinc 
inc IY
skipinc:
cmp IY,24
jb contnew
call SCROLLInputScreen
contnew:
ret
newILine endp


newILine2 proc far
mov IX2,61   ;Start of inline chat in x
cmp IY2,36
jae skipinc2 
inc IY2
skipinc2:
cmp IY2,36
jb contnew2
call SCROLLInputScreen2
contnew2:
ret
newILine2 endp

newOLine proc far
mov OX,39
cmp OY,24
jae skipincO 
inc OY
skipincO:
cmp OY,24
jb contnewO
call SCROLLOutputScreen
contnewO:
ret
newOLine endp

newOLine2 proc far
mov OX2,81
cmp oY2,36
jae skipinc22 
inc oY2
skipinc22:
cmp oY2,36
jb contnew22
call SCROLLoutputScreen2
contnew22:
ret
newOLine2 endp


WRITEINPUT PROC far
cmp al,13d        ;to check if the value entered is an enter key
je cont1
cmp Iy,24d
jb cont1
cmp ix,37d        ;to check the borders before writing the char
jb cont1

;CALL newILine
mov ix,0
mov AH,2
mov DL,IX
MOV DH,IY
mov bx,0
int 10h
call SCROLLInputScreen
RET
cc:
call SCROLLInputScreen
call newILine
mov IY,24d
mov AH,2
mov DL,IX
MOV DH,IY
int 10h
ret
cont1:
CMP AL,13d
JE IENTER
CMP ix,37
jb p1
mov IX,0
inc IY
p1:
mov AH,2
mov DL,IX
MOV DH,IY
int 10h

 

  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 1      ; Color (blue)
  MOV CX, 1      ; Character count
  INT 10h

INC IX
RET
IENTER:
CALL newILine
mov AH,2
mov DL,IX
MOV DH,IY
int 10h
RET
WRITEINPUT ENDP

WRITEINPUT2 PROC far

cmp al, 2Dh
je dontprint

cmp al, 3Dh
je dontprint

cmp al, 5Dh
je dontprint

cmp al,5Bh
je dontprint

cmp al, 5Ch
je dontprint

cmp al,13d        ;to check if the value entered is an enter key
je cont12
cmp Iy2,36        ;to check reached end of graphics mode in y
jb cont12
cmp ix2,79        ;to check the borders reached start of middle separator
jb cont12
mov IX2,61
;CALL newILine2
mov AH,2
mov bx,0  ;page 0
mov DL,IX2
MOV DH,IY2
int 10h
call SCROLLInputScreen2
dontprint:
RET
cc2:

call SCROLLInputScreen2
call newILine2

mov IY2,36
mov AH,2
mov DL,IX2
MOV DH,IY2
mov bx,0
int 10h
ret

cont12:
CMP AL,13d
JE IENTER2
CMP ix2,79
jb p12
mov IX2,61
inc IY2
p12:
mov AH,2
mov DL,IX2
MOV DH,IY2
mov bx,0
int 10h


  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 1      ; Color (blue)
  MOV CX, 1      ; Character count
  INT 10h

INC IX2
RET
IENTER2:
CALL newILine2
mov AH,2
mov DL,IX2
MOV DH,IY2
mov bx,0
int 10h
RET
WRITEINPUT2 ENDP

WRITEOUTPUT2 PROC far


cmp al, 2Dh
je dontprinto

cmp al, 3Dh
je dontprinto

cmp al, 5Dh
je dontprinto

cmp al,5Bh
je dontprinto

cmp al, 5Ch
je dontprinto


cmp al,13d
je cont2chat2  
cmp oy2,36d
jb cont2chat2
cmp ox2,99d     
jb cont2chat2
mov ox2,81
call SCROLLOutputScreen2      ;before scrolling the screen ->check the y if equal 24 and x if equal 79 the last place of the crusor ,if true scroll
dontprinto:
RET
cc12:

call SCROLLOutputScreen2
call newOLine2
mov oY2,36d
mov AH,2
mov bx,0
mov DL,oX2
MOV DH,oY2
int 10h
ret
cont2chat2:
CMP AL,13d
JE OENTER2
CMP ox2,99
jb p22
mov oX2,81
inc oY2
p22:
mov AH,2
mov bx,0
mov DL,oX2
MOV DH,oy2
int 10h


  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 4      ; Color (red)
  MOV CX, 1      ; Character count
  INT 10h

INC oX2
RET
OENTER2:
CALL newOLine2
mov AH,2
mov DL,OX2
MOV DH,OY2
mov bx,0
int 10h
RET
WRITEOUTPUT2 ENDP

WRITEOUTPUT PROC far
cmp al,13d
je cont2chat
cmp oy,24d
jb cont2chat
cmp ox,79d
jb cont2chat
mov ox,39
mov AH,2
mov DL,oX
MOV DH,oY
mov bx,0
int 10h
call SCROLLOutputScreen      ;before scrolling the screen ->check the y if equal 24 and x if equal 79 the last place of the crusor ,if true scroll
RET
cc1:
call SCROLLOutputScreen
call newOLine
mov oY,24d
mov AH,2
mov DL,oX
MOV DH,oY
int 10h
ret
cont2chat:
CMP AL,13d
JE OENTER
CMP ox,79
jb p2
mov oX,39
inc oY
p2:
mov AH,2
mov DL,oX
MOV DH,oy
int 10h


  MOV AH,09H
  MOV BH, 0      ; Set page number
  MOV BL, 4      ; Color (red)
  MOV CX, 1      ; Character count
  INT 10h

INC oX
RET
OENTER:
CALL newOLine
mov AH,2
mov DL,OX
MOV DH,OY
int 10h
RET
WRITEOUTPUT ENDP

CheckInput proc far

    push ax
    push bx
    push cx
    push dx
    push si
    push di
   ;MAINMENUUU
;Text Mode
mov ah,0 
mov al,3
int 10h
MoveCursor  4,2
showstring hellouser
MoveCursor  10,2
ShowString username
MoveCursor  4,5
ShowString startChattingMessage
MoveCursor  4,9
ShowString startGame
MoveCursor  4,13
ShowString endProgram
movecursor 0,18
showstring Notificationbar
movecursor 0,17
showstring Notificationbarmess
	CALL intializePort
	mov si,0
    mov di,0
	;CODE
	CHECKKEYPRESSEDU:
	mov dx , 3FDH		; Line Status Register
    In al , dx 			;Read Line Status
    AND al , 00100000b
    JZ CHECKKEYSENTU
	;CHECK IF THERE IS A KEY PRESSESD SEND TO THE OTHER USER
   

   MOV AH,01h
	INT 16H
	JZ didntpress     ;KEY recieved
	MOV AH,00
	INT 16H  
    didntpress:
    cmp ah,57
    jne notkey
    mov readytosend,1
    notkey:
    cmp ah,16
    je contrecU

    cmp readytosend,1
    jne CHECKKEYSENTU
    cmp finishednames,1
    je CHECKKEYSENTU
	mov al,username[si] 
    cmp al, '$'
    jne contsendU
    inc finishednames
    
    contsendU:
    
	CALL SENDKEY
	inc si
	CHECKKEYSENTU:
	;CHECK STATE IF THERE IS DATA RECIVED
	;IF THERE IS NO DATA RECIVED
	MOV DX,3FDH
	IN AL,DX
	AND AL,1
	JZ CHECKKEYPRESSEDU
	;IF THERE IS DATA RECIVED
	;RECIVE DATA AND CALL WRITE IN OUTPUT PROC
	MOV DX,03F8H
	IN AL,DX
   
    cmp finishednamer,1
    je contrecU
    mov othername[di],al
    inc di
    cmp al,'$'
    jne contrecU
    inc finishednamer
    contrecU:
   cmp ah,16
   jne CHECKKEYPRESSEDU
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
     
    ret
	JMP CHECKKEYPRESSEDU
	;END CODE


    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
     
ret
CheckInput endp

chatInline proc far

    push ax

	CALL intializePort
	
	;CODE
	CHECKKEYPRESSED2:
    push ax
    call timeAnimations
    call calculategametime
    pop ax 
	mov dx , 3FDH		; Line Status Register
    In al , dx 			;Read Line Status
    AND al , 00100000b
    JZ CHECKKEYSENT2
	
	;CHECK IF THERE IS A KEY PRESSESD SEND TO THE OTHER USER
	MOV AH,01h
	INT 16H
	JZ CHECKKEYSENT2     ;KEY recieved
	MOV AH,00
	INT 16H  
    cmp ah, 62
    jne dontgame
    
    mov al,179
    call SENDKEY
    call resetgame
    call invites
    dontgame:
	;CMP AL,1BH
	;JE exitchat2

    push ax
    CALL SENDKEY
    cmp al,8
    jne noback  
    call inlineback
    noback:
    cmp al,8
    je skipwriteinput2
	call WRITEINPUT2 ;there is no push pop inside the func DONT CHANGE AL
    skipwriteinput2:
    pop ax
    
	call yellowframe

	CHECKKEYSENT2:
	;CHECK STATE IF THERE IS DATA RECIVED
	;IF THERE IS NO DATA RECIVED
	MOV DX,3FDH
	IN AL,DX
	AND AL,1
	JZ CHECKKEYPRESSED2
	;IF THERE IS DATA RECIVED
	;RECIVE DATA AND CALL WRITE IN OUTPUT PROC
	MOV DX,03F8H
	IN AL,DX
    
    cmp al,179
    jne dontgame2
    ;call printMenu
    call resetgame
    call invites
    dontgame2: 
    push ax
    cmp al,8
    jne skipback2
    call inlinebackrec
    skipback2:
    cmp al,8
    je skipwriteoutput2
	CALL WRITEOUTPUT2
    skipwriteoutput2:
    pop ax

    xor player1,1  ;to act as if the other player
    call yellowframe
    xor player1,1  ;to return back to the write player

	JMP CHECKKEYPRESSED2
	;END CODE
	              
    ; exitchat2:
	 ;call SCROLLInputScreen2
	 ;call SCROLLOutputScreen2

    pop ax

ret
chatInline endp


chatfunc2 proc far
    
    call inializeScreen
	CALL intializePort
	
	;CODE
	CHECKKEYPRESSED:
	mov dx , 3FDH		; Line Status Register
    In al , dx 			;Read Line Status
    AND al , 00100000b
    JZ CHECKKEYSENT
	
	;CHECK IF THERE IS A KEY PRESSESD SEND TO THE OTHER USER
	MOV AH,01h
	INT 16H
	JZ CHECKKEYSENT     ;KEY recieved
	MOV AH,00
	INT 16H  
    cmp ah,61
    jne dontexitchat
    mov al,178
    CALL SENDKEY
   ; call printMenu
    call invites
    
	dontexitchat:
    cmp al,8
    jne skipbackspace
    call backspace
    skipbackspace:
    cmp al,8
    je skipwriteinput
	call WRITEINPUT
    skipwriteinput:
	CALL SENDKEY
	

	CHECKKEYSENT:
	;CHECK STATE IF THERE IS DATA RECIVED
	;IF THERE IS NO DATA RECIVED
	MOV DX,3FDH
	IN AL,DX
	AND AL,1
	JZ CHECKKEYPRESSED
	;IF THERE IS DATA RECIVED
	;RECIVE DATA AND CALL WRITE IN OUTPUT PROC
	MOV DX,03F8H
	IN AL,DX
    cmp al,178
    jne dontexitchat2
    ;call printMenu
    call invites
    jmp far ptr enterGame
    dontexitchat2:
    cmp al,8
    jne skipbackrec
    call backspacerec
    skipbackrec:
    cmp al,8
    je skipwriteoutput
	CALL WRITEOUTPUT
skipwriteoutput:
	JMP CHECKKEYPRESSED
	;END CODE

     

ret
chatfunc2 endp

gameblock proc far
Mov ax,4F02h
mov bx,103h
INT 10h
call randomNum


mov ah,2ch
int 21h  ; interupt to Get current system time in Dh-->seconds   Cl-->Minutes

mov al,cl
mov bl,60   
mul Bl ;result in ax contains curr time in seconds

mov dl,dh
mov dh,0
add ax,dx ;adds (minutes*60)+seconds
mov startTime,ax


mov bordercolor,1
mov startposx,540
mov startposy,0
call drawBox

DrawBoard i1,j1,startpos1,endpos1,startrowpos1,endrowpos1
InitialPiecies ;sets pieces in its intial position




MoveCursor  1,30
ShowString Status
MoveCursor  1,32
ShowString gameSarted
MoveCursor  40,30
ShowString  timerShow


call screenInline

gameloop:

call chatInline


;!!!!!!!!!!!!!!The following 3 lines are commented for easier testing!!!!!!!!!!!!!! (Donot wait for key press is the function of those lines)



call yellowframe



nokeypress:


jmp gameloop
 
gameended:
hlt
ret 
gameblock endp


MAIN PROC FAR

mov ax, @DATA
mov ds, ax

mov ah,0 
mov al,3
int 10h

MoveCursor  4,13
ShowString pressEnter
MoveCursor  4,5
ShowString enterName
MoveCursor  4,8
takeName ;takes username





call CheckInput  ;checks user input

MoveCursor  4, 10
ShowString  othername

MoveCursor  4, 12
ShowString  username

;call printMenu
call invites

;kano hena


chattingModule:  ;currenttly chatting opens game

call chatFunc2

enterGame:

;call resetgame
call gameblock

hlt

MAIN endp
end main