"Everything is an object. Even numbers and true/false answer messages."
Transcript showCr: '3 class        -> ', 3 class printString.
Transcript showCr: '(3 > 2) class  -> ', (3 > 2) class printString.
Transcript showCr: 'nil class      -> ', nil class printString.
Transcript showCr: '3 + 4 * 2      -> ', (3 + 4 * 2) printString.
Transcript showCr: '100 factorial size -> ', 100 factorial printString size printString.

"if is not syntax: ifTrue:ifFalse: is a message sent to a Boolean"
(3 > 2)
    ifTrue: [Transcript showCr: '3 > 2 is true']
    ifFalse: [Transcript showCr: '3 > 2 is false'].
(1 to: 5) do: [:i |
    Transcript showCr: i printString, (i even ifTrue: [' even'] ifFalse: [' odd'])].
