# Bitzzy

Bitzzy is a LittleBigPlanet3 CPU made by Mazzetip that uses both digital and analog architecture. It has 16-bit addressing, 8-bit registers, is single-core and runs stable up to 10hz. 

The CPU is equipped with 3 registers, X, Y and Z. X and Y are general-purpose registers used for receiving, processing and storing data. The Z register is the accumulator, it receives the result from most double-register instructions, such as arithmetic instructions, but this register can also be used like X and Y with no differences.

## Interrupts

This CPU is also equipped with an interrupt system that includes IRQ \(Interrupt Request Signal\) and NMI \(Non-Maskable Interrupt\) similar to the 6502 CPU.

Both interrupts have their own addresses that tell the CPU where to jump when the NMI or IRQ signals are on.

The IRQ interrupt can be enabled and disabled using instructions in the code. So, when an IRQ is called while it's disabled, then the interrupt will be forgotten completely, it will **not** be halted until interrupts are enabled. Also, if interrupts are disabled and an NMI is called, the interrupt will be called anyway, because as the name says: it's a Non-Maskable Interrupt.

Once an interrupt is called, the CPU will save the current address to the return stack, perform a jump to the location specified and keep running code. The CPU can return from an interrupt with the instruction **Return** & **Return and Restore**. It is recommended to use Return and Restore and this one restores the original state of the CPU.

## Return Stack

The return stack is a stack used for interrupts and some jump instructions. It not only saves the current Program Counter, it saves the entire state of the CPU, including the Program Counter, X, Y and Z registers, Remainder and Interrupt Enabling.

There are two instructions that pop the return stack, Return & Return and Restore.

* "Return" only restores the Program Counter.
* "Return and Restore" restores the entire CPU state.

Even though Return and Restore is recommended to be used on interrupts, it can also be used in conjunction of "jump & add to return stack" instrucions as a way to restore the registers pre-jump, instead of doing three writes and three reads.

## Remainders

Instead of using a carry flag, the CPU uses a remainder system that gives you the result of any math the CPU makes. If you add $80 \(128 in decimal\) on the X register and $A0 \(160 in decimal\) on the Y register, the result will be above the 8-bit limit \(288\) so, the CPU will return to the Z register the value $20 \(32 in decimal\) and on the remainder, $01.
This also means, any multiplication will return a 16-bit number, split between the 8-bit remainder and the used 8-bit register. If you multiply $45 \(69 in decimal\) and $C0 \(192 in decimal\) the result will be $C0 on the returned register and $33 \(51 in decimal\) on the remainder.
Keep in mind, that even incrementing/decrementing values also use this register, and when you do any kind of math that doesn't reach the 8-bit limit, **the remainder still will be reset**. If you need to use a previous value of the remainder for something, you can copy the remainder to a register and store it or use it as a register.

## Software

As a test of the CPU, Bitzzy has been used along with a terminal note display to execute an \(inspired\) version of Wozmon, which had beautified features like a welcome message, READY and ERROR messages. You could read, write and execute machine code.

TODO: Find vid.

## ISA

Bitzzy is an 8-bit CPU, and so the limit of total instructions in a single byte are 256, however this CPU only uses 152 of those 256, but these instructions were chosen to make execution of code quicker on the relatively slow speed of 10hz, using some relatively-specific instructions spreaded across the instruction set.

| Upper bits → Lower bits ↓ | $0        | $1                | $2                      | $3               | $4               | $5               | $6               | $7               | $8           | $9               | $A                   | $B                   | $C                    | $D                        | $E                 | $F                     |
| ------------------------- | --------- | ----------------- | ----------------------- | ---------------- | ---------------- | ---------------- | ---------------- | ---------------- | ------------ | ---------------- | -------------------- | -------------------- | --------------------- | ------------------------- | ------------------ | ---------------------- |
| $0                        | $00 HLT   | $10 JMP \<addr\>    | $20 JMPEZ X, \<addr\>     | $30 INC X        | $40 ADD X, \<imm\> | $50 ADD Y, \<imm\> | $60 ADD Z, \<imm\> | $70 LSL X        | $80 AND X, Y | $90 AND X, \<imm\> | $A0 LOD X, \<addr\>    | $B0 LOD Y, \<addr\>    | $C0 LOD Z, \<addr\>     | $D0 STR \<imm\>, \<addr\>     | $E0 DJNZ X, \<addr\> | $F0 JMPRNZ \<addr\>      |
| $1                        | $01 RET   | $11 JMP \<addr\>, X | $21 JMPEZ Z, \<addr\>     | $31 INC Y        | $41 SUB X, \<imm\> | $51 SUB Y, \<imm\> | $61 SUB Z, \<imm\> | $71 LSL Y        | $81 AND X, Z | $91 AND Y, \<imm\> | $A1 LOD X, \<addr\>, Y | $B1 LOD Y, \<addr\>, X | $C1 LOD Z, \<addr\>, X  | $D1 STR \<imm\>, \<addr\>, X  | $E1 DJNZ Y, \<addr\> | $F1 JMPREZ \<addr\>      |
| $2                        | $02 RTS   | $12 JMP \<addr\>, Y | $22 JMPGT X, Y,  \<addr\> | $32 INC Z        | $42 MUL X, \<imm\> | $52 MUL Y, \<imm\> | $62 MUL Z, \<imm\> | $72 LSL Z        | $82 AND Y, Z | $92 AND Z, \<imm\> | $A2 LOD X, \<addr\>, Z | $B2 LOD Y, \<addr\>, Z | $C2 LOD Z, \<addr\>, Y  | $D2 STR \<imm\>, \<addr\>, Y  | $E2 DJNZ Z, \<addr\> | $F2 JMPEQ X, Z, \<addr\> |
| $3                        | $03 ENI   | $13 JMP \<addr\>, Z | $23 JMPEQ X, Y \<addr\>   | $33 INC \<addr\>   | $43 DIV X, \<imm\> | $53 DIV Y, \<imm\> | $63 DIV Z, \<imm\> |                  |              |                  |                      |                      | $C3 LOD Z, \<addr\>, YX | $D3 STR \<imm\>, \<addr\>, Z  |                    | $F3 JMPEQ Y, Z, \<addr\> |
| $4                        | $04 DSI   | $14 JSR \<addr\>    | $24 JSREZ X, \<addr\>     | $34 DEC X        | $44 ADD X, Y     |                  |                  | $74 LSR X        | $84 XOR X, Y | $94 OR X, \<imm\>  | $A4 STR X, \<addr\>    | $B4 STR Y, \<addr\>    | $C4 STR Z, \<addr\>     | $D4 STR \<imm\>, \<addr\>, YX |                    | $F4 RETREZ             |
| $5                        | $05 NOP   | $15 JSR \<addr\>, X | $25 JSREZ Y, \<addr\>     | $35 DEC Y        | $45 ADD X, Z     | $55 ADD Y, Z     |                  | $75 LSR Y        | $85 XOR X, Z | $95 OR Y, \<imm\>  | $A5 STR X, \<addr\>, Y | $B5 STR Y, \<addr\>, X | $C5 STR Z, \<addr\>, X  |                           |                    | $F5 RETRNZ             |
| $6                        |           | $16 JSR \<addr\>, Y | $26 JSRGT X, Y,  \<addr\> | $36 DEC Z        | $46 SUB X, Y     | $56 SUB Y, X     | $66 SUB Z, X     | $76 LSR Z        | $86 XOR Y, Z | $96 OR Z, \<imm\>  | $A6 STR X, \<addr\>, Z | $B6 STR Y, \<addr\>, Z | $C6 STR Z, \<addr\>, Y  |                           |                    |                        |
| $7                        |           | $17 JSR \<addr\>, Z | $27 JSREQ X, Y \<addr\>   | $37 DEC \<addr\>   | $47 SUB X, Z     | $57 SUB Y, Z     | $67 SUB Z, Y     |                  |              |                  |                      |                      |                       |                           |                    |                        |
| $8                        | $08 REM X | $18 SWP X, Y      | $28 LOD X, Y            | $38 SUB \<imm\>, X | $48 MUL X, Y     |                  |                  | $78 NOT X        | $88 OR X, Y  | $98 XOR X, \<imm\> |                      |                      |                       |                           |                    |                        |
| $9                        | $09 REM Y | $19 SWP X, Z      | $29 LOD X, Z            | $39 SUB \<imm\>, Y | $49 MUL X, Z     | $59 MUL Y, Z     |                  | $79 NOT Y        | $89 OR X, Z  | $99 XOR Y, \<imm\> |                      |                      |                       |                           |                    |                        |
| $A                        | $0A REM Z |                   | $2A LOD Y, X            | $3A SUB \<imm\>, Z | $4A DIV X, Y     | $5A DIV Y, X     | $6A DIV Z, X     | $7A NOT Z        | $8A OR Y, Z  | $9A XOR Z, \<imm\> |                      |                      |                       |                           |                    |                        |
| $B                        | $0B CLR   | $1B SWP Y, Z      | $2B LOD Y, Z            |                  | $4B DIV X, Z     | $5B DIV Y, Z     | $6B DIV Z, Y     |                  |              |                  |                      |                      |                       |                           |                    |                        |
| $C                        |           |                   | $2C LOD Z, X            | $3C DIV \<imm\>, X | $4C MOD X, Y     | $5C MOD Y, X     | $6C MOD Z, X     | $7C LOD X, \<imm\> |              | $9C MOD X, \<imm\> |                      |                      |                       |                           |                    |                        |
| $D                        |           |                   | $2D LOD Z, Y            | $3D DIV \<imm\>, Y | $4D MOD X, Z     | $5D MOD Y, Z     | $6D MOD Z, Y     | $7D LOD Y, \<imm\> |              | $9D MOD Y, \<imm\> |                      |                      |                       |                           |                    |                        |
| $E                        |           |                   |                         | $3E DIV \<imm\>, Z |                  |                  |                  | $7E LOD Z, \<imm\> |              | $9E MOD Z, \<imm\> |                      |                      |                       |                           |                    |                        |
| $F                        |           |                   |                         |                  |                  |                  |                  |                  |              |                  |                      |                      |                       |                           |                    |                        |

### HLT - Halt CPU

This instruction results in the CPU stopping execution, and only an interrupt can resume it.

|Assembly|Cycles|Bytes|
|-|-|-|
|HLT|2|1|

### RET - Return

Returns from a subroutine.

|Assembly|Cycles|Bytes|
|-|-|-|
|RET|2|1|

### RTS - Return and Restore

Returns from a subroutine and restores the previous state of the CPU.

|Assembly|Cycles|Bytes|
|-|-|-|
|RTS|2|1|

### ENI - Enable Interrupts

Enables interrupts.

|Assembly|Cycles|Bytes|
|-|-|-|
|ENI|2|1|

### DSI - Disable Interrupts

Disables interrupts.

|Assembly|Cycles|Bytes|
|-|-|-|
|DSI|2|1|

### NOP - No Operation

No operation executed, time waster.

|Assembly|Cycles|Bytes|
|-|-|-|
|NOP|2|1|

### REM - Save Remainder

Save remainder to a register.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|To X register|REM X|2|1|
|To Y register|REM Y|2|1|
|To Z register|REM Z|2|1|

### CLR - Clear Remainder

Sets the remainder to zero.

|Assembly|Cycles|Bytes|
|-|-|-|
|CLR|2|1|

### JMP - Jump

Jumps execution to a different address.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Absolute address|JMP <addr>|3|3|
|Utilize Jump Table at Absolute+X|JMP \<addr\>, X|5|3|
|Utilize Jump Table at Absolute+Y|JMP \<addr\>, Y|5|3|
|Utilize Jump Table at Absolute+Z|JMP \<addr\>, Z|5|3|

### JSR - Jump to Subroutine

Jumps execution to a subroutine, saving the state of the CPU to the return stack.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Absolute address|JSR <addr>|3|3|
|Utilize Jump Table at Absolute+X|JSR \<addr\>, X|5|3|
|Utilize Jump Table at Absolute+Y|JSR \<addr\>, Y|5|3|
|Utilize Jump Table at Absolute+Z|JSR \<addr\>, Z|5|3|

### SWP - Swap

Swaps registers.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X and Y|SWP X, Y|2|1|
|X and Z|SWP X, Z|2|1|
|Y and Z|SWP Y, Z|2|1|

### JMPEZ - Jump if Equal Zero

Jumps execution to address if register is equal zero.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X|JMPEZ X, \<addr\>|2 if false, 3 if true|3|
|Using Z|JMPEZ Z, \<addr\>|2 if false, 3 if true|3|

### JMPGT - Jump if Greater Than

Jumps execution to address if register X is greater than Y. \(8-bit unsigned\)

|Assembly|Cycles|Bytes|
|-|-|-|
|JMPGT X, Y, \<addr\>|2 if false, 3 if true|3|

### JMPEQ - Jump if Equal

Jumps execution to address if both registers are equal.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X & Y|JMPEQ X, Y, \<addr\>|2 if false, 3 if true|3|
|Using X & Z|JMPEQ X, Z, \<addr\>|2 if false, 3 if true|3|
|Using Y & Z|JMPEQ Y, Z, \<addr\>|2 if false, 3 if true|3|

### JSREZ - Jump to Subroutine if Equal Zero

Jumps execution to address and save to the return stack if register is equal zero.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X|JSREZ X, \<addr\>|2 if false, 3 if true|3|
|Using Z|JSREZ Z, \<addr\>|2 if false, 3 if true|3|

### JSRGT - Jump to Subroutine if Greater Than

Jumps execution to address and save to the return stack if register X is greater than Y. \(8-bit unsigned\)

|Assembly|Cycles|Bytes|
|-|-|-|
|JSRGT X, Y, \<addr\>|2 if false, 3 if true|3|

### JSREQ - Jump to Subroutine if Equal

Jumps execution to address and save to the return stack if X and Y.

|Assembly|Cycles|Bytes|
|-|-|-|
|JSREQ X, Y, \<addr\>|2 if false, 3 if true|3|

### DJNZ - Decrement And Jump if Not Zero

Decrements register and jumps if the register is now not zero.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X|DJNZ X, \<addr\>|2 if false, 3 if true|3|
|Using Y|DJNZ Y, \<addr\>|2 if false, 3 if true|3|
|Using Z|DJNZ Z, \<addr\>|2 if false, 3 if true|3|

### JMPRNZ - Jump if Remainder Not Zero

Jumps execution to a new address if the remainder is not zero.

|Assembly|Cycles|Bytes|
|-|-|-|
|JMPRNZ \<addr\>|2 if false, 3 if true|3|

### JMPREZ - Jump if Remainder Equals Zero

Jumps execution to a new address if the remainder is zero.

|Assembly|Cycles|Bytes|
|-|-|-|
|JMPREZ \<addr\>|2 if false, 3 if true|3|

### JMPREZ - Return if Remainder Equals Zero

Returns from a subroutine if the remainder is zero.

|Assembly|Cycles|Bytes|
|-|-|-|
|RETREZ \<addr\>|2 if false, 3 if true|3|

### JMPRNZ - Return if Remainder Not Zero

Returns from a subroutine if the remainder is not zero.

|Assembly|Cycles|Bytes|
|-|-|-|
|RETRNZ \<addr\>|2 if false, 3 if true|3|

### LOD - Load

Loads a value from a register or address to another register.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X to Y|LOD X, Y|2|1|
|X to Z|LOD X, Z|2|1|
|Y to X|LOD Y, X|2|1|
|Y to Z|LOD Y, Z|2|1|
|Z to X|LOD Z, X|2|1|
|Z to Y|LOD Z, Y|2|1|
|Immediate to X|LOD X, \<imm\>|2|2|
|Immediate to Y|LOD Y, \<imm\>|2|2|
|Immediate to Z|LOD Z, \<imm\>|2|2|
|Address to X|LOD X, \<addr\>|4|3|
|Address+Y to X|LOD X, \<addr\>, Y|4|3|
|Address+Z to X|LOD X, \<addr\>, Z|4|3|
|Address to Y|LOD Y, \<addr\>|4|3|
|Address+X to Y|LOD Y, \<addr\>, X|4|3|
|Address+Z to Y|LOD Y, \<addr\>, Z|4|3|
|Address to Z|LOD Z, \<addr\>|4|3|
|Address+X to Z|LOD Z, \<addr\>, X|4|3|
|Address+Y to Z|LOD Z, \<addr\>, Y|4|3|
|Address+Y as upper 8 bits+X as lower 8 bits to Z|LOD Z, \<addr\>, YX|4|3|

### STR - Store

Stores a value from a register to an address.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Immediate to Address|STR \<imm\>, \<addr\>|5|4|
|Immediate to Address+X|STR \<imm\>, \<addr\>, X|5|4|
|Immediate to Address+Y|STR \<imm\>, \<addr\>, Y|5|4|
|Immediate to Address+Z|STR \<imm\>, \<addr\>, Z|5|4|
|Immediate to Address+Y as upper 8 bits+X as lower 8 bits|STR \<imm\>, \<addr\>, YX|5|4|
|X to Address|STR X, \<addr\>|4|3|
|X to Address+Y|STR X, \<addr\>, Y|4|3|
|X to Address+Z|STR X, \<addr\>, Z|4|3|
|Y to Address|STR Y, \<addr\>|4|3|
|Y to Address+X|STR Y, \<addr\>,X|4|3|
|Y to Address+Z|STR Y, \<addr\>,Z|4|3|
|Z to Address|STR Z, \<addr\>|4|3|
|Z to Address+X|STR Z, \<addr\>,X|4|3|
|Z to Address+Z|STR Z, \<addr\>,Y|4|3|

### INC - Increment

Increment register or address by one.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|To X|INC X|2|1|
|To Y|INC Y|2|1|
|To Z|INC Z|2|1|
|To Address|INC \<addr\>|5|1|

### DEC - Decrement

Decrement register or address by one.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|To X|DEC X|2|1|
|To Y|DEC Y|2|1|
|To Z|DEC Z|2|1|
|To Address|DEC \<addr\>|5|1|

### ADD - Addition

Performs addition on an register and/or immediate. Remainder will be 1 when overflowed.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X + Immediate|ADD X, \<imm\>|2|2|
|Y + Immediate|ADD Y, \<imm\>|2|2|
|Z + Immediate|ADD Z, \<imm\>|2|2|
|X + Y|ADD X, Y|2|1|
|X + Z|ADD X, Z|2|1|
|Y + Z|ADD Y, Z|2|1|

### SUB - Substraction

Performs substraction on an register and/or immediate. Remainder will be 1 when underflowed.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X - Immediate|SUB X, \<imm\>|2|2|
|Y - Immediate|SUB Y, \<imm\>|2|2|
|Z - Immediate|SUB Z, \<imm\>|2|2|
|Immediate - X|SUB \<imm\>, X|2|2|
|Immediate - Y|SUB \<imm\>, Y|2|2|
|Immediate - Z|SUB \<imm\>, Z|2|2|
|X - Y|SUB X, Y|2|1|
|X - Z|SUB X, Z|2|1|
|Y - X|SUB Y, X|2|1|
|Y - Z|SUB Y, Z|2|1|
|Z - X|SUB Z, X|2|1|
|Z - Y|SUB Z, Y|2|1|

### MUL - Multiplication

Performs multiplication on an register and/or immediate. Remainder will be set as the upper 8 bits of the multiplication.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X * Immediate|MUL X, \<imm\>|2|2|
|Y * Immediate|MUL Y, \<imm\>|2|2|
|Z * Immediate|MUL Z, \<imm\>|2|2|
|X * Y|MUL X, Y|2|1|
|X * Z|MUL X, Z|2|1|
|Y * Z|MUL Y, Z|2|1|

### DIV - Division

Performs division on an register and/or immediate. Remainder will always be set as zero.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X / Immediate|DIV X, \<imm\>|2|2|
|Y / Immediate|DIV Y, \<imm\>|2|2|
|Z / Immediate|DIV Z, \<imm\>|2|2|
|Immediate / X|DIV \<imm\>, X|2|2|
|Immediate / Y|DIV \<imm\>, Y|2|2|
|Immediate / Z|DIV \<imm\>, Z|2|2|
|X / Y|DIV X, Y|2|1|
|X / Z|DIV X, Z|2|1|
|Y / X|DIV Y, X|2|1|
|Y / Z|DIV Y, Z|2|1|
|Z / X|DIV Z, X|2|1|
|Z / Y|DIV Z, Y|2|1|

### MOD - Modulo

Performs a division on an register and/or immediate and returns the remainder of the division. Remainder will always be set as zero.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X % Immediate|MOD X, \<imm\>|2|2|
|Y % Immediate|MOD Y, \<imm\>|2|2|
|Z % Immediate|MOD Z, \<imm\>|2|2|
|Immediate % X|MOD \<imm\>, X|2|2|
|Immediate % Y|MOD \<imm\>, Y|2|2|
|Immediate % Z|MOD \<imm\>, Z|2|2|
|X % Y|MOD X, Y|2|1|
|X % Z|MOD X, Z|2|1|
|Y % X|MOD Y, X|2|1|
|Y % Z|MOD Y, Z|2|1|
|Z % X|MOD Z, X|2|1|
|Z % Y|MOD Z, Y|2|1|

### LSL - Left Shift

Left shift a register by one.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X|LSL X|2|1|
|Using Y|LSL Y|2|1|
|Using Z|LSL Z|2|1|

### LSR - Right Shift

Right shift a register by one.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X|LSR X|2|1|
|Using Y|LSR Y|2|1|
|Using Z|LSR Z|2|1|

### NOT - Logical NOT

Toggle all bits from one to zero, and from zero to one.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|Using X|NOT X|2|1|
|Using Y|NOT Y|2|1|
|Using Z|NOT Z|2|1|

### AND - Logical AND

AND two values together.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X & Y|AND X, Y|2|1|
|X & Z|AND X, Z|2|1|
|Y & Z|AND Y, Z|2|1|
|X & Immediate|AND X, \<imm\>|2|2|
|Y & Immediate|AND Y, \<imm\>|2|2|
|Z & Immediate|AND Z, \<imm\>|2|2|

### OR - Logical OR

OR two values together.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X & Y|OR X, Y|2|1|
|X & Z|OR X, Z|2|1|
|Y & Z|OR Y, Z|2|1|
|X & Immediate|OR X, \<imm\>|2|2|
|Y & Immediate|OR Y, \<imm\>|2|2|
|Z & Immediate|OR Z, \<imm\>|2|2|

### XOR - Logical XOR

XOR two values together.

|Type|Assembly|Cycles|Bytes|
|-|-|-|-|
|X & Y|XOR X, Y|2|1|
|X & Z|XOR X, Z|2|1|
|Y & Z|XOR Y, Z|2|1|
|X & Immediate|XOR X, \<imm\>|2|2|
|Y & Immediate|XOR Y, \<imm\>|2|2|
|Z & Immediate|XOR Z, \<imm\>|2|2|
