    // intsub function in this file

    .arch armv8-a
    .global intsub
/*

x19: minuend
x20: subtrahend

SEE FLOWCHART INCLUDED IN GIT REPO

*/

intsub:
        stp x29, x30, [sp, -32]!
        mov x29, sp
        stp x19, x20, [sp, 16]
        mov x19, x0
        mov x20, x1

        mvn x20, x20
        mov x0, x20
        mov x1, #1
        bl intadd
        mov x1, x19
        bl intadd
        ldp x19, x20, [sp, 16]
        ldp x29, x30, [sp], 32
        ret
