%namespace M11J1

%{
	public static AST.ClassDeclaration Root;
%}

%union
{
	public AST.ClassDeclaration cd;
	public AST.Modifier modifier;
	public System.Collections.Generic.List<AST.Modifier> modifiers;
    public int num;
    public string name;
}

%token <num> Number
%token <name> Identifier
%token	Abstract Assert Boolean Break Byte Case Catch Char Class Const Continue Default Do Double Else
		Enum Extends Final Finally Float For Goto If Implements Import InstanceOf Int Interface Long Native
		New Package Private Protected Public Return Short Static Strictfp Super Switch Synchronized This
		Throw Throws Transient Try Void Volatile While BooleanLiteral NullLiteral
		IntegerLiteral CharacterLiteral StringLiteral FloatingPointLiteral VariableArguments
		DoubleColon Selection Equal GreaterOrEqual LessOrEqual NotEqual AndCondition OrCondition Increment Decrement
		SignedLeftShift SignedRightShift UnsignedRightShift AddAnd SubtractAnd MultiplyAnd DivideAnd BitwiseAnd
		BitwiseInclusiveOr BitwiseExclusiveOr ModulusAnd LeftShiftAnd RightShiftAnd ShiftRightZeroFill

%type <modifiers> Modifiers
%type <cd> NormalClassDeclaration
%type <modifier> Modifier
		
%left '='
%nonassoc '<'
%left '+' '-'
%left '*' '/'

%%

CompilationUnit
	: ClassDeclaration
	;

ClassDeclaration
	: NormalClassDeclaration
	;

NormalClassDeclaration
	: Modifiers Class Identifier ClassBody
	;

ClassBody
	: '{' ClassBodyDeclarations '}'	
	;

ClassBodyDeclarations	
	: /* empty */
	| ClassBodyDeclaration ClassBodyDeclarations
	;

ClassBodyDeclaration
	: ClassMemberDeclaration
	;

ClassMemberDeclaration
	: MethodDeclaration
	| ';'
	;

MethodDeclaration
	: Modifiers MethodHeader MethodBody
	;

MethodBody
	: Block
	| ';'
	;

Block
	: '{' BlockStatements_opt '}'
	;

BlockStatements_opt
	: /* empty */
	| BlockStatements 
	;

BlockStatements
	: BlockStatement
	| BlockStatements BlockStatement
	;

BlockStatement
	: LocalVariableDeclarationStatement
	| ClassDeclaration 
	| Statement
	;

LocalVariableDeclarationStatement
	: LocalVariableDeclaration ';'
	;

LocalVariableDeclaration
	: UnannType VariableDeclaratorList
	| VariableModifiers UnannType VariableDeclaratorList
	;
	
VariableModifiers 
	: Modifier 
	| Modifier VariableModifiers
	;

Modifiers
	: /* empty */
	| Modifier Modifiers
	;

Modifier
	: Public
	| Protected
	| Final
	| Static
	;

UnannType
	: UnannPrimitiveType
	| UnannReferenceType
	;

UnannPrimitiveType
	: NumericType 
	| Boolean
	;

NumericType
	: Int 
	;

VariableDeclaratorList
	: VariableDeclarator Comma_VariableDeclarator_opt
	;

Comma_VariableDeclarator_opt
	: /* empty */
	| ',' VariableDeclarator Comma_VariableDeclarator_opt
	;

VariableDeclarator
	: VariableDeclaratorId
	| VariableDeclaratorId '=' VariableInitializer
	;

VariableInitializer
	: Expression 
	//| ArrayInitializer
	;

Statement
	: Assignment ';' 
	;
	
Assignment
	: LeftHandSide AssignmentOperator Expression
	;

LeftHandSide
	: ExpressionName
	;

AssignmentOperator
	: '='
	;

Expression
	: AssignmentExpression
	;

AssignmentExpression
	: Literal 
	| Assignment
	;

Literal
	: IntegerLiteral
	;

ExpressionName
	: Identifier
	;

MethodHeader
	: Result MethodDeclarator
	;

Result
	: Void
	| UnannType 
	;

MethodDeclarator
	: Identifier '(' FormalParameterList_opt ')' Dims_opt
	;

FormalParameterList_opt
	: /* empty */
	| FormalParameter
	;

FormalParameter
	: Modifiers UnannType VariableDeclaratorId
	;

UnannReferenceType
	: UnannArrayType
	;

UnannArrayType
	: UnannTypeVariable Dims
	;

UnannTypeVariable
	: Identifier
	;

VariableDeclaratorId
	: Identifier Dims_opt
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