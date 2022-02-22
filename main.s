    // Template main.s file for Lab 3
    // partner names here

    .arch armv8-a

    // --------------------------------
    .global main
main:
    // driver function main lives here, modify this for your other functions
    stp x29, x30, [sp, -48]!  // FP, LR,
    mov x29, sp

    // Callee saved registers
    stp x19, x20, [sp, 16]
    stp x21, x22, [sp, 32]


calculate:
    // Print prompt and scan for first number
    ldr w0, =number1
    bl printf
    ldr w0, =scanint
    mov x1, sp  //Stack pointer needs to be saved to make space
    bl scanf
    ldr x19, [sp] //Store number in x3

    // Print prompt and scan for second number
    ldr w0, =number2
    bl printf
    ldr w0, =scanint
    mov x1, sp
    bl scanf
    ldr x20, [sp]

    // Print prompt and scan for operation
    ldr w0, =operation
    bl printf
    ldr w0, =scanchar
    mov x1, sp //Save sp in x1
    bl scanf  //Scan for operator
    ldrb w21, [sp]

    //do checks to see if mult, add, or sub
    ldr x6, =multiply
    ldrb w6, [x6]
    cmp w6, w21
    b.eq mult

    ldr x6, =subtract
    ldrb w6, [x6]
    cmp w6, w21
    b.eq sub

    ldr x6, =addition
    ldrb w6, [x6]
    cmp w6, w21
    b.eq add

mult:
    mov x0, x19
    mov x1, x20
    bl intmul
    b loop

add:
    mov x0, x19
    mov x1, x20
    bl intadd
    b loop

sub:
    mov x0, x19
    mov x1, x20
    bl intsub
    b  loop

    // You'll need to scan characters for the operation and to determine
    // if the program should repeat.
    // To scan a character, and compare it to another, do the following
loop:
      mov x1, x0
      ldr w0, =result
      bl printf
      ldr w0, =again //Prompt user to do another calculation
      bl printf
      ldr     w0, =scanchar
      mov     x1, sp          // Save stack pointer to x1, you must create space
      bl      scanf           // Scan user's answer
      ldr     x1, =yes        // Put address of 'y' in x1
      ldrb    w1, [x1]        // Load the actual character 'y' into x1
      ldrb    w0, [sp]        // Put the user's value in r0
      cmp     w0, w1          // Compare user's answer to char 'y'
      b.eq    calculate            // branch to appropriate location

      // Teardown
      ldp x19, x20, [sp, 16]
      ldp x21, x22, [sp, 32]
      ldp x29, x30, [sp], 48

      // Return from function
      ret
      
yes:
    .byte   'y'
scanchar:
    .asciz  " %c"
scanint:
    .asciz  " %d"
number1:
    .asciz  "Enter Number 1: "
number2:
    .asciz  "Enter Number 2: "
operation:
    .asciz  "Enter Operation: "
result:
    .asciz  "Result is: %d\n"
again:
    .asciz  "Again? "
invalid:
    .asciz  "Invalid Operation Entered.\n"
multiply:
    .byte   '*'
subtract:
    .byte   '-'
addition:
    .byte   '+'
