%namespace M11J1

%union
{
    public int num;
    public string name;
}

%token <num> Number
%token <name> Identifier
%token	Abstract Assert Boolean Break Byte Case Catch Char Class Const Continue Default Do Double Else
		Enum Extends Final Finally Float For Goto If Implements Import Instanceof Int Interface Long Native
		New Package Private Protected Public Return Short Static Strictfp Super Switch Synchronized This
		Throw Throws Transient Try Void Volatile While BooleanLiteral NullLiteral
		IntegerLiteral CharacterLiteral StringLiteral FloatingPointLiteral VariableArguments
		DoubleColon Selection Equal GreaterOrEqual LessOrEqual NotEqual AndCondition OrCondition Increment Decrement
		SignedLeftShift SignedRightShift UnsignedRightShift AddAnd SubtractAnd MultiplyAnd DivideAnd BitwiseAnd
		BitwiseInclusiveOr BitwiseExclusiveOr ModulusAnd LeftShiftAnd RightShiftAnd ShiftRightZeroFill
		
%left '='
%nonassoc '<'
%left '+'

%%

CompilationUnit
	: PackageDeclaration_opt ImportDeclarations TypeDeclarations
	;

ClassDeclaration
	: NormalClassDeclaration
	// | EnumDeclaration
	;

NormalClassDeclaration
	: ClassModifiers Class Identifier TypeParameters_opt Superclass_opt Superinterfaces_opt ClassBody
	;

ClassBody
	: '{' ClassBodyDeclarations '}'
	;

ClassBodyDeclarations	
	: empty
	| ClassBodyDeclaration
	| ClassBodyDeclarations ClassBodyDeclaration 
	;

ClassBodyDeclaration
	: ClassMemberDeclaration
	/* more */
	;

ClassMemberDeclaration
	: MethodDeclaration  
	//| FieldDeclaration 
	//| ClassDeclaration
	//| InterfaceDeclaration 
	| ';'
	;

MethodDeclaration
	: MethodModifiers MethodHeader MethodBody
	;

MethodBody
	: Block
	| ';'
	;

Block
	: '{' BlockStatements_opt '}'
	;

BlockStatements_opt
	: empty
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
	: VariableModifiers UnannType VariableDeclaratorList
	;

VariableModifiers
	: empty
	| VariableModifier
	| VariableModifiers VariableModifier
	;

VariableModifier
	//| Anotation
	: Final
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
	: IntegralType 
	//| FloatingPointType
	;

IntegralType
	: Int
	/* more */
	;

VariableDeclaratorList
	: VariableDeclarator Comma_VariableDeclarator_opt
	;

Comma_VariableDeclarator_opt
	: empty
	| ',' VariableDeclarator
	| Comma_VariableDeclarator_opt ',' VariableDeclarator
	;

VariableDeclarator
	: VariableDeclaratorId
	| VariableDeclaratorId '=' VariableInitializer
	;

VariableInitializer
	: /* more */
	;

Statement
	: StatementWithoutTrailingSubstatement 
	/* more */
	;

StatementWithoutTrailingSubstatement
	: ExpressionStatement  
	/* more */
	;

ExpressionStatement
	: StatementExpression ';'
	;

StatementExpression
	: Assignment
	/* more */
	;
	
Assignment
	: LeftHandSide AssignmentOperator Expression
	;

LeftHandSide
	: ExpressionName
	/* more */
	;

AssignmentOperator
	: '='
	/* more */
	;

Expression
	: // LambdaExpression 
	| AssignmentExpression
	;

AssignmentExpression
	: ConditionalExpression 
	| Assignment
	;

ConditionalExpression
	: ConditionalOrExpression
	/* more */
	;

ConditionalOrExpression
	: ConditionalAndExpression
	/* more */
	;

ConditionalAndExpression
	: InclusiveOrExpression 
	/* more */
	;

InclusiveOrExpression
	: ExclusiveOrExpression
	/* more */
	;

ExclusiveOrExpression
	: AndExpression 
	/* more */
	;

AndExpression
	: EqualityExpression
	/* more */
	;

EqualityExpression
	: RelationalExpression
	/* more */
	;

RelationalExpression
	: ShiftExpression
	/* more */
	;

ShiftExpression
	: AdditiveExpression
	/* more */
	;

AdditiveExpression
	: MultiplicativeExpression 
	/* more */
	;

MultiplicativeExpression 
	: UnaryExpression 
	/* more */
	;

UnaryExpression 
	: UnaryExpressionNotPlusMinus
	/* more */
	;

UnaryExpressionNotPlusMinus
	: PostfixExpression 
	/* more */
	;

PostfixExpression
	: Primary 
	/* more */
	;

Primary
	: PrimaryNoNewArray
	/* more */
	;

PrimaryNoNewArray
	: Literal 
	/* more */
	;

Literal
	: IntegerLiteral 
	/* more */
	;

ExpressionName
	: Identifier
	/* more */
	;

MethodModifiers
	: empty
	| MethodModifier
	| MethodModifiers MethodModifier 
	;

MethodModifier
	: Public
	//| Annotation
	| Static
	/* more */
	;

MethodHeader
	: Result MethodDeclarator Throws_opt
	/* more */
	;

Result
	: Void
	| UnannType 
	;

MethodDeclarator
	: Identifier '(' FormalParameterList_opt ')' Dims_opt
	;

FormalParameterList_opt
	: empty
	| FormalParameterList
	;

FormalParameterList
	: LastFormalParameter
	//| FormalParameters ',' LastFormalParameter
	//| ReceiverParameter 
	;

LastFormalParameter
	: FormalParameter
	//| {VariableModifier} UnannType {Annotation} ... VariableDeclaratorId 
	;

FormalParameter
	: VariableModifiers UnannType VariableDeclaratorId
	;

UnannReferenceType
	: UnannArrayType
	/* more */
	;

UnannArrayType
	: UnannTypeVariable Dims
	/* more */
	;

UnannTypeVariable
	: Identifier
	;

VariableDeclaratorId
	: Identifier Dims_opt
	;

Dims_opt
	: empty
	| Dims
	;

Dims
	: Annotations '[' ']'
	| Dims Annotations '[' ']'
	;

Annotations
	: empty
	| Annotation
	| Annotations Annotation
	;

Annotation
	: /* more */
	;

Throws_opt
	: // Throws
	| empty
	;

ClassModifiers
	: empty
	| ClassModifier
	| ClassModifiers ClassModifier  
	;

ClassModifier 
	: Public
	//| Annotation
	| Protected
	/* more */
	;

TypeParameters_opt
	: empty
	//| TypeParameters
	;

Superinterfaces_opt
	: empty
	//| Superinterfaces
	;

Superclass_opt
	: empty
	//| Superclass
	;

PackageDeclaration_opt
	: empty
	//| PackageDeclaration
	;

ImportDeclarations
	: empty 
	| ImportDeclaration
	| ImportDeclarations ImportDeclaration
	;

ImportDeclaration
	: /* more */
	;

TypeDeclarations
	: empty 
	| TypeDeclaration
	| TypeDeclarations TypeDeclaration
	;

TypeDeclaration
	: ClassDeclaration
	//| InterfaceDeclaration 
	| ';'
	;

	InterfaceDeclaration
	:NormalInterfaceDeclaration
	//|AnnotationTypeDeclaration
	;

empty : ;

%%

public Parser(Scanner scanner) : base(scanner)
{
}