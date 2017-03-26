%namespace M11J1

Ident							[a-zA-Z_][a-zA-Z0-9_]*
//Number						[0-9]+
OctalDigit						[0-7]
HexDigit						[0-9a-fA-F]
BinaryDigit						0|1
IntegerTypeSuffix				1|L
NonZeroDigit					[1-9]
Underscores						\_+

/* 3.10.1 DecimalIntegerLiteral */
Digit							0|{NonZeroDigit}
DigitOrUnderscore				{Digit}|{Underscores}
DigitsAndUnderscores			{DigitOrUnderscore}+
Digits							{Digit}|{Digit}{DigitsAndUnderscores}{Digit}
DecimalNumeral					0|{NonZeroDigit}{Digits}?|{NonZeroDigit}{Underscores}{Digits}
DecimalIntegerLiteral			{DecimalNumeral}{IntegerTypeSuffix}?

/* 3.10.1 HexIntegerLiteral */
HexDigitOrUnderscore			{HexDigit}|\_
HexDigitsAndUnderscores			{HexDigitOrUnderscore}+
HexDigits						{HexDigit}|{HexDigit}{HexDigitsAndUnderscores}?{HexDigit}
HexNumeral						0x{HexDigits}|0X{HexDigits}
HexIntegerLiteral				{HexNumeral}{IntegerTypeSuffix}?

/* 3.10.1 OctalIntegerLiteral */
OctalDigitOrUnderscore			{OctalDigit}|\_
OctalDigitsAndUnderscores		{OctalDigitOrUnderscore}+
OctalDigits						{OctalDigit}|{OctalDigit}{OctalDigitsAndUnderscores}?{OctalDigit}
OctalNumeral					0{OctalDigits}|0{Underscores}{OctalDigits}
OctalIntegerLiteral				{OctalNumeral}{IntegerTypeSuffix}?

/* 3.10.1 BinaryIntegerLiteral */
BinaryDigitOrUnderscore			{BinaryDigit}|\_
BinaryDigitsAndUnderscores		{BinaryDigitOrUnderscore}+
BinaryDigits					{BinaryDigit}|{BinaryDigit}{BinaryDigitsAndUnderscores}?{BinaryDigit}
BinaryNumeral					0b{BinaryDigits}|0B{BinaryDigits}
BinaryIntegerLiteral			{BinaryNumeral}{IntegerTypeSuffix}?

DotChar							[^\r\n]
EscapeSequence					\\[btnfr\"\'\\]
UnicodeEscape					\\u{HexDigit}{4}
OctalEscape						\\([1-3]{OctalDigit}{2}|{OctalDigit}{1,2})

CharacterLiteral				\'({EscapeSequence}|{OctalEscape}|{UnicodeEscape}|{DotChar})\'

// IntergerLiteral				\'({NonZeroDigit}|{Number})\' BAD CODE
IntergerLiteral					{DecimalIntegerLiteral}|{HexIntegerLiteral}|{OctalIntegerLiteral}|{BinaryIntegerLiteral}

%{
int lines = 0;
%}

%%

/* 3.9 Token -> Keywords */
/*  Tarandeep keywords */

abstract            { return (int)Tokens.Abstract; }
assert              { return (int)Tokens.Assert; }
boolean             { return (int)Tokens.Boolean; }
break              { return (int)Tokens.Break; }
byte               { return (int)Tokens.Byte; }
case               { return (int)Tokens.Case; }
catch              { return (int)Tokens.Catch; }
char               { return (int)Tokens.Char; }
class              { return (int)Tokens.Class; }
const              { return (int)Tokens.Const; }
continue           { return (int)Tokens.Continue; }
default            { return (int)Tokens.Default; }
do                 { return (int)Tokens.Do; }
double             { return (int)Tokens.Double; }
else               { return (int)Tokens.Else; }
enum               { return (int)Tokens.Enum; }
extends            { return (int)Tokens.Extends; }
final              { return (int)Tokens.Final; }
finally            { return (int)Tokens.Finally; }
float              { return (int)Tokens.Float; }
for                { return (int)Tokens.For; }
goto               { return (int)Tokens.Goto; }
if                 { return (int)Tokens.If; }
implements         { return (int)Tokens.Implements; }
import             { return (int)Tokens.Import; }
instanceof         { return (int)Tokens.Instanceof; }
int                { return (int)Tokens.Int; }
interface          { return (int)Tokens.Interface; }
long               { return (int)Tokens.Long; }
native             { return (int)Tokens.Native; }
new                { return (int)Tokens.New; }
package            { return (int)Tokens.Package; }
private            { return (int)Tokens.Private; }
protected          { return (int)Tokens.Protected; }
public             { return (int)Tokens.Public; }
return             { return (int)Tokens.Return; }
short              { return (int)Tokens.Short; }
static             { return (int)Tokens.Static; }
strictfp           { return (int)Tokens.Strictfp; }
super              { return (int)Tokens.Super; }
switch             { return (int)Tokens.Switch; }
synchronized       { return (int)Tokens.Synchronized; }
this               { return (int)Tokens.This; }
throw              { return (int)Tokens.Throw; }
throws             { return (int)Tokens.Throws; }
transient          { return (int)Tokens.Transient; }
try                { return (int)Tokens.Try; }
void               { return (int)Tokens.Void; }
volatile           { return (int)Tokens.Volatile; }
while              { return (int)Tokens.While; }      

/* 3.10 Token -> IntegerLiteral */
//{IntergerLiteral}				{ yylval.num = int.Parse(yytext); return (int)Tokens.IntergerLiteral; } BAD CODE
{IntergerLiteral}				{ yylval.name = yytext; return (int)Tokens.IntergerLiteral; }

/* 3.5 Token -> Character Literals */
{CharacterLiteral}				{ yylval.name = yytext; return (int)Tokens.CharacterLiteral; }

/* 3.5 Token -> Identifier  */
{Ident}							{ yylval.name = yytext; return (int)Tokens.Identifier; }

//{Number}						{ yylval.num = int.Parse(yytext); return (int)Tokens.Number; }


/* 3.5 InputElement -> Whitespace */
[\n]							{ lines++;    }
[ \t\r]							/* ignore other whitespace */

/* 3.5 InputElement -> Comments */
\/\*(.|\n)*\*\/					/* eliminates multi line comments*/
\/\/.*							/* eliminates single line comments*/

/*3.10.2. Floating-Point Literals*/

([-+]|(0[xX]))?[0-9a-fA-F]*\.?[0-9a-fA-F]+([eEpP]|[-+]?[0-9a-fA-F]+)?.              { yylval.name = yytext; return (int)Tokens.FloatingPointLiterals; }    


/* 3.11 Separators */

"(" 							{return '(';}
")" 							{return ')';}
"{" 							{return '{';}
"}" 							{return '}';}
"[" 							{return '[';}
"]" 							{return ']';}
";" 							{return ';';}
"," 							{return ',';}
"." 							{return '.';}
"..." 							{return (int)Tokens.VariableArguments;}
"@" 							{return '@';}
"::" 							{return (int)Tokens.DoubleColon;}

/* Mohammad Yousuf D Group*/
/*Operator (1/3)   =   >   <   !   ~   ?   :   -> ==  >=  <=  !=  &&  ||  ++  -- +  */

"=" 							{return '=';}//ASSIGN
"<"								{return '<';}   //LESS_THAN
">"								{return '>';}     //GREATER_THAN
"!"								{return '!';}    //LOGICAL_NOT
"~"								{return '~';}   //BITWISE_XOR
":"								{return ':';}    // COLON
"?"								{return '?';}    // 
"->"							{return (int)Tokens.SELECTION;}

"=="							{return (int)Tokens.EUQL_TO;}
">="							{return (int)Tokens.GREATER_THAN_OR_EQUAL_TO;}
"<="							{return (int)Tokens.LESS_THAN_OR_EUAL_TO;}
"!="							{return (int)Tokens.NOT_EQUAL_TO;}
"&&"							{return (int)Tokens.CONDITION_AND;}
"||"							{return (int)Tokens.CONDITION_OR;}
"++"							{return (int)Tokens.INCREMENT;}
"--" 							{return (int)Tokens.DECREMENT;}
"+" 							{return '+';} // ADDTION

/*Azad Kumar D Group*/
/* Operatpr (2/3) */
/* -   *   /   &   |   ^   %   <<   >>   >>>  +=  -=  *=  /=  &=  |= */


"-" 							{return '-';}  // SUBTRATION
"*" 							{return '*';}    // MULTIPLICATION
"/" 							{return '/';}    //DIVISION
"&" 							{return '&';}    //BITWISE_AND
"|" 							{return '|';}    //BITWISE_OR
"^" 							{return '^';}    //BITWISE_XOR
"%" 							{return '%';}    //MODULUS
"<<" 							{return (int)Tokens.SINGED_LEFT_SHIFT;}
">>" 							{return (int)Tokens.SINGED_RIGHT_SHIFT;}
">>>" 							{return (int)Tokens.UNSIGNED_RIGHT_SHFIT;}

"+=" 							{return (int)Tokens.ADD_AND;}
"-=" 							{return (int)Tokens.SUBTRACT_AND;}
"*=" 							{return (int)Tokens.MULTIPLY_AND;}
"/=" 							{return (int)Tokens.DIVIDE_AND;}
"&=" 							{return (int)Tokens.BITWISE_AND;}


/*BAEK, Hee Sook(Donna)(2/2) D Group * /
/*operator (3/3)*/
/* ^=  %=  <<=  >>=  >>>= */
"|=" 							{return (int)Tokens.BitwiseInclusiveOr;}
"^=" 							{return (int)Tokens.BitwiseExclusiveOr;}
"%="							{return (int)Tokens.ModulusAnd;}
"<<="							{return (int)Tokens.LeftShiftAnd;}
">>="							{return (int)Tokens.RightShiftAnd;}
">>>="							{return (int)Tokens.ShiftRightZeroFill;}

.								{
									throw new Exception(String.Format("unexpected character '{0}'", yytext));
								}



%%