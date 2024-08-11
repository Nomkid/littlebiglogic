Table of contents:

This wiki is new and most of it is incomplete. Sections with links have content. Sections without links are not yet written. If you would like to request a section to be written then you can do so in the Discord server or by [creating an issue](https://github.com/hivemq/hivemq-policy-cookbooks/issues/new).

* Game mechanics
	* [Gate behavior](game-mechanics/gate-behavior/README.md)
		* [Signal values](game-mechanics/gate-behavior/README.md#signal-values)
		* [AND, OR, XOR, NOT](game-mechanics/gate-behavior/README.md#and-or-xor-not)
		* Other gates
		* Microchips and sequencers
		* Tags
		* [Inf, NaN, and illegal values](game-mechanics/gate-behavior/README.md#inf-nan-and-illegal-values)
		* [Rounding errors](game-mechanics/gate-behavior/README.md#rounding-errors)
		* [Thermometer values](game-mechanics/gate-behavior/README.md#thermometer-values)
	* [Frame updates](game-mechanics/frame-updates/README.md)
		* [Gate update order](game-mechanics/frame-updates/README.md)
		* Update phases
		* Specific gate priorities
	* Differences between games
		* LBP2
		* RPCS3

* Computing components
	* Analog value representations
		* IEEE 754
		* 2's complement
		* Notes and readouts
		* Word sizes
		* Fixed point
		* 16-bit IEEE 754
	* [Analog conversions](computing-components/analog-conversions/README.md)
		* Digital to analog combiner/encoder
		* [Pure analog splitter/decoder](/wiki/computing-components/analog-conversions/README.md#pure-analog-splitterdecoder)
		* Basic analog to digital splitter/decoder
		* [2-gate analog to digital splitter/decoder](computing-components/analog-conversions/README.md#-2-gate-analog-to-digital-splitterdecoder)
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
		* Subtracting division
		* Newton-Raphson division
		* Arctan division
	* Control flow
		* Encoders and decoders
		* Multiplexers
		* F-Relay
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
		* Controlled pulses
		* Signal probe
		* Timelines
		* Screen recordings

* Computer architecture
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

* Memory
	* Analog memory
		* Single channel
		* Dual channel and double-words
		* Byte packing
	* [Tag memory](/wiki/memory/tag-memory/README.md)
		* [Tag memory core](/wiki/memory/tag-memory/README.md#tag-memory-core)
		* Reader
		* Writer
	* [Loop memory](memory/loop-memory/README.md)
		* [Loop core](memory/loop-memory/README.md#loop-core)
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

* Graphics
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

* Computer peripherals
	* Keyboards
		* Keyboard designs
		* Input buffering
	* Sound cards
		* Beeps
		* Melody sequences

* Existing CPU designs
	* V8
		* Digital architecture
		* ISA
		* Twinbey
		* Software
	* [Parva](/wiki/existing-cpu-designs/parva/README.md)
		* Analog architecture
		* [v0.1](/wiki/existing-cpu-designs/parva/README.md#v01)
		* [v0.2](/wiki/existing-cpu-designs/parva/README.md#v02)
		* ALU
		* Loop memory
		* Cache
		* Multiple cores
		* Branching
		* ISA
		* Software
	* Bitzzy
		* Mixed architecture
		* ISA
		* Software
	* Other CPUs
		* Lodestar

* Computer software
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

* Modding
	* [Memory manipulation](modding/memory-manipulation/README.md)
		* [Cheat Engine](modding/memory-manipulation/README.md#cheat-engine)
		* [PINCE](https://github.com/korcankaraokcu/PINCE)
	* LBP tools
		* [Toolkit](https://github.com/ennuo/toolkit)
		* [Zishzingers](https://github.com/Beyley/zishzingers)
		* Save file decryption
	* Reverse engineering
		* PowerPC
		* Ghidra

* Misc
	* Other tutorials
		* [LBPCentral Archive](https://lbpcentral.lbp-hub.com/)
		* YouTube
	* [Glossary](misc/glossary/README.md)
