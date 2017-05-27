%namespace M11J1

%{
	public static AST.CompilationUnit Root;
%}

%union
{
	public AST.CompilationUnit cu;
	public AST.ClassDeclaration cd;
	public AST.MethodHeader methodHeader;
	public AST.MethodDeclarator methodDeclarator;
	public AST.Modifier modifier;
	public AST.MethodDeclaration methodDeclaration;
	public AST.Parameter parameter;
	public List<AST.Modifier> modifiers;
	public List<AST.MethodDeclaration> methodDeclarations;
	public List<AST.Parameter> parameters;
	public List<AST.Statement> statements;
	public List<string> listString;
	public List<AST.VariableDeclaration> variableList;
	public AST.CompoundStatement compoundStatement;
	public AST.VariableDeclarationList variableDeclarationList;
	public AST.Type programType;
	public AST.VariableDeclaration variableDeclaration;
	public AST.Statement statement;
	public AST.Expression expression;

    public int num;
    public string name;
	public float fl;
	public char c;
}

%token <num> IntegerLiteral
%token <name> Identifier
%token <fl> FloatingPointLiteral
%token <c> CharacterLiteral
%token	Abstract Assert Boolean Break Byte Case Catch Char Class Const Continue Default Do Double Else
		Enum Extends Final Finally Float For Goto If Implements Import InstanceOf Int Interface Long Native
		New Package Private Protected Public Return Short Static Strictfp Super Switch Synchronized This
		Throw Throws Transient Try Void Volatile While BooleanLiteral NullLiteral StringLiteral VariableArguments
		DoubleColon Selection Equal GreaterOrEqual LessOrEqual NotEqual AndCondition OrCondition Increment Decrement
		SignedLeftShift SignedRightShift UnsignedRightShift AddAnd SubtractAnd MultiplyAnd DivideAnd BitwiseAnd
		BitwiseInclusiveOr BitwiseExclusiveOr ModulusAnd LeftShiftAnd RightShiftAnd ShiftRightZeroFill

%type <cu> ClassDeclaration
%type <cd> NormalClassDeclaration
%type <modifier> Modifier
%type <modifiers> Modifiers
%type <methodDeclaration> MethodDeclaration, ClassMemberDeclaration, ClassBodyDeclaration
%type <methodDeclarations> ClassBody, ClassBodyDeclarations
%type <methodHeader> MethodHeader
%type <programType> Result, UnannType, UnannPrimitiveType, UnannReferenceType, NumericType, UnannArrayType, UnannTypeVariable
%type <methodDeclarator> MethodDeclarator
%type <parameters> FormalParameterList
%type <parameter> FormalParameter
%type <name> VariableDeclaratorId, VariableDeclarator
%type <statements> BlockStatements
%type <compoundStatement> MethodBody, Block
%type <statement>	BlockStatement, Statement, SelectionStatement, StatementWithoutTrailingSubstatement,
					ExpressionStatement, StatementExpression
%type <listString> VariableDeclaratorList, CommaVariableDeclarator_opt
%type <expression>	Assignment, LeftHandSide, Expression, AssignmentExpression, Literal, ExpressionName, 
					ConditionalExpression, ConditionalOrExpression, ConditionalAndExpression, InclusiveOrExpression,
					ExclusiveOrExpression, AndExpression, EqualityExpression, RelationalExpression,
					ShiftExpression, AdditiveExpression, MultiplicativeExpression, UnaryExpression,
					UnaryExpressionNotPlusMinus, PostfixExpression, Primary, PrimaryNoNewArray
%type <variableList> LocalVariableDeclaration
%type <variableDeclarationList> LocalVariableDeclarationStatement
%type <c> AssignmentOperator
		
%left '='
%nonassoc '<'
%nonassoc NoElse
%nonassoc Else
%left '+' '-'
%left '*' '/'

%%

CompilationUnit
	: ClassDeclaration										{ Root = $1; }
	;

ClassDeclaration
	: NormalClassDeclaration								{ $$ = new AST.CompilationUnit($1); }
	;

NormalClassDeclaration
	: Modifiers Class Identifier ClassBody					{ $$ = new AST.ClassDeclaration($1, $3, $4); }
	;

ClassBody
	: '{' ClassBodyDeclarations '}'							{ $$ = $2; }
	;

ClassBodyDeclarations	
	: /* empty */											{ $$ = new List<AST.MethodDeclaration>(); }
	| ClassBodyDeclarations	ClassBodyDeclaration			{ $$ = $1; $$.Add($2); }
	;

ClassBodyDeclaration										
	: ClassMemberDeclaration								{ $$ = $1; }
	;

ClassMemberDeclaration
	: MethodDeclaration										{ $$ = $1; }
	| ';'
	;

MethodDeclaration
	: Modifiers MethodHeader MethodBody						{ $$ = new AST.MethodDeclaration($1, $2, $3); }
	;

MethodHeader
	: Result MethodDeclarator								{ $$ = new AST.MethodHeader($1, $2); }
	;

MethodBody
	: Block													{ $$ = $1; }
	| ';'
	;

Block
	: '{' BlockStatements '}'								{ $$ = new AST.CompoundStatement($2); }
	;

BlockStatements
	: BlockStatements BlockStatement 						{ $$ = $1; $$.Add($2); }
	| /* empty */											{ $$ = new List<AST.Statement>(); }
	;

BlockStatement
	: LocalVariableDeclarationStatement						{ $$ = $1; }
	| Statement												{ $$ = $1; }
	;

LocalVariableDeclarationStatement
	: LocalVariableDeclaration ';'							{ $$ = new AST.VariableDeclarationList($1); }
	;

LocalVariableDeclaration
	: UnannType VariableDeclaratorList						{ 
																$$ = new List<AST.VariableDeclaration>();
																foreach(var variableName in $2)
																{
																	$$.Add(new AST.VariableDeclaration($1, variableName));
																}
															}
	| VariableModifiers UnannType VariableDeclaratorList
	;
	
VariableModifiers 
	: Modifier 
	| VariableModifiers Modifier
	;

Modifiers
	: Modifiers Modifier		 							{ $$ = $1; $$.Add($2); }
	| /* empty */											{ $$ = new List<AST.Modifier>(); }
	;

Modifier
	: Public												{ $$ = AST.Modifier.Public; }
	| Protected												{ $$ = AST.Modifier.Protected; }
	| Final													{ $$ = AST.Modifier.Final; }
	| Static												{ $$ = AST.Modifier.Static; }
	;

UnannType
	: UnannPrimitiveType									{ $$ = $1; }
	| UnannReferenceType									{ $$ = $1; }
	;

UnannPrimitiveType	
	: NumericType											{ $$ = $1; }
	| Boolean
	;

NumericType
	: Int													{ $$ = new AST.IntType(); }
	;

VariableDeclaratorList
	: VariableDeclarator CommaVariableDeclarator_opt		{ 
																$$ = new List<string>();
																$$.Add($1);
																foreach(var variable in $2)
																{
																	$$.Add(variable);
																}
															}
	;

CommaVariableDeclarator_opt
	: /* empty */											{ $$ = new List<string>(); }
	| CommaVariableDeclarator_opt ',' VariableDeclarator 	{ $$ = $1; $$.Add($3); }
	;

VariableDeclarator
	: VariableDeclaratorId									{ $$ = $1; }
	| VariableDeclaratorId '=' VariableInitializer
	;

VariableInitializer
	: Expression 
	;

Statement
	: StatementWithoutTrailingSubstatement					{ $$ = $1; }
	| SelectionStatement									{ $$ = $1; }
	;

StatementWithoutTrailingSubstatement
	: Block													{ $$ = $1; }
	| ExpressionStatement									{ $$ = $1; }						
	;

ExpressionStatement
	: StatementExpression ';'								{ $$ = $1; }
	;

StatementExpression
	: Assignment											{ $$ = new AST.ExpressionStatement($1); }
	;

SelectionStatement
	: If '(' Expression ')' Statement %prec NoElse
	| If '(' Expression ')' Statement Else Statement		{ $$ = new AST.IfThenElseStatement($3, $5, $7); }
	;

//BasicLoopStatement
//	: For '(' LocalVariableDeclaration ';' Expression ';' Expression ')' Statement  //{ $$ = new AST.BasicForStatement($3, $5, $7, $9); }
//	;
	
Assignment
	: LeftHandSide AssignmentOperator Expression			{ $$ = new AST.AssignmentExpression($1, $2, $3); }
	;

LeftHandSide
	: ExpressionName										{ $$ = $1; }
	;

AssignmentOperator
	: '='													{ $$ = '='; }
	;


Expression
	: AssignmentExpression									{ $$ = $1; }
	;

ConditionalExpression
	: ConditionalOrExpression								{ $$ = $1; }
	;

ConditionalOrExpression
	: ConditionalAndExpression								{ $$ = $1; }
	;

ConditionalAndExpression
	: InclusiveOrExpression									{ $$ = $1; }
	;

InclusiveOrExpression
	: ExclusiveOrExpression									{ $$ = $1; }
	;

ExclusiveOrExpression
	: AndExpression											{ $$ = $1; }
	;

AndExpression
	: EqualityExpression									{ $$ = $1; }
	;

EqualityExpression
	: RelationalExpression									{ $$ = $1; }
	;

RelationalExpression
	: ShiftExpression										{ $$ = $1; }
	| RelationalExpression '<' ShiftExpression				{ $$ = new AST.BinaryExpression($1,'<',$3); }
	;

ShiftExpression
	: AdditiveExpression									{ $$ = $1; }
	;

AdditiveExpression
	: MultiplicativeExpression								{ $$ = $1; }
	| AdditiveExpression '+' MultiplicativeExpression		{ $$ = new AST.BinaryExpression($1,'+',$3); }
	;

MultiplicativeExpression
	: UnaryExpression										{ $$ = $1; }
	;

UnaryExpression
	: UnaryExpressionNotPlusMinus							{ $$ = $1; }
	;

UnaryExpressionNotPlusMinus
	: PostfixExpression										{ $$ = $1; }
	;

PostfixExpression
	: Primary												{ $$ = $1; }
	| ExpressionName										{ $$ = $1; }
	;

Primary
	: PrimaryNoNewArray										{ $$ = $1; }
	;

PrimaryNoNewArray
	: Literal												{ $$ = $1; }
	;

AssignmentExpression
	: ConditionalExpression									{ $$ = $1; }
	| Assignment											{ $$ = $1; }
	;

Literal
	: IntegerLiteral										{ $$ = new AST.NumberExpression($1); }
	;

ExpressionName
	: Identifier											{ $$ = new AST.IdentifierExpression($1); }
	;

Result
	: Void													{ $$ = new AST.VoidType(); }
	| UnannType 
	;

MethodDeclarator
	: Identifier '(' FormalParameterList ')' Dims_opt		{ $$ = new AST.MethodDeclarator($1, $3); }
	;

FormalParameterList
	: /* empty */											{ $$ = new List<AST.Parameter>(); }
	| FormalParameterList FormalParameter 					{ $$ = $1; $$.Add($2); }
	;

FormalParameter
	: Modifiers UnannType VariableDeclaratorId				{ $$ = new AST.FormalParameter($1, $2, $3); }
	;

UnannReferenceType
	: UnannArrayType										{ $$ = $1; }
	;

UnannArrayType
	: UnannTypeVariable Dims								{ $$ = $1; }
	;

UnannTypeVariable
	: Identifier											{ $$ = new AST.IdentifierType(); }
	;

VariableDeclaratorId
	: Identifier Dims_opt									{ $$ = $1; }
	;

Dims_opt
	: /* empty */
	| Dims
	;

Dims
	: '[' ']'
	| '[' ']' Dims
	;

%%

public Parser(Scanner scanner) : base(scanner)
{
}