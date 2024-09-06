# Gate behavior

This covers the basic mechanics of logic components in the game.

Note that this applies to LittleBigPlanet 3. The behavior in LBP2 and Vita is mostly the same but there are some important differences.



## Signal values

Wires in LBP hold values that consist of four distinct aspects: digital, analog, direction, and color.

### Digital

This is whether a signal is on or off. Digitally on wires visually appear lit up while off wires are dark.

### Analog

This is the "strength" of a signal. This can be represented as a percentage e.g. 50%, as is normally seen in-game, or as a decimal e.g. 0.5. These are both valid conventions and some people have a preference for one over the other. Just understand that 50% and 0.5 are the same thing.

In LittleBigPlanet 3, analog values are normally always restricted to being between -1 and 1. Internally, these are 32-bit [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754) floating point numbers. Note that the CPU architecture used by the PS3 is [big-endian](https://en.wikipedia.org/wiki/Endianness) so these values are stored as big-endian in the PS3's memory.

Analog values can be positive or negative, i.e. the value can be greater than 0 or less than 0. This is the analog sign of the signal value.

### Direction

Signal values can be forwards or backwards. An easy way to test the direction of a wire is by connecting it to direction splitter and seeing whether the positive or the negative output activates.

Direction only exists on digitally on signal values. Because of this, it is also possible to combine the digital and direction aspects of signal values are refer to them collectively as "ternary" with three possible values: forward, backward, and off.

Note that direction is distinct from analog sign. A wire with a positive analog value can be backwards, and a negative analog value can be fowards.

### Color

Note that this is _not_ visual color, i.e. the color a wire appears based on the color of the component or microchip the wire comes from.

Signal values may have an associated player color corresponding to one of the up to four players in the level. This color is determined by the activating player of the logic component, e.g. a button will output a signal with the color of the player who pressed the button.

It is very difficult to extract this information again after it has been stored in a wire so it is not very useful for logic.

[Video demonstrating color held in a signal](color1.mp4). The two sticker panels are set to use player color.

## AND, OR, XOR, NOT

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

### Not and inverting

NOT gates and any inverted gates destroy direction information; they always output a forwards direction.
There is no way to observe the direction of a digitally inactive signal, so effectively only active signals have a direction.

## Other components

### Direction combiner

In angleify mode, the output is effectively `atan2(top, bottom)` scaled to 100% instead of the usual 2π.

In combine mode, the output is `abs(top) - abs(bottom)`. The output is not capped to 100%.

### Memorizer

TODO

Idk how this works because I don't have the DLC.

## Microchips and sequencers

TODO

## Tags

TODO

## Unreleased gates

### Filter

The filter does not cap its output to 100%.

### Color tweaker

TODO

### Tag radar

TODO

Also don't have the DLC for this.


## Inf, NaN, and illegal values

### Inf

In LittleBigPlanet 2 it is possible to create signal values greater than 1 by repeatedly adding them together. This is because gates in this game do not cap their output between -1 and 1. If this is done repeatedly, a signal can be increased to a value of [infinity](https://en.wikipedia.org/wiki/IEEE_754#Infinities) (which shows up as `inf` on notes in LBP3).

To get these values into LBP3, create them in an LBP2 level and import them. If you don't have LBP2, you can hack these values into the game using [memory manipulation](/wiki/modding/memory-manipulation/README.md). Otherwise, if you are playing on RPCS3 you can use [this](inf_and_nan_level_lbp3.zip) level file. It also contains NaN.

### Direction combiner with inf

TODO

### NaN

TODO

### Subnormals

TODO

See https://en.wikipedia.org/wiki/IEEE_754#Subnormal_numbers

Subnormals are disabled on LBP3 on the PS4.

## Rounding errors

32-bit floating point numbers have finite precision and so there may be rounding after operations involving them. The classic example is that 0.1 + 0.2 = 0.30000000000000004 and not 0.3 as expected.


See [the Wikipedia article](https://en.wikipedia.org/wiki/Round-off_error) for more information or search "floating point rounding errors". There are lots of helpful videos and explanations online.

Understanding IEEE 754 rounding behavior is important for understanding [analog bitshifting](/wiki/computing-components/analog-conversions/README.md#analog-bitshifting). Floats in LittleBigPlanet uses the round-to-nearest rounding mode. This results in the following behavior, assuming Guard (G) is the last bit of the mantissa, and round and sticky (R, S) are the first two after the mantissa, with sticky being 1 if any following bits are 1.

```
GRS
X0X -> round down
11X -> round up
X11 -> round up
```

i.e. round up if `(R and (G or S))`

To avoid encountering rounding errors when handling analog values in LittleBigPlanet, the following tips may be helpful:

* When using notes to inspect values, always specify a maximum in the number format of the note that is a power of 2, e.g. use a note that goes up to 256, not one that goes up to 100.
* Don't use very small analog values, e.g. 2<sup>-50</sup>. When adding these to larger values, information will be lost.
* When scaling values, chain OR gates instead of using one large OR gate. For example, to multiply an analog value `x` by 8 you should do `OR(x, x) -> OR(previous, previous) -> OR(previous, previous)` instead of `OR(x, x, x, x, x, x, x, x)`. This is not always necessary though.

## Thermometer values

These values for thermometer usage for different objects are approximate and derived from testing in-game in LittleBigPlanet 3:

* Total limit: 1,000,000

* Basic logic component: 30 (This includes AND, OR, XOR, NOT, timer, counter, tag sensor, direction splitter/combiner, note)

* Tag: 10 (?)

* Microchip w/o sticker: 60

* Sequencer w/o sticker: 90 (?)

* Microchip/sequencer input/output: 5 (?)

* Normal gate input/output: 1

* Square object: 150
* Triangle object: 150

Wires are counted per used input/output, not per wire

Opening a microchip can increase thermometer usage while it is open.
In some cases, some of this increase is permanent even after you close the microchip again.

