KatalDesktop
============

OS X desktop app spike experimenting around the notions of Katal, based around constructor theory as applied to software development.


[≫]}{('HELLO')}{[Console]}{[String.upperCase]}{[Console]}{[≪]



[ = transformer.begin
] = transformer.end


Rule: Transformer { // (Character)->State
    // (Character) --> [return perform(Character)] --> State
}


nextCharacterShouldBe("≫")

(String, REP.State) --> REP.parse --> (String, REP.State)
("[", .parseBegin) --> REP.parse --> ("[", .parsing)


(String, Catalyst.State) --> Catalyst.parse --> (String, Catalyst.State)
("[", .parseBegin) --> Catalyst.parse --> ("[", .parsing)