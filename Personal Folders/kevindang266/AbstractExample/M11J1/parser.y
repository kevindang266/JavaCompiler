%namespace M11J1

%{
	public static AST.ClassDeclaration Root;
%}

%union
{
	public AST.ClassDeclaration cd;
	public AST.ClassModifier cm;
	public System.Collections.Generic.List<AST.ClassModifier> cms;
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

%type <cms> ClassModifiers
%type <cd> NormalClassDeclaration
%type <cm> ClassModifier
		
%left '='
%nonassoc '<'
%left '+'

%%

CompilationUnit
	: PackageDeclaration_opt ImportDeclarations TypeDeclarations	
	;

ClassDeclaration
	: NormalClassDeclaration						{ Root = $1; }
	// | EnumDeclaration
	;

NormalClassDeclaration
	: ClassModifiers Class Identifier TypeParameters_opt Superclass_opt Superinterfaces_opt ClassBody				{ $$ = new AST.ClassDeclaration($1, $3); }
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

/* kevin 15 Apr §15 (Expressions) */
	
Assignment
	: LeftHandSide AssignmentOperator Expression
	;

LeftHandSide
	: ExpressionName
	| FieldAccess
	| ArrayAccess
	;

AssignmentOperator
	: '='
	| MultiplyAnd
	| DivideAnd
	| ModulusAnd
	| AddAnd
	| SubtractAnd
	| LeftShiftAnd
	| RightShiftAnd
	| ShiftRightZeroFill
	| BitwiseAnd
	| BitwiseExclusiveOr
	| BitwiseInclusiveOr
	;

Expression
	: LambdaExpression 
	| AssignmentExpression
	;

AssignmentExpression
	: ConditionalExpression 
	| Assignment
	;

ConditionalExpression
	: ConditionalOrExpression
	| ConditionalOrExpression '?' Expression ':' ConditionalExpression 
	| ConditionalOrExpression '?' Expression ':' LambdaExpression
	;

ConditionalOrExpression
	: ConditionalAndExpression
	| ConditionalOrExpression OrCondition ConditionalAndExpression
	;

ConditionalAndExpression
	: InclusiveOrExpression 
	| ConditionalAndExpression AndCondition InclusiveOrExpression
	;

InclusiveOrExpression
	: ExclusiveOrExpression
	| InclusiveOrExpression '|' ExclusiveOrExpression
	;

ExclusiveOrExpression
	: AndExpression 
	| ExclusiveOrExpression '^' AndExpression
	;

AndExpression
	: EqualityExpression
	| AndExpression '&' EqualityExpression
	;

EqualityExpression
	: RelationalExpression
	| EqualityExpression Equal RelationalExpression
	| EqualityExpression NotEqual RelationalExpression
	;

RelationalExpression
	: ShiftExpression
	| RelationalExpression '<' ShiftExpression
	| RelationalExpression '>' ShiftExpression
	| RelationalExpression LessOrEqual ShiftExpression
	| RelationalExpression GreaterOrEqual ShiftExpression
	| RelationalExpression InstanceOf ReferenceType
	;

ShiftExpression
	: AdditiveExpression
	| ShiftExpression SignedLeftShift AdditiveExpression
	| ShiftExpression SignedRightShift AdditiveExpression
	| ShiftExpression UnsignedRightShift AdditiveExpression
	;

AdditiveExpression
	: MultiplicativeExpression 
	| AdditiveExpression '+' MultiplicativeExpression
	| AdditiveExpression '-' MultiplicativeExpression
	;

MultiplicativeExpression 
	: UnaryExpression 
	| MultiplicativeExpression '*' UnaryExpression
	| MultiplicativeExpression '/' UnaryExpression
	| MultiplicativeExpression '%' UnaryExpression
	;

UnaryExpression 
	: PreIncrementExpression
	| PreDecrementExpression 
	| '+' UnaryExpression
	| '-' UnaryExpression 
	| UnaryExpressionNotPlusMinus
	;

PreIncrementExpression
	: Increment UnaryExpression
	;

PreDecrementExpression
	: Decrement UnaryExpression
	;

UnaryExpressionNotPlusMinus
	: PostfixExpression 
	| '~' UnaryExpression 
	| '!' UnaryExpression
	| CastExpression
	;

PostfixExpression
	: Primary 
	| ExpressionName			// ExpressionName in §6 (Names)
	| PostIncrementExpression 
	| PostDecrementExpression
	;

PostIncrementExpression
	: PostfixExpression Increment
	;

PostDecrementExpression
	: PostfixExpression Decrement
	;

CastExpression
	: '(' PrimitiveType ')' UnaryExpression				// PrimitiveType in  §4 (Types, Values, and Variables)
	| '(' ReferenceType AdditionalBounds ')' UnaryExpressionNotPlusMinus			// ReferenceType & AdditionalBounds in  §4 (Types, Values, and Variables)
	| '(' ReferenceType AdditionalBounds ')' LambdaExpression
	;

Primary
	: PrimaryNoNewArray
	| ArrayCreationExpression
	;

PrimaryNoNewArray
	: Literal 
	| ClassLiteral
	| This
	| TypeName '.' This							// TypeName in §6 (Names)
	| '(' Expression ')'
	| ClassInstanceCreationExpression
	| FieldAccess
	| ArrayAccess
	| MethodInvocation 
	| MethodReference
	;

ClassLiteral
	: TypeName LeftRightBrackets '.' Class			// TypeName in §6 (Names)
	| NumericType LeftRightBrackets '.' Class 
	| Boolean LeftRightBrackets '.' Class
	| Void '.' Class
	;

ClassInstanceCreationExpression 
	: UnqualifiedClassInstanceCreationExpression
	| ExpressionName '.' UnqualifiedClassInstanceCreationExpression		// ExpressionName §6 (Names)
	| Primary '.' UnqualifiedClassInstanceCreationExpression
	;

FieldAccess
	: Primary '.' Identifier 
	| Super '.' Identifier 
	| TypeName '.' Super '.' Identifier				// TypeName in §6 (Names)
	;

ArrayAccess
	: ExpressionName '[' Expression ']'				// ExpressionName in §6 (Names)
	| PrimaryNoNewArray '[' Expression ']'
	;

MethodInvocation
	: MethodName '(' ArgumentList_opt ')'			// MethodName in §6 (Names)
	| TypeName '.' TypeArguments_opt Identifier '('  ArgumentList_opt ')'
	| ExpressionName '.' TypeArguments_opt Identifier '('  ArgumentList_opt ')'
	| Primary '.' TypeArguments_opt Identifier '('  ArgumentList_opt ')'
	| Super '.' TypeArguments_opt Identifier '('  ArgumentList_opt ')'
	| TypeName '.' Super '.' TypeArguments_opt Identifier '('  ArgumentList_opt ')'
	;

MethodReference
	: ExpressionName DoubleColon TypeArguments_opt Identifier			// ExpressionName in §6 (Names)
	| ReferenceType DoubleColon TypeArguments_opt Identifier			// ReferenceType in §4 (Types, Values, and Variables)
	| Primary DoubleColon TypeArguments_opt Identifier 
	| Super DoubleColon TypeArguments_opt Identifier
	| TypeName '.' Super DoubleColon TypeArguments_opt Identifier 
	| ClassType DoubleColon TypeArguments_opt New				// ClassType in §4 (Types, Values, and Variables)
	| ArrayType DoubleColon New									// ArrayType in §4 (Types, Values, and Variables)
	;

UnqualifiedClassInstanceCreationExpression
	: New TypeArguments_opt ClassOrInterfaceTypeToInstantiate '(' ArgumentList_opt ')' ClassBody_opt	// TypeArguments_opt in §4 (Types, Values, and Variables) , ClassBody_opt in §8 (Classes)
	;

ClassOrInterfaceTypeToInstantiate
	: Annotations Identifier DotAnnotationIdentifiers TypeArgumentsOrDiamond_opt				// Annotation in §9 (Interfaces)
	;

DotAnnotationIdentifiers
	: empty
	| DotAnnotationIdentifier
	| DotAnnotationIdentifiers DotAnnotationIdentifier
	;

DotAnnotationIdentifier
	: '.' Annotations Identifier
	;

TypeArgumentsOrDiamond_opt
	: empty
	| TypeArgumentsOrDiamond
	;

TypeArgumentsOrDiamond
	: TypeArguments					// TypeArguments_opt in §4 (Types, Values, and Variables)
	| '<' '>'
	;

ArgumentList_opt
	: empty
	| ArgumentList
	;

ArgumentList
	: Expression CommaExpressions
	;

CommaExpressions				// custom
	: empty
	| CommaExpression
	| CommaExpressions CommaExpression
	;

CommaExpression					// custom
	: ',' Expression
	;

LeftRightBrackets				// custom
	: empty
	| LeftRightBracket
	| LeftRightBrackets LeftRightBracket
	;

LeftRightBracket
	: '[' ']'
	;

ArrayCreationExpression
	: New PrimitiveType DimExprs_man Dims_opt				// PrimitiveType in §4 (Types, Values, and Variables)
	| New ClassOrInterfaceType DimExprs_man Dims_opt		// ClassOrInterfaceType in §4 (Types, Values, and Variables)
	| New PrimitiveType Dims ArrayInitializer			// ArrayInitializer in §10 (Arrays)
	| New ClassOrInterfaceType Dims ArrayInitializer
	;

DimExprs_man				// custom mandatory
	: DimExpr DimExprs
	;

DimExprs
	: empty
	| DimExpr
	| DimExprs DimExpr
	;

DimExpr
	: Annotations '[' Expression ']'
	;

LambdaExpression
	: LambdaParameters Selection LambdaBody	
	;

LambdaParameters
	: Identifier
	| '(' FormalParameterList_opt ')'
	| '(' InferredFormalParameterList ')'
	;

LambdaBody
	: Expression 
	| Block
	;

InferredFormalParameterList
	: Identifier CommaIdentifiers
	;

CommaIdentifiers		// custom
	: empty
	| CommaIdentifier
	| CommaIdentifiers CommaIdentifier
	;

CommaIdentifier
	: ',' Identifier
	;

Literal
	: IntegerLiteral 
	| FloatingPointLiteral 
	| BooleanLiteral 
	| CharacterLiteral
	| StringLiteral 
	| NullLiteral
	;

/* end kevin 15 Apr */

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

empty : ;

%%

public Parser(Scanner scanner) : base(scanner)
{
}