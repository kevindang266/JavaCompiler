%using M11J1.Parser;
%namespace M11J1.Lexer

%visibility public

Eol             (\r\n?|\n)
NotWh           [^ \t\r\n]
Space           [ \t]
Digit			[0-9]
Letter 			[a-zA-Z]
Identifier		\$([a-zA-Z]([a-zA-Z0-9_])*)
IntegerLiteral	{Digit}+
BooleanLiteral	(true|false)
System			system
Out				out
Println			println
Import			import
Public      	public
Static      	static
Final			final
Abstract		abstract
Strictfp		strictfp
Private			private
Protected       protected
Synchronized	synchronized
Native			native
Void        	void
Main			main
Class			class
Bool			bool
Int				int
String			string
OpAssign		=
OpAdd			+
OpMinus			"-"
OpMul			"*"
OpDiv			"/"
OpDot			"."
OpModul			"%"
OpAnd			and
OpOr			or
OpNot			not
OpEqu			"=="
OpNotEqu		"!="
OpLt			"<"
OpGt			">"
OpGtEq			">="
OpLtEq			"<="
OpSqLBr			"["
OpSqRBr			"]"
LeftPar			"("
RigthPar		")"
OpLtBrace		"{"
OpRtBrace		"}"
SemiColon		";"
OpDoubleQuote	"\""
If				if
Else			else
OpArrow			"->"

%%
{Identifier}					{ yylval.String = yytext.Substring(1); return (int) Tokens.IDENTIFIER; }
{IntegerLiteral}				{ yylval.Integer = int.Parse(yytext); return (int)Tokens.INTEGER_LITERAL; }
{Bool}							{ bool.TryParse(yytext, out yylval.Bool); return (int) Tokens.BOOL; }
{Public}						{ return (int)Tokens.PUBLIC; }
{Import}						{ return (int)Tokens.IMPORT; }
{Protected}						{ return (int)Tokens.PROTECTED; }
{Private}						{ return (int)Tokens.PRIVATE; }
{Abstract}						{ return (int)Tokens.ABSTRACT; }
{Final}							{ return (int)Tokens.FINAL; }
{Synchronized}					{ return (int)Tokens.SYNCHRONIZED; }
{Native}						{ return (int)Tokens.NATIVE; }
{Static}						{ return (int)Tokens.STATIC; }
{Strictfp}						{ return (int)Tokens.STRICTFP; }
{Void}							{ return (int)Tokens.VOID; }
{Main}							{ return (int)Tokens.MAIN; }
{Class}							{ return (int)Tokens.CLASS; }
{Int}							{ return (int) Tokens.INT; }
{String}						{ return (int) Tokens.STRING; }
{OpAssign}						{ return (int) Tokens.OP_ASSIGN; }
{OpAdd}							{ return (int) Tokens.OP_ADD; }
{OpMinus}						{ return (int) Tokens.OP_MINUS; }
{OpMul}							{ return (int) Tokens.OP_MUL; }
{OpDiv}							{ return (int) Tokens.OP_DIV; }
{OpDot}							{ return (int) Tokens.OP_DOT; }
{OpModul}						{ return (int) Tokens.OP_MODUL; }
{OpAnd}							{ return (int) Tokens.OP_AND; }
{OpOr}							{ return (int) Tokens.OP_OR; }
{OpNot}							{ return (int) Tokens.OP_NOT; }
{OpEqu}							{ return (int) Tokens.OP_EQU; }
{OpNotEqu}						{ return (int) Tokens.OP_NOT_EQU; }
{OpLt}							{ return (int) Tokens.OP_LT; }
{OpGt}							{ return (int) Tokens.OP_GT; }
{OpGtEq}						{ return (int) Tokens.OP_GT_EQ; }
{OpLtEq}						{ return (int) Tokens.OP_LT_EQ; }
{LeftPar}						{ return (int) Tokens.OP_LEFT_PAR; }
{RigthPar}						{ return (int) Tokens.OP_RIGHT_PAR; }
{OpSqLBr}						{ return (int) Tokens.OP_SQ_L_BR; }
{OpSqRBr}						{ return (int) Tokens.OP_SQ_R_BR; }
{OpLtBrace}						{ return (int) Tokens.OP_LT_BRACE; }
{OpRtBrace}						{ return (int) Tokens.OP_RT_BRACE; }
{SemiColon}						{ return (int) Tokens.SEMICOLON; }
{System}						{ return (int) Tokens.SYSTEM; }
{Out}							{ return (int) Tokens.OUT; }
{Println}						{ return (int) Tokens.PRINTLN; }
{OpDoubleQuote}					{ return (int) Tokens.OP_DOUBLE_QUOTE; }
{If}							{ return (int) Tokens.IF; }
{Else}							{ return (int) Tokens.ELSE; }
{OpArrow}						{ return (int) Tokens.OP_ARROW; }
%%

public override void yyerror( string format, params object[] args ) 
{
Console.Error.WriteLine(format, args); 
}
