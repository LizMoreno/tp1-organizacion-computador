;Liz Moreno
;Escriba una función en assembler IA-32 que reciba un puntero a un
;vector de números de punto flotante de precisión simple y calcule la suma. El
;prototipo de la función es: float suma_vf(float *vector, int
;cantidad);
%include "io.inc"
extern printf

section .data

vector dd 1.50,1.50,3.00
cant dd 3
resultado dq 0.0
fmt db " El resultado de la suma del vector de numeros es: %f", 10
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax ; contador
    push cant
    push vector
    call suma
    add esp, 8; cada word son 4bytes    
    push dword[resultado+4] ; aca empiezaa  imprimir
    push dword[resultado]
    push fmt
    call printf
    add esp, 12; tenemos recuperado nuestro esp; 3 words son 12bytes
    xor ebx, ebx
    ret
    
suma:
    push ebp; enter
    mov ebp, esp
    mov ebx, [EBP+8]; direccion del vector
    mov edx, [EBP+12];direccion de la cant 
    FLD dword[ebx] ;load floating point 
    INC eax; contador+1
ciclo:
    FLD dword[ebx+4*eax]
    FADD ;add floating 
    INC eax; contador+1
    CMP eax,[edx] ;comparo la cant con el contador
    JL ciclo;Salta si es menor

    FST qword[resultado]; store floating point
    mov ebp, esp; reinicio la pila 
    pop ebp; recuperamos nuestro esp
    
    ret