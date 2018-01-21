org 100h
     
;defining variables      
.DATA

inps db ,0dh,0ah, "Please enter the number of elements in the sequence:$"
inpr db ,0dh,0ah, "Please enter suitable number in the range of [1-25]:$"    
input_c db 0
num1 Dw ?
num2 Dw ?
temp1 Dw ?
temp2 DW ? 
ten Dw ?   

.CODE 

;getting input from user 
enter:    
lea dx, inps                  ;;;;;
mov ah, 9
int 21h 
jmp numbers  

suitnum:
lea dx, inpr                  ;;;;;
mov ah, 9
int 21h 

numbers:
;input_first digit; 
mov ah, 1   
int 21h  
sub al, 30h
mov dl, 10
mov ah, 0
mul dl 
mov dx, ax            ;dx tens
         
;input_second digit;
mov ah,1
int 21h
sub al, 30h
add dl, al
mov input_c, dl
 
;checking if the number is in the range;
mov ax,0
cmp input_c,ah 
je finish 
mov bl, 1
mov bh, 25
cmp input_c , bl
jb suitnum
cmp input_c , bh
ja suitnum



;printing newline; 
mov ah, 0eh
mov al, 0dh
int 10h
mov al, 0ah
int 10h

;generating fibonacci sequence;
MOV ten, 10

mov num1, 0
add num1, 30h 
mov num2, 1 
add num2, 30h
     
mov ah, 2 
mov dx,num1
int 21h    ;printing output 

DEC input_c
CMP input_c,0
JE enter

;printing comma         
mov dx, 0
mov dl , ','
mov ah, 2
int 21h 
           
  
Mov Bx, num1
Mov DX, num2

JMP cont

fib:
MOV Bx, temp2
MOV DX, temp1 

cont:
MOV temp1, BX  
ADD Bx, DX              
SUB BX, 30h
MOV DX, temp1 
MOV temp2, BX
CMP Bl,3Dh
JAE OUTPUt
CMP BH, 01h
JAE OUTPUT
MOV ah, 2
MOV dl, BL
int 21h      ;printing output

DEC input_c
CMP input_c,0
JE enter     

     
;printing comma         
mov dx, 0
mov dl , ','
mov ah, 2
int 21h 
           
JMP fib
       
       
;differnet implementation to output numbers that needs 16bit reg       
OUTPUT:  

SUB temp2, 30h
MOV Ax,temp2 
MOV Sp, 00h
MOV CL,0


again:
MOV Dx, 00h
DIV ten  
ADD  DX, 30h
PUSH DX
INC Cl
CMP Ax,0
jne again  

;MOV CH, CL

popping:
pop dx 
MOV ah,2
int 21h         ;printing output

DEC Cl
CMP Cl,0
jne popping

DEC input_c
CMP input_c,0
je enter

;printing comma         
mov dx, 0
mov dl , ','
mov ah, 2
int 21h 

ADD temp2, 30h
jmp fib

;printing newline;
mov ax, 0
mov ah, 0eh
mov al, 0dh
int 10h
mov al, 0ah
int 10h
jmp enter

finish:
int 20h


ret
 
