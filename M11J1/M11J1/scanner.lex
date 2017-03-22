%namespace M11J1

Ident				[a-zA-Z_][a-zA-Z0-9_]*
Number				[0-9]+
OctalDigit			[0-7]
HexDigit			[0-9a-fA-F]
NonZeroDigit		[1-9]+

DotChar				[^\r\n]
EscapeSequence		\\[btnfr\"\'\\]
UnicodeEscape       \\u{HexDigit}{4}
OctalEscape			\\([1-3]{OctalDigit}{2}|{OctalDigit}{1,2})

CharacterLiteral    \'({EscapeSequence}|{OctalEscape}|{UnicodeEscape}|{DotChar})\'

IntergerLiteral		\'({NonZeroDigit}|{Number})\'

%{
int lines = 0;
%}

%%

/* 3.9 Token -> Keywords */
if								{ yylval.keyword = yytext; return (int)Tokens.Keywords; }
else							{ yylval.keyword = yytext; return (int)Tokens.Else; }
int								{ yylval.keyword = yytext; return (int)Tokens.Int; }
boolean                         { yylval.keyword = yytext; return (int)Tokens.Boolean; } 
public							{ yylval.keyword = yytext; return (int)Tokens.Public; }
class							{ yylval.keyword = yytext; return (int)Tokens.Class; }
static							{ yylval.keyword = yytext; return (int)Tokens.Static; }
void							{ yylval.keyword = yytext; return (int)Tokens.Void; }
extends							{ yylval.keyword = yytext; return (int)Tokens.Extends; }
implements						{ yylval.keyword = yytext; return (int)Tokens.Implements; }
final							{ yylval.keyword = yytext; return (int)Tokens.Final; }

/* 3.10 Token -> IntegerLiteral */
{IntergerLiteral}				{ yylval.num = int.Parse(yytext); return (int)Tokens.IntergerLiteral; }

/* 3.5 Token -> Character Literals */
{CharacterLiteral}				{ yylval.name = yytext; return (int)Tokens.CharacterLiteral; }

/* 3.5 Token -> Identifier  */
{Ident}							{ yylval.name = yytext; return (int)Tokens.Identifier; }

{Number}						{ yylval.num = int.Parse(yytext); return (int)Tokens.Number; }


/* 3.5 InputElement -> Whitespace */
[\n]							{ lines++;    }
[ \t\r]							/* ignore other whitespace */

/* 3.5 InputElement -> Comments */
\/\*(.|\n)*\*\/					/* eliminates multi line comments*/
\/\/.*							/* eliminates single line comments*/



/* 3.11 Separators * /

"(" 		{return '(';}
")" 		{return ')';}
"{" 		{return '{';}
"}" 		{return '}';}
"[" 		{return '[';}
"]" 		{return ']';}
";" 		{return ';';}
"," 		{return ',';}
"." 		{return '.';}
"..." 		{return (int)Tokens.VariableArguments;}
"@" 		{return '@';}
"::" 		{return (int)Tokens.DoubleColon;}

/* Mohammad Yousuf D Group*/
/*Operator (1/3)   =   >   <   !   ~   ?   :   -> ==  >=  <=  !=  &&  ||  ++  -- +  */

"=" 		{return '=';}//ASSIGN
"<"			{return '<';}   //LESS_THAN
">"			{return '>';}     //GREATER_THAN
"!"			{return '!';}    //LOGICAL_NOT
"~"			{return '~';}   //BITWISE_XOR
":"			{return ':';}    // COLON
"?"			{return '?';}    // 
"->"		{return (int)Tokens.SELECTION;}

"=="		{return (int)Tokens.EUQL_TO;}
">="		{return (int)Tokens.GREATER_THAN_OR_EQUAL_TO;}
"<="		{return (int)Tokens.LESS_THAN_OR_EUAL_TO;}
"!="		{return (int)Tokens.NOT_EQUAL_TO;}
"&&"		{return (int)Tokens.CONDITION_AND;}
"||"		{return (int)Tokens.CONDITION_OR;}
"++"		{return (int)Tokens.INCREMENT;}
"--" 		{return (int)Tokens.DECREMENT;}
"+" 		{return '+';} // ADDTION

/*Azad Kumar D Group*/
/* Operatpr (2/3) */
/* -   *   /   &   |   ^   %   <<   >>   >>>  +=  -=  *=  /=  &=  |= */


"-" 		{return '-';}  // SUBTRATION
"*" 		{return '*';}    // MULTIPLICATION
"/" 		{return '/';}    //DIVISION
"&" 		{return '&';}    //BITWISE_AND
"|" 		{return '|';}    //BITWISE_OR
"^" 		{return '^';}    //BITWISE_XOR
"%" 		{return '%';}    //MODULUS
"<<" 		{return (int)Tokens.SINGED_LEFT_SHIFT;}
">>" 		{return (int)Tokens.SINGED_RIGHT_SHIFT;}
">>>" 		{return (int)Tokens.UNSIGNED_RIGHT_SHFIT;}

"+=" 		{return (int)Tokens.ADD_AND;}
"-=" 		{return (int)Tokens.SUBTRACT_AND;}
"*=" 		{return (int)Tokens.MULTIPLY_AND;}
"/=" 		{return (int)Tokens.DIVIDE_AND;}
"&=" 		{return (int)Tokens.BITWISE_AND;}


/*BAEK, Hee Sook(Donna)(2/2) D Group * /
/*operator (3/3)*/
/* ^=  %=  <<=  >>=  >>>= */
"|=" 		{return (int)Tokens.BitwiseInclusiveOr;}
"^=" 		{return (int)Tokens.BitwiseExclusiveOr;}
"%="		{return (int)Tokens.ModulusAnd;}
"<<="		{return (int)Tokens.LeftShiftAnd;}
">>="		{return (int)Tokens.RightShiftAnd;}
">>>="		{return (int)Tokens.ShiftRightZeroFill;}
.			{
								throw new Exception(String.Format("unexpected character '{0}'", yytext));
			}



%%