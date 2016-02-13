grammar CribNative;

start : startNative startDance;

startNative: Native;

startDance: Dance OpenBracket danceParams? CloseBracket
            OpenBrace instructions CloseBrace;

danceParams : danceParam ';' danceParams?;

danceParam : ID ':' paramValues;

paramValues : paramValue (',' paramValues)?;

paramValue : StringLiteral | Hyphen? IntegerLiteral |
             Hyphen? FloatingPointLiteral | cortege;

cortege : OpenBracket paramValues CloseBracket;

instructions : instruction ';' instructions?;

instruction : bars ':' simpleInstructions;

bars : IntegerLiteral (Hyphen IntegerLiteral)? ;

simpleInstructions : simpleInstruction (',' simpleInstructions)?;

simpleInstruction : stepId '(' paramValues ')' ;

stepId           :  Set | Sch | Sud | Step // step
                        | Circ | Ell | Mv // move
                        | Dir | Nrot | Rot // rotation
                        | Hds // others
                 ;

// Lexer
Hyphen : '-' ;

CharacterLiteral :  '\'' (PrintableChar | CharEscapeSeq) '\'';
StringLiteral    :  '"' StringElement* '"'
                 |  '"""' MultiLineChars '"""';
IntegerLiteral   :  (DecimalNumeral | HexNumeral) ('L' | 'l')?;

FloatingPointLiteral 
                 :  Digit+ '.' Digit+ ExponentPart? FloatType?
                 |  '.' Digit+ ExponentPart? FloatType?
                 |  Digit ExponentPart FloatType?
                 |  Digit+ ExponentPart? FloatType;

Comment          :  ('/*' .*?  '*/' |  '//' .*? '\n'?) -> skip;
Sign             :  '+' | '-';

Comma : ',';
Semicolon : ';';
Colon : ':';
OpenBracket : '(';
CloseBracket : ')';
OpenBrace : '{';
CloseBrace : '}';


Native :         'native';
Dance :          'dance';

Set :            'set';
Sch :            'sch';
Sud :            'sud';
Step :           'step';
Circ :           'circ';
Ell :            'ell';
Mv :             'mv';
Dir :            'dir';
Nrot :           'nrot';
Rot :            'rot';
Hds :            'hds';

ID  : [a-z]+ ;
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