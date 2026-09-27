"Define a class by sending messages, then send messages to its instances"
Object subclass: Account [
    | balance |
    init [ balance := 0 ]
    balance [ ^balance ]
    deposit: amount [ balance := balance + amount ]
]

Account class extend [ new [ ^super new init ] ].

| a |
a := Account new.
a deposit: 100; deposit: 50.
Transcript showCr: 'balance = ', a balance printString.
Transcript showCr: 'responds to deposit:? ', (a respondsTo: #deposit:) printString.
Transcript showCr: 'responds to fly?      ', (a respondsTo: #fly) printString.
