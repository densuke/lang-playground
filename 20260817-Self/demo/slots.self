"An object is a list of slots between vertical bars.
 x <- ... is an assignable slot, y = ... is a read-only slot."
lobby _AddSlots: (| p = (| x <- 3 + 4. y = 5 |) |).

p x printLine.
p y printLine.

"x <- also makes a setter message named x:"
p x: 10.
p x printLine.

"y = does not. Ask the object's mirror which slots it has."
((reflect: p) includesKey: 'x:') printLine.
((reflect: p) includesKey: 'y:') printLine.
_Quit
