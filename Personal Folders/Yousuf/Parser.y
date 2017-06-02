%namespace M11J

%output=M11J1.cs
%{
public static AST.Class root;
%}

%union
{
    public AST.Expression expr;
	public AST.Statement stmt;
	public AST.CompoundStatement compoundStmt;
	public AST.ClassMemberDeclaration member;
	public AST.Method method;
	public AST.Type type;
	public AST.NamedType namedType;
	public AST.Parameter param;
	public AST.VariableDeclarator varDeclarator;
	public AST.VariableDeclaratorId varDeclaratorId;
	public AST.VariableDeclarationExpr varDeclaratorExpr;
	public AST.Class classRoot;
	public System.Collections.Generic.List<AST.Statement> stmts;
	public System.Collections.Generic.List<AST.VariableDeclarator> varList;
	public int num;
    public string String;
  	public bool Bool;
	
}
%type <varDeclarator> VariableDeclarator
%type <namedType> UnannTypeVariable
%type <varDeclaratorId> VariableDeclaratorId ExpressionName 
%type <varList> VariableDeclaratorList
%type <varDeclaratorExpr> LocalVariableDeclaration
%type <param> FormalParameterList LastFormalParameter FormalParameter
%type <type> UnannType Result IntegralType NumericType UnannPrimitiveType UnannReferenceType UnannArrayType 
%type <member> ClassMemberDeclaration
%type <expr> Expression VariableInitializer AssignmentExpression ConditionalExpression ConditionalAndExpression ConditionalOrExpression InclusiveOrExpression ExclusiveOrExpression AndExpression
%type <expr> EqualityExpression RelationalExpression ShiftExpression AdditiveExpression MultiplicativeExpression UnaryExpression UnaryExpressionNotPlusMinus PostfixExpression
%type <expr> Primary PrimaryNoNewArray Literal 
%type <stmt> Statement BlockStatement  
%type <compoundStmt> Block MethodBody
%type <stmts>  BlockStatements
%type <method> MethodDeclaration
%type <classRoot> NormalClassDeclaration
%token <String>	 IDENTIFIER 
%token <num> NUMBER
%token <Bool>	 BOOL_LITERAL

%token PUBLIC PROTECTED PRIVATE ABSTRACT STATIC FINAL SYNCHRONIZED NATIVE STRICTFP
%token VOID
%token EXPRESSION_STATEMENT 
%token CLASS
%token BOOL
%token INT
%token STRING
%token IMPORT
%token OP_LEFT_PAR
%token OP_RIGHT_PAR
%token OP_SQ_L_BR
%token OP_SQ_R_BR
%token OP_LT_BRACE OP_RT_BRACE
%token SEMICOLON
%token OP_DOT
%token SYSTEM
%token OUT
%token PRINTLN
%token IF
%token ELSE
%token OP_ARROW
//left associated operands
%left OP_ASSIGN
%left OP_ADD OP_MINUS
%left OP_MUL OP_DIV 
%left OP_MODUL
%left OP_AND
%left OP_OR
%left OP_NOT
%left OP_EQU
%left OP_NOT_EQU
%left OP_LT
%left OP_GT
%left OP_GT_EQ
%left OP_LT_EQ 
%left OP_DOUBLE_QUOTE

%start CompilationUnit
// YACC Rules
%%

ClassDeclaration						:NormalClassDeclaration  														{root=$1;}
										;
NormalClassDeclaration					:ClassModifiers CLASS IDENTIFIER OP_LT_BRACE ClassMemberDeclaration OP_RT_BRACE	{$$ =new AST.Class($3,$5);}
										;
ClassMemberDeclaration					:MethodDeclaration																{$$= new AST.ClassMemberDeclaration($1);}
										|FieldDeclaration 
										;
MethodDeclaration						:MethodModifiers Result IDENTIFIER OP_LEFT_PAR FormalParameterList OP_RIGHT_PAR MethodBody  	{$$ =new AST.Method($2,$3,$5,$7);}
										;
MethodModifiers							:MethodModifier MethodModifiers
										|
										;										

Result									:VOID																			{$$= new AST.VoidType();}
										;
FormalParameterList						:LastFormalParameter															{$$=$1;}
										|
										;
LastFormalParameter						:FormalParameter																{$$=$1;}
										;
FormalParameter							:UnannType VariableDeclaratorId													{$$=new AST.Parameter($1,$2);}
										;
UnannType								:UnannReferenceType																{$$=$1;}
										|UnannPrimitiveType 															 {$$=$1;}
										;
UnannPrimitiveType						:NumericType 																	 {$$=$1;}
										;
NumericType								:IntegralType																	 {$$=$1;}
										;
IntegralType							:INT    																		 {$$=new AST.IntType();}
										;
UnannReferenceType						:UnannArrayType							{$$=$1;}								
										;
UnannArrayType							:UnannTypeVariable Dims				{$$=new AST.ArrayType($1);}
										;
UnannTypeVariable						:IDENTIFIER							{$$=new AST.NamedType($1);}
										;
MethodBody								:Block 																			 {$$=$1;}
										;
Block									:OP_LT_BRACE BlockStatements OP_RT_BRACE 										 {$$ = new AST.CompoundStatement($2); }
										;
BlockStatements							:BlockStatements BlockStatement									 				{$$ = $1; $$.Add($2); }
										|																				{ $$ = new System.Collections.Generic.List<AST.Statement>(); }
										;
BlockStatement							:LocalVariableDeclaration SEMICOLON   											{$$ = new AST.ExpressionStatement($1);}
										|Statement 
										;
VariableDeclaratorId 					:IDENTIFIER																		{$$=new AST.VariableDeclaratorId($1);}
										;
LocalVariableDeclaration				:UnannType VariableDeclaratorList 												 {$$=new AST.VariableDeclarationExpr($1,$2);}
										;
VariableDeclaratorList					:VariableDeclaratorList VariableDeclarator										{$$ = $1; $$.Add($2); }
										|																				{ $$ = new System.Collections.Generic.List<AST.VariableDeclarator>(); }
										;
VariableDeclarator						:VariableDeclaratorId															{$$=new AST.VariableDeclarator($1);}
										|VariableDeclaratorId OP_EQU VariableInitializer 								{$$=new AST.VariableDeclarator($1,$3);}
										;
VariableInitializer						:Expression 																	 {$$=$1;}
										;
Expression								:AssignmentExpression   														 {$$=$1;}
										;
AssignmentExpression					:ConditionalExpression 															 {$$=$1;}
										|ExpressionName OP_EQU Expression   											 
										;
							
ConditionalExpression					: ConditionalOrExpression   													 {$$=$1;}
										;
ConditionalOrExpression					: ConditionalAndExpression   													 {$$=$1;}
										;
ConditionalAndExpression				: InclusiveOrExpression    														 {$$=$1;}
										;
InclusiveOrExpression					: ExclusiveOrExpression    														 {$$=$1;}
										;
ExclusiveOrExpression					: AndExpression      															 {$$=$1;}
										;
AndExpression							: EqualityExpression   															 {$$=$1;}
										;
EqualityExpression						: RelationalExpression   														 {$$=$1;}
										;
RelationalExpression					:ShiftExpression    															 {$$=$1;}
										;
ShiftExpression							:AdditiveExpression   															 {$$=$1;}
										;
AdditiveExpression						:MultiplicativeExpression   													 {$$=$1;}
										;
MultiplicativeExpression				:UnaryExpression    															 {$$=$1;}
										;
UnaryExpression							:UnaryExpressionNotPlusMinus    												 {$$=$1;}
										;
UnaryExpressionNotPlusMinus    			:PostfixExpression    															 {$$=$1;}
										;
PostfixExpression						:Primary    																	 {$$=$1;}
										;
Primary									:PrimaryNoNewArray    															 {$$=$1;}
										;
PrimaryNoNewArray						:Literal     																	 {$$=$1;}
										;
Literal 								:NUMBER 																 {$$ = new AST.NumberExpression($1);}
										;
Statement								:StatementWithoutTrailingSubstatement 
										|IfThenElseStatement
										;
IfThenElseStatement						:IF OP_LEFT_PAR Expression OP_RIGHT_PAR Statement ELSE Statement  				 
										;
StatementWithoutTrailingSubstatement 	:OP_LT_BRACE Statement OP_RT_BRACE  
										|ExpressionStatement 
										|EmptyStatement
										;
EmptyStatement							:SEMICOLON
										;
ExpressionStatement						:StatementExpression SEMICOLON
										;
StatementExpression						:ExpressionName OP_EQU Expression
										|MethodInvocation
										;
ExpressionName							:IDENTIFIER    											{$$=new AST.VariableDeclaratorId($1);}
										;
MethodInvocation						:MethodName OP_LEFT_PAR ArgumentList OP_RIGHT_PAR
										;
MethodName								:SYSTEM OP_DOT OUT OP_DOT PRINTLN
										;
ArgumentList							:Expression
										;

MethodModifier							:PUBLIC 
										|PROTECTED
										|PRIVATE
										|ABSTRACT
										|STATIC
										|FINAL 
										|SYNCHRONIZED
										|NATIVE
										|STRICTFP
										;
CompilationUnit							:TypeDeclaration																 
										|ImportDeclaration
										|ImportDeclaration TypeDeclaration
										;
ImportDeclaration						:SingleTypeImportDeclaration
										;
SingleTypeImportDeclaration				:IMPORT TypeName 
										;
TypeName								:PackageOrTypeName OP_DOT IDENTIFIER
										;
PackageOrTypeName						:PackageOrTypeName OP_DOT IDENTIFIER
										|IDENTIFIER
										;
TypeDeclaration							:ClassDeclaration
										;	
																							
ClassModifiers							: ClassModifier ClassModifiers
										|
										;
ClassModifier							:PUBLIC 
										|PROTECTED
										|PRIVATE
										|ABSTRACT
										|STATIC
										|FINAL 
										|STRICTFP
										;
Annotation								:PUBLIC 
										|PROTECTED
										|PRIVATE
										|ABSTRACT
										|STATIC
										|FINAL 
										;
FieldDeclaration						: UnannType VariableDeclaratorList 
										|FieldModifier UnannType VariableDeclaratorList 
										;

FieldModifier							:Annotation
										;
Dims									:OP_SQ_L_BR OP_SQ_R_BR
										;
%%

public Parser(Scanner scanner) : base(scanner)
{
}
