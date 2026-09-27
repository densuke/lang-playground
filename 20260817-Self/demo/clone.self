"No classes. Make a prototype, then copy it."
lobby _AddSlots: (| counter = (|
    parent* = traits clonable.
    count <- 0.
    increment = (count: count + 1. self)
|) |).
lobby _AddSlots: (| a. b |).

a: counter copy.
b: counter copy.
a increment increment increment.
b increment.

a count printLine.
b count printLine.
counter count printLine.

"Add a slot to just one object while the program runs."
a _AddSlots: (| name <- 'only a has a name' |).
a name printLine.
((reflect: b) includesKey: 'name') printLine.
_Quit
