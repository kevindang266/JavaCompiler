%namespace M11J1

digit [0-9]
letter [a-zA-Z]

%%

boolean							{ return (int)Tokens.BOOLEAN; }			// Trung Kien Dang - Boolean Literal
/* Vinay and Tarandeep keywords */
if                  {yylval.keyword = yytext; return (int)Tokens.KEYWORDS;}
else                {yylval.keyword = yytext; return (int)Tokens.KEYWORDS;}
int                 {yylval.keyword = yytext; return (int)Tokens.KEYWORDS;}
for                 {yylval.keyword = yytext; return (int)Tokens.KEYWORDS;}
while               {yylval.keyword = yytext; return (int)Tokens.KEYWORDS;}

/*BAEK, Hee Sook(Donna)(1/2) D Group * /
/*Separator  (   )   {   }   [   ]   ;   ,   .   ...   @   ::*/

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
"|=" 		{return (int)Tokens.BITWISE_INCLUSIVE_OR;}
"^=" 		{return (int)Tokens.BITWISE_EXCLUSIVE_OR;}
"%="		{return (int)Tokens.MODULUS_AND;}
"<<="		{return (int)Tokens.LEFT_SHIFT_AND;}
">>="		{return (int)Tokens.RIGHT_SHIFT_AND;}
">>>="		{return (int)Tokens.SHIFT_RIGHT_ZERO_FILL;}

.			{
								throw new Exception(String.Format("unexpected character '{0}'", yytext));
			}



%%