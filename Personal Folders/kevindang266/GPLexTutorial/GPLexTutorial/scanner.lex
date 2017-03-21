%namespace GPLexTutorial

Ident				[a-zA-Z_][a-zA-Z0-9_]*
Number				[0-9]+
OctDig				[0-7]
HexDig				[0-9a-fA-F]

StrChs				[^\\\"\a\b\f\n\r\t\v\0]
EscapeSequence		\\[btnfr\"\'\\]
UnicodeEscape       \\u{HexDig}{4}
OctalEscape			\\([1-3]{OctDig}{2}|{OctDig}{1,2})

CharacterLiteral    \'({EscapeSequence}|{OctalEscape}|{UnicodeEscape})\'

%{
int lines = 0;
%}


%%

if								{ return (int)Tokens.If; }
else							{ return (int)Tokens.Else; }
int								{ return (int)Tokens.Int; }
bool							{ return (int)Tokens.Boolean; } 
true|false						{ return (int)Tokens.BooleanLiteral; }
null							{ return (int)Tokens.NullLiteral;}
{CharacterLiteral}				{ yylval.name = yytext; return (int)Tokens.CharacterLiteral; }

{Ident}							{ yylval.name = yytext; return (int)Tokens.Identifier; }
{Number}+						{ yylval.num = int.Parse(yytext); return (int)Tokens.Number; }

"="								{ return '='; }
"+"								{ return '+'; }
"<"								{ return '<'; }
"("								{ return '('; }
")"								{ return ')'; }
"{"								{ return '{'; }
"}"								{ return '}'; }
";"								{ return ';'; }

[\n]							{ lines++;    }
[ \t\r]							/* ignore other whitespace */

.	                            { 

									 throw new Exception(
										 String.Format(
											 "unexpected character '{0}'", yytext)); 
								 }
%%

public override void yyerror( string format, params object[] args )
{
    System.Console.Error.WriteLine("Error: line {0}, {1}", lines,
        String.Format(format, args));
}