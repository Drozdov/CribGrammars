/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar CribLine;

lines: line+;

line: bars (':'|'.')? instructions;

bars: IntegerLiteral (Hyphen IntegerLiteral)?;

instructions: instruction (Punkt|delimiter instructions)?;

instruction: subjects predicates;

subjects : subject (delimiter subjects)?;

subject : dancers;

dancers : dancer (Plus dancers)?;

dancer: Dancer OpenBracket StringLiteral CloseBracket;

delimiter : Comma | And | Punkt;

ordinal : First | Second | Third | Fourth | Fifth | Sixth;

place : ordinal Place;

corner : ordinal corner;

multiplier : IntegerLiteral? (IntegerLiteral Slash IntegerLiteral)?;

// predicates definitions start here
predicates : predicate (delimiter predicates)? ;

predicate : simplePred addition*;

simplePred: Dance figure?
          | Cross Hand?
          | Cast
          | Lead
          | Turn Hand?
          ;

figure : multiplier Figure OpenBracket StringLiteral CloseBracket;

addition: To place
        | To Face (dancers | corner)
        | upDown
        | (Between | Round) dancers
        ;

upDown : Up | Down;


// Lexer
Hyphen : '-' ;

Plus : '+';

And : A N D | '&';

Between : B E T W E E N;

Round : R O U N D;

Dancer : D A N C E R;

Figure : F I G U R E;

Dance : D A N C E;

Cross : C R O S S;

Cast: C A S T;

Hand: R H | L H;

To : T O;

Face: F A C E;

Place: P L A C E;

Corner: C O R N E R;

Up : U P;

Down : D O W N;

Lead : L E A D;

Turn : T U R N;

First : F I R S T | '1st';
Second : S E C O N D  | '2nd';
Third : T H I R D | '3rd';
Fourth : F O U R T H | '4th';
Fifth : F I F T H | '5th';
Sixth : S I X T H | '6th';

CharacterLiteral :  '\'' (PrintableChar | CharEscapeSeq) '\'';
StringLiteral    :  '"' StringElement* '"'
                 |  '"""' MultiLineChars '"""';

IntegerLiteral   :  (DecimalNumeral | HexNumeral) ('L' | 'l')?;

Comment          :  ('/*' .*?  '*/' |  '//' .*? '\n'?) -> skip;

Comma : ',';
Punkt : '.';
Semicolon : ';';
Colon : ':';
OpenBracket : '(';
CloseBracket : ')';
OpenBrace : '{';
CloseBrace : '}';
Slash : '/';

UnparsedWord : Letter+ -> skip;
WS  : [ \t\r\n]+ -> skip ;

// fragments

fragment UnicodeEscape    :	'\\' 'u' 'u'? HexDigit HexDigit HexDigit HexDigit ;
fragment WhiteSpace       :  '\u0020' | '\u0009' | '\u000D' | '\u000A';
fragment Opchar           : PrintableChar // printableChar not matched by (whiteSpace | upper | lower |
                          // letter | digit | paren | delim | opchar | Unicode_Sm | Unicode_So)
                          ;
fragment Op               :  Opchar+;

fragment Idrest           :  (Letter | Digit)* ('_' Op)?;

fragment StringElement    :  '\u0020'| '\u0021'|'\u0023' .. '\u007F'  // (PrintableChar  Except '"')
                          |  CharEscapeSeq;
fragment MultiLineChars   :  ('"'? '"'? .*?)* '"'*;

fragment HexDigit         :  '0' .. '9'  |  'A' .. 'Z'  |  'a' .. 'z' ;
fragment FloatType        :  'F' | 'f' | 'D' | 'd';
fragment Upper            :  'A'  ..  'Z' | '$' | '_';  // and Unicode category Lu
fragment Lower            :  'a' .. 'z'; // and Unicode category Ll
fragment Letter           :  Upper | Lower; // and Unicode categories Lo, Lt, Nl
fragment ExponentPart     :  ('E' | 'e') ('+' | '-')? Digit+;
fragment PrintableChar    : '\u0020' .. '\u007F' ;
fragment CharEscapeSeq    : '\\' ('b' | 't' | 'n' | 'f' | 'r' | '"' | '\'' | '\\');
fragment DecimalNumeral   :  '0' | NonZeroDigit Digit*;
fragment HexNumeral       :  '0' 'x' HexDigit HexDigit+;
fragment Digit            :  '0' | NonZeroDigit;
fragment NonZeroDigit     :  '1' .. '9';

fragment A : 'A' | 'a';
fragment B : 'B' | 'b';
fragment C : 'C' | 'c';
fragment D : 'D' | 'd';
fragment E : 'E' | 'e';
fragment F : 'F' | 'f';
fragment G : 'G' | 'g';
fragment H : 'H' | 'h';
fragment I : 'I' | 'i';
fragment J : 'J' | 'j';
fragment K : 'K' | 'k';
fragment L : 'L' | 'l';
fragment M : 'M' | 'm';
fragment N : 'N' | 'n';
fragment O : 'O' | 'o';
fragment P : 'P' | 'p';
fragment Q : 'Q' | 'q';
fragment R : 'R' | 'r';
fragment S : 'S' | 's';
fragment T : 'T' | 't';
fragment U : 'U' | 'u';
fragment V : 'V' | 'v';
fragment W : 'W' | 'w';
fragment X : 'X' | 'x';
fragment Y : 'Y' | 'y';
fragment Z : 'Z' | 'z';
