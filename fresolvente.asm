;Liz Moreno
; -b +-raiz cuadada(b^2-4.a.c) / 2.a
;%include "io.inc"
extern printf
global resolvente
section .data

menosB dd 0.0 ;
bElevadoALa2 dd 0.0; resultado parcial de b^2
cuatroPorAporC dd 0.0; resultado parcial de 4.a.c
dosPorA dd 0.0; resultado parcial de 2.a
raizcuadrada dd 0.0; resultado parcial de la raiz

numeradorSuma dd 0.0
numeradorResta dd 0.0

raiz1 dq 0.0; resul final
raiz2 dq 0.0;resul final

cuatro dd 4.0
dos dd 2.0

fmt db "La raiz 1 es: %.2f y la raiz 2 es: %.2f", 10,13,0

section .text
;las variables de C a= EBP+8, b= EBP+12, c= EBP+16;;
resolvente:
    push ebp
    mov ebp, esp
    
    FLD dword[EBP+12]; b
    FCHS ; -b cambio de signo
    FSTP dword[menosB]; aca guardo y pop
    
    FLD dword[EBP+12]; b
    FLD dword[EBP+12]; b
    FMUL ; realizo el b.b = b^2 ;ver si se puede hacer otra forma
    FSTP dword[bElevadoALa2] 
    
    FLD dword[cuatro]; cuatro es una varible constante
    FLD dword[EBP+8]; aca esta la variable 'a' que viene desde c
    FMUL
    FLD dword[EBP+16] ; aca esta la variable 'c' que viene desde c
    FMUL
    FSTP dword[cuatroPorAporC]; 4*a*c & pop
    
    FLD dword[dos]; 2 es una varibale constante
    FLD dword[EBP+8] ;aca esta la variable 'a' 
    FMUL 
    FSTP dword[dosPorA] ; 2.a & pop
    
    FLD dword[bElevadoALa2]
    FLD dword[cuatroPorAporC]
    FSUB; aplico resta b^2-  4.a.c
    FSQRT; calculo raiz al resul de la resta
    FSTP dword[raizcuadrada];guarda el resutl de la raiz cuadrada
    
    FLD dword[menosB]; 
    FLD dword[raizcuadrada]
    FADD ; sumo -b + result de la raiz ccuadrada
    FSTP dword[numeradorSuma]; guadra & pop
    
    FLD dword[menosB]; 
    FLD dword[raizcuadrada]
    FSUB ; rest -b - result de la raiz ccuadrada
    FSTP dword[numeradorSuma]; guadra & pop
    
    FLD dword[numeradorSuma]
    FLD dword[dosPorA]
    FDIV; numeradorSuma/dorPorA
    FSTP qword[raiz1]; primera raiz encontrada
    
    FLD dword[numeradorResta]
    FLD dword[dosPorA]
    FDIV; numeradorresta/dorPorA
    FSTP qword[raiz2]; segunda raiz encontrada
    
    push dword[raiz2+4]
    push dword[raiz2]
    
    push dword[raiz1+4]
    push dword[raiz1]
    
    push fmt
    call printf
    add esp, 20; 5 words de 4bytes
    
    mov ebp, esp ;recuperamos nuestro esp
    pop ebp;  
      
    ret