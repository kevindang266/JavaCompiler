%namespace GPLexTutorial

digit [0-9]
letter [a-zA-Z]

%%

if                           { return (int)Tokens.IF; }
else                         { return (int)Tokens.ELSE; }
int                          { return (int)Tokens.INT; }
bool                         { return (int)Tokens.BOOL; }

{letter}({letter}|{digit})* { yylval.name = yytext; return (int)Tokens.IDENT; }

{digit}+	    { yylval.num = int.Parse(yytext); return (int)Tokens.NUMBER; }



"="                          { return '='; }
"+"                          { return '+'; }
"<"                          { return '<'; }
"("                          { return '('; }
")"                          { return ')'; }
"{"                          { return '{'; }
"}"                          { return '}'; }
";"                          { return ';'; }

[ \r\n\t]                    /* skip whitespace */



"//".*										/* skip single line comment */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/].		/* skip multiline comment */


.                            { 
                                 throw new Exception(
                                     String.Format(
                                         "unexpected character '{0}'", yytext)); 
                             }

							
%%



JavaDigit	[0-9]
JavaLetter	[a-zA-Z_$]*



/* 3.8. Identifier */

Identifier:
	{JavaLetter}{JavaDigit}

//IdentifierChars:
		//JavaLetter {JavaLetterOrDigit}
		//JavaLetter {JavaLettereOrDigit}*
	//	{JavaLetter}*{JavaDigit}?

//JavaLetter:
		//{JavaLetter}

//JavaLetterOrDigit:
	//	{JavaLetter}|{JavaDigit}