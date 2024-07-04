# LittleBigLogic

This readme is currently just a dump of what is in a private discord server. Hopefully this whole repo will be improved upon in time.

## Basic logic gate behavior

### Signal values

Signals have four components: digital, analog, direction, and color.

NOT gates and any inverted gates destroy direction information; they always output a forwards direction.
There is no way to observe the direction of a digitally inactive signal, so effectively only active signals have a direction.
In the basic gates (AND, NOT, OR, XOR), analog values do not influence digital and direction values in any way.

Color is determined by the activating player, e.g. the player that presses a button to enable the signal. It is difficult to extract this information again after it has been stored in a wire so it is not very useful and will be ignored here.

Analog values are internally represented as 32-bit floating point numbers.
Rounding is done by round to nearest, tie to even (standard float rounding).
Guard (G) is the last bit of the mantissa. Round and sticky (R, S) are the first two after the mantissa, with sticky being 1 if any following bits are 1.
Most explanations of floating point rounding online overcomplicate things, but this table is correct:

GRS
X0X -> round down
11X -> round up
X11 -> round up

i.e. round up if (R and (G or S))

In LittleBigPlanet 3, values are capped between -100% and 100%. In LittleBigPlanet 2 they can extend beyond this range.

### XOR

When one or zero digital inputs are active, the analog output is the analog input with the higher absolute value (same as OR in maximum mode)
When both digital inputs are active, the analog output is zero.
The output direction is the same as the single active input value.

### AND

When in minimum value mode, the lowest non-absolute value will be used, i.e. the value farthest from +100%.
The output direction is backwards if the number of backwards inputs is odd, forwards if even.

### OR

In maximum value mode, the output direction is that of the first active input.
In maximum value mode, the analog output is the analog input with the higher absolute value. If equal, the topmost input is used.
In maximum value mode, the output is active if any input is active.
In add mode, the output direction is that of the last active input.
In add mode with two active inputs, the output is inactive if the input directions are different.
In add mode with more than two inputs, the output is calculated by cascading inputs from top to bottom. First the first two inputs are calculated, then the output of that is used with the third input and so on.
When adding three or more analog inputs, saturation is only done at the end. An intermediate +100% and -100% will not saturate the result for example.

## Thermometer

These values for thermometer usage for different objects are approximate and derived from testing in-game in LittleBigPlanet 3:

Total limit: 1,000,000

Basic logic component: 30
This includes AND, OR, XOR, NOT, timer, counter, tag sensor, direction splitter/combiner, note

Tag: 10 (?)

Microchip w/o sticker: 60

Sequencer w/o sticker: 90 (?)

Microchip/sequencer input/output: 5 (?)

Normal gate input/output: 1

Wires are counted per used input/output, not per wire

Square object: 150
Triangle object: 150

Opening a microchip can increase thermometer usage while it is open.
In some cases, some of this increase is permanent even after you close the microchip again.

## Loop memory

### Looping

This is a tutorial for creating highly efficient loop memory, capable of storing over 100kB in a level.

Normally when microchips are connected together directly, values pass through them instantly:
![alt text](https://cdn.discordapp.com/attachments/1181905784498565140/1181906080457052220/loop1.mov?ex=6687cbd0&is=66867a50&hm=6c4b00a9474a4d159a6bd66886a4ef4f40be1f0eaa6a12e07a00dd66dc7ebbdf&)

But if you wire at least one input from each microchip in the series into the microchip that comes before it, then a delay is introduced. Here, each microchip output is connected to a red gate in the microchip to the left of it:
![alt text](https://cdn.discordapp.com/attachments/1181905784498565140/1181906449929097276/loop2.mov?ex=6687cc28&is=66867aa8&hm=78a9839ef604bdab1e2f86f5df92e518db5e3af97adf6489f21033149e2d851f&)

**Important:** all the gates and microchips _must_ be created in the order of left-to-right, otherwise the delay won't work. If sections of your loop are instant when they should have a delay, try re-placing everything in the correct order. What matters is the creation order. Moving or re-wiring gates doesn't affect this.

You can then connect the final microchip in a loop back to the first microchip, creating an endless cycle where signal values will be trapped.
![alt text](https://cdn.discordapp.com/attachments/1181905784498565140/1181907674774917211/loop3.mov?ex=6687cd4c&is=66867bcc&hm=5675eca107e3985f5c99602550ec42a7dae7600784d3a89aed4e97aec7a33296&)

It is technically possible to close the loop directly with wires as above, but I **strongly recommend** using tags as shown below instead:
![alt text](https://cdn.discordapp.com/attachments/1181905784498565140/1181907883252789380/loop4.mov?ex=6687cd7e&is=66867bfe&hm=d3a536ad39fa81a39ab93036e816262718a5b9f48203f20f77dc4ecaf974df10&)

The reason for this is that it allows much easier reading and writing of the values. The placement order requirement extends to all gates that are connected in any way to the loop, so creating connections at the start and the end of your loop for reading/writing can easily break it and it's very hard to debug and fix. Tags fix this by completely isolating the circuit so that you don't need to worry about placement order anymore.
Instead of having a single data value passing through each microchip, you can have multiple. Only one connection is needed from each microchip into the red gate of the previous microchip. Color or label the tags differently so that they don't interfere:
![alt text](https://cdn.discordapp.com/attachments/1181905784498565140/1181908904897171496/loop5.mov?ex=6687ce71&is=66867cf1&hm=9d3f638f0142d209fc7271cf4857d04ea996eb163ba9cac454a890305726dec6&)

Finally, it is possible to remove all of the relay gates and connect microchips to each other directly. You can remove the microchip stickers too:
![alt text](https://cdn.discordapp.com/attachments/1181905784498565140/1181909767736791080/loop6.mov?ex=6687cf3f&is=66867dbf&hm=bdd951bcbd23e767252499df1cbbcdb0b3e2046a50c1a9ab615c1daab333366e&)

A memory loop is defined by two characteristics: the number of values per microchip, and the number of microchips per loop. In this example there are 3 values per microchip and 7 microchips per loop.
Each value per microchip consumes about 10 thermometer points, while each microchip (including its connection back to the previous microchip) consumes about 65 thermometer points. Each tag/tag sensor pair consumes about 40 thermometer points.
The more values per microchip, the more efficient the memory. I usually use 16 values per microchip.
The more microchips per loop, the more efficient the design as well, but also the higher the latency for writing. In this example, it may take up to 7 frames to write a value to the loop because you need to wait for it to cycle around to the correct position.

### Reading and writing

TODO
