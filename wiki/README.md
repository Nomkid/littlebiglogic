Table of conents:

# Game mechanics

* [Gate behavior](/gate-behavior)
	* Wire values
	* Player color
	* AND, OR, XOR, NOT
	* Other gates
	* Microchips and sequencers
	* Tags
	* Inf, NaN, and illegal values
	* Rounding errors
	* Thermometer usage
* Frame updates
	* Gate update order
	* Update phases
	* Specific gate priorities



# Computing components

* [Analog value representations](/analog-value-representations)
	* IEEE 754
	* 2's complement
	* Notes and readouts
	* Word sizes
	* Fixed point
	* 16-bit IEEE 754
* Analog conversions
	* Digital to analog combiner/encoder
	* Pure analog splitter/decoder
	* Basic analog to digital splitter/decoder
	* 2-gate analog to digital splitter/decoder
	* Greater than 24-bit splitter/decoder
	* Analog bitshifting
* Digital integer arithmetic
	* Bitwise operations
	* Addition
	* Subtraction
	* Bitshifting and rotation
* Analog integer arithmetic
	* Addition and subtraction
	* Comparisons
	* Multiplication
	* Division
	* Arbitrary bitshifting
* Analog float arithmetic
	* Addition and subtraction
	* Multiplication
	* Subtractive division
	* Newton-Raphson division
	* Arctan division
* Control flow
	* Encoders and decoders
	* Multiplexers
	* Frelay
* Tag-based computing
	* Tag-based gates
	* Emitter-based dynamic circuits
* Instruction decoding
	* Opcodes and operands
	* Immediates
	* Variable length
* Feedback loops
	* Direct loops
	* Tag loop
	* Registers
* Debugging
	* Signal probe
	* Controlled pulses
	* Timelines
	* Screen recordings



# Computer architecture

* Parts of a CPU
	* ALU
	* Registers
	* Instruction decoder
	* Memory controller
	* Cache
* Program execution
	* Fetch-execute cycle
	* Clock
	* Branching
* I/O and interrupts
	* Interrupts
	* I/O
	* Buffers
	* Wait signals
* ISA
	* Instruction layouts
	* Fixed vs. variable length
	* Addressing modes
	* Branching instructions
	* Pseudo-instructions
	* SIMD instructions
* Multi-core
	* Instruction batching
	* Core specialization



# Memory

* Analog memory
	* Single channel
	* Dual channel and doublewords
	* Tag memory
* Loop memory
	* Loop core
	* Reading
	* Writing
	* Cache-based access
	* Center tag optimization 
* ROM
	* Emitter storage
	* Sackbot memory
* Caching
	* Cache lines
	* Data vs. instruction cache
	* Tag memory caching
	* Eviction policies
* Virtual memory
	* Memory-mapped I/O
	* Paging
	* Privileges



# Graphics

* Simple displays
	* Note readouts
	* 7-segment displays
	* Pixel displays
	* RGB
* Emitter-based displays
	* Pixel placement
	* Buffering and clearing
	* Object count limits
* Note-based displays
	* Note pixels
	* Multiple colors
	* Characters
* Vector graphics
	* Wire lines
	* Shapes
* Advanced GPU features
	* Sprites
	* Scrolling
* 3D Graphics
	* Vectors and matrices
	* Trigonometric operations
	* Rotations
	* Projections
	* Rendering a cube
* Display interfaces
	* Data encodings
	* Buffering



# Computer peripherals

* Keyboards
	* Keyboard designs
	* Input buffering
* Sound cards
	* Beeps
	* Melody sequences



# Existing CPU designs

* V8
	* Digital architecture
	* ISA
	* Twinbey
	* Software
* Parva
	* Analog architecture
	* v0.1
	* v0.2
	* ALU
	* Loop memory
	* Cache
	* Multiple cores
	* Branching
	* ISA
	* Software
* Bittzy
	* Mixed architecture
	* ISA
	* Software
* Other CPUs
	* Lodestar



# Computer software

* Assembly
	* Writing an assembler
	* Emulation
	* LittleBigComputer assembler
* Compilation
	* Writing a compiler
* Data transfer
	* Checksums
	* Twitch chatbot
	* Emulated DS4 controller
	* Level file editing
	* Memory manipulation
* Programming
	* If statements
	* Loops
	* The stack
	* Function calls
	* Bitmasks
	* Division with multiplication
	* Binary to decimal conversion
	* Simulated trigonometric operations
	* Memory allocation
	* Lookup tables
	* Hashmaps
	* File systems
* Optimization
	* Alignment
	* Cache locality
	* Instruction reordering
	* Loop unrolling



# Modding

* Memory manipulation
	* Cheat Engine
	* PINCE
* LBP tools
	* Toolkit
	* Zizhzingers
	* Save file decryption
* Reverse engineering
	* PowerPC
	* Ghidra



# Misc

* Other tutorials
	* LBPCentral Archive
	* YouTube
