"Hello, World! -- showCr: is a message sent to the Transcript object"
Transcript showCr: 'Hello, World!'.

"sum 1..10 with inject:into: -- the 0 sits in the middle of the message name"
| sum |
sum := (1 to: 10) inject: 0 into: [:a :b | a + b].
Transcript showCr: 'sum 1..10 = ', sum printString.
