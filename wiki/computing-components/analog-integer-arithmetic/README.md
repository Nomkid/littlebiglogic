# Analog integer arithmetic

## Addition and subtraction

TODO

An analog adder with support for overflow using a Holy Cow converter:

![image](adder1.png)

The input order on the blue OR gate is important.

## Comparisons

### Basic analog equality

A circuit to check for equality between two analog signals:

![image](eq2.png)

The pink OR gate is in max value mode. The other OR gates are in add mode. The AND gate is in add mode. This will work for positive and negative analog values. It will output an analog value of 100% if the values are equal, 0% otherwise.

### Inf direction combiner equality

A more efficient equality checker can be built with a [Holy Cow converter](/wiki/computing-components/analog-conversions/README.md#holy-cow-converter).

![image](eq1.png)

The pink direction combiner is in angleify mode, the others in combine mode. It will output a digitally on signal with an analog value of 100% if the values are equal, 0% and digitally off otherwise.

## Multiplication

TODO

## Division

16-bit analog divider:

![image](div1.png)

The top output is the quotient. The bottom output is the remainder. This design can be adapted for any word size up to 24 bits. Ensure the AND gate with the battery at the bottom is outputting a value of 1 for the word size you're using. In this example, the word size is 16 bits so a value of 2<sup>-16</sup> is needed, which is equal to 0.25<sup>8</sup> hence the 8 inputs into the AND gate.

A more efficient design could be built using Holy Cow converters.

## Arbitrary bitshifting

TODO

24-bit analog bitshifter:

![image](bitshifter1.png)
![image](bitshifter2.png)

Orange batteries are -50%, red -100%, blue 50%.

If you have access to values >100% then the shifting microchips can be replaced with direct multiplication and the 5-bit splitter can be replaced with one using Holy Cow converters.
