    // Template main.s file for Lab 3
    // partner names here

    .arch armv8-a

    // --------------------------------
    .global main
main:
    // driver function main lives here, modify this for your other functions
    stp x29, x30, [sp, -32]!  // FP, LR, additional 2 registers
    mov x29, sp

    // Callee saved registers
    

calculate:
    // Print prompt and scan for first number
    ldr w0, =number1
    bl printf
    ldr w0, =scanint
    mov x1, sp  //Stack pointer needs to be saved to make space
    bl scanf
    ldr x3, [sp] //Store number in x3

    // Print prompt and scan for second number
    ldr w0, =number2
    bl printf
    mov x1, sp
    bl scanf
    ldr x3, [sp]

    // Print prompt and scan for operation
    ldr w0, =operation
    bl printf
    ldr w0, =scanchar
    mov x1, sp //Save sp in x1
    bl scanf  //Scan for operator



    // You'll need to scan characters for the operation and to determine
    // if the program should repeat.
    // To scan a character, and compare it to another, do the following
loop: ldr     w0, =scanchar
      mov     x1, sp          // Save stack pointer to x1, you must create space
      bl      scanf           // Scan user's answer
      ldr     x1, =yes        // Put address of 'y' in x1
      ldrb    w1, [x1]        // Load the actual character 'y' into x1
      ldrb    w0, [sp]        // Put the user's value in r0
      cmp     w0, w1          // Compare user's answer to char 'y'
      b       loop            // branch to appropriate location

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
add:
    .byte   '+'
