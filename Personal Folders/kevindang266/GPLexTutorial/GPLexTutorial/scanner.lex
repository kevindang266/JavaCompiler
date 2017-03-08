%namespace GPLexTutorial

digit [0-9]
letter [a-zA-Z]

%{
public string Foo() 
{
	return "super foo";
}
%}

%%

if                           { return (int)Tokens.IF; }
else                         { return (int)Tokens.ELSE; }
int                          { return (int)Tokens.INT; }
bool                         { return (int)Tokens.BOOL; }
true|false					 { yylval.bval = bool.Parse(yytext); return (int)Tokens.BOOLVAL; }
null						 { return (int)Tokens.NULL; }

'[a-zA-Z0-9]'				 { 
								var c = char.Parse(yytext.Replace("'",""));
								yylval.name = c.ToString(); 
								return (int)Tokens.CHAR; 
							 }

{letter}({letter}|{digit})*  { yylval.name = yytext; return (int)Tokens.IDENT; }
{digit}+	                 { yylval.num = int.Parse(yytext); return (int)Tokens.NUMBER; }

"="                          { return '='; }
"+"                          { return '+'; }
"<"                          { return '<'; }
"("                          { return '('; }
")"                          { return ')'; }
"{"                          { return '{'; }
"}"                          { return '}'; }
";"                          { return ';'; }

[ \r\n\t]                    /* skip whitespace */

.                            { 

                                 throw new Exception(
                                     String.Format(
                                         "unexpected character '{0}'", yytext)); 
                             }

%%
