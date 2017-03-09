%namespace M11JProject

digit [0-9]
letter [a-zA-Z]

%{
public string Foo()		// kevin test method
{
	return "super foo";
}
%}

%%

boolean							{ return (int)Tokens.BOOLEAN; }			// kevin's working on boolean token implement
true|false						{ yylval.val = yytext; return (int)Tokens.BOOLEANVALUE; }	// kevin's working on boolean token implement

{letter}({letter}|{digit})*		{ yylval.val = yytext; return (int)Tokens.IDENTIFIER; }
{digit}+						{ yylval.num = int.Parse(yytext); return (int)Tokens.NUMBER; }
/*E Group*/
/*Separator */
/*
(   )   {   }   [   ]   ;   ,   .   ...   @   ::
*/
/*
"="								{ return '='; }
"+"								{ return '+'; }
"<"								{ return '<'; }
"("								{ return '('; }
")"								{ return ')'; }
"{"								{ return '{'; }
"}"								{ return '}'; }
";"								{ return ';'; }
*/

"(" 		{return '(';}
")" 		{return ')';}
"{" 		{return '{';}
"}" 		{return '}';}
"[" 		{return '[';}
"]" 		{return ']';}
";" 		{return ';';}
"," 		{return ',';}
"." 		{return '.';}
"..." 		{return (int)Tokens.VARIABLE_ARGUMENTS;}
"@" 		{return '@';}
"::" 		{return (int)Tokens.DOUBLE_COLON;}


/*Operator*/
/* 38 
=   >   <   !   ~   ?   :   ->
==  >=  <=  !=  &&  ||  ++  --
*/

"=" 		{return '=';}//ASSIGN
"<"			{return '<';}   //LESS_THAN
">"			{return '>';}     //GREATER_THAN
"!"			{return '!';}    //LOGICAL_NOT
"~"			{return '~';}   //BITWISE_XOR
":"			{return ':';}    // COLON
"?"			{return '?';}    // 
"->"			{return (int)Tokens.SELECTION;}

"=="			{return (int)Tokens.EUQL_TO;}
">="			{return (int)Tokens.GREATER_THAN_OR_EQUAL_TO;}
"<="			{return (int)Tokens.LESS_THAN_OR_EUAL_TO;}
"!="			{return (int)Tokens.NOT_EQUAL_TO;}
"&&"			{return (int)Tokens.CONDITION_AND;}
"||"			{return (int)Tokens.CONDITION_OR;}
"++"			{return (int)Tokens.INCREMENT;}
"--" 			{return (int)Tokens.DECREMENT;}

/*
+   -   *   /   &   |   ^   %   <<   >>   >>>
+=  -=  *=  /=  &=  |=  ^=  %=  <<=  >>=  >>>=
*/

"+" 		{return '+';} // ADDTION
"-" 		{return '-';}  // SUBTRATION
"*" 		{return '*';}    // MULTIPLICATION
"/" 		{return '/';}    //DIVISION
"&" 		{return '&';}    //BITWISE_AND
"|" 		{return '|';}    //BITWISE_OR
"^" 		{return '^';}    //BITWISE_XOR
"%" 		{return '%';}    //MODULUS
"<<" 			{return (int)Tokens.SINGED_LEFT_SHIFT;}
">>" 			{return (int)Tokens.SINGED_RIGHT_SHIFT;}
">>>" 			{return (int)Tokens.UNSIGNED_RIGHT_SHFIT;}

"+=" 			{return (int)Tokens.ADD_AND;}
"-=" 			{return (int)Tokens.SUBTRACT_AND;}
"*=" 			{return (int)Tokens.MULTIPLY_AND;}
"/=" 			{return (int)Tokens.DIVIDE_AND;}
"&=" 			{return (int)Tokens.BITWISE_AND;}
"|=" 			{return (int)Tokens.BITWISE_INCLUSIVE_OR;}
"^=" 			{return (int)Tokens.BITWISE_EXCLUSIVE_OR;}
"%="			{return (int)Tokens.MODULUS_AND;}
"<<="			{return (int)Tokens.LEFT_SHIFT_AND;}
">>="			{return (int)Tokens.RIGHT_SHIFT_AND;}
">>>="			{return (int)Tokens.SHIFT_RIGHT_ZERO_FILL;}




[ \r\n\t]						/* skip whitespace */

.								{
									throw new Exception(String.Format("unexpected character '{0}'", yytext));
								}

%%