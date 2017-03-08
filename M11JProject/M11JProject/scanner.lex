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

"="								{ return '='; }
"+"								{ return '+'; }
"<"								{ return '<'; }
"("								{ return '('; }
")"								{ return ')'; }
"{"								{ return '{'; }
"}"								{ return '}'; }
";"								{ return ';'; }

[ \r\n\t]						/* skip whitespace */

.								{
									throw new Exception(String.Format("unexpected character '{0}'", yytext));
								}

%%