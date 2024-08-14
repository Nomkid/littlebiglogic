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
Keep in mind, that even incrementing/decrementing values also use this register, and when you do any kind of math that doesn't reach the 8-bit limit, **the remainder still will be reset**. If you need to use the remainder for something, you can copy the remainder to a register and store it/use it as a register.

## ISA

Bitzzy is an 8-bit CPU, and so the limit of total instructions in a single byte are 256, however this CPU only uses 152 of those 256, but these instructions were chosen to make execution of code quicker on the relatively slow speed of 10hz, using some relatively-specific instructions spreaded across the instruction set.

TODO: the entire ISA

## Software

As a test of the CPU, Bitzzy has been used along with a terminal note display to execute an \(inspired\) version of Wozmon, which had beautified features like a welcome message, READY and ERROR messages. You could read, write and execute machine code.

TODO: Find vid.
