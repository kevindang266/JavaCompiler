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

%token<num> Number
%token<name> Identifier
%token Abstract Assert Boolean Break Byte Case Catch Char Class Const Continue Default Do Double Else

        Enum Extends Final Finally Float For Goto If Implements Import InstanceOf Int Interface Long Native
        New Package Private Protected Public Return Short Static Strictfp Super Switch Synchronized This

        Throw Throws Transient Try Void Volatile While BooleanLiteral NullLiteral
        IntegerLiteral CharacterLiteral StringLiteral FloatingPointLiteral VariableArguments

        DoubleColon Selection Equal GreaterOrEqual LessOrEqual NotEqual AndCondition OrCondition Increment Decrement

        SignedLeftShift SignedRightShift UnsignedRightShift AddAnd SubtractAnd MultiplyAnd DivideAnd BitwiseAnd

        BitwiseInclusiveOr BitwiseExclusiveOr ModulusAnd LeftShiftAnd RightShiftAnd ShiftRightZeroFill

%type<cms> ClassModifiers
%type<cd> NormalClassDeclaration
%type<cm> ClassModifier
		
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

ArrayCreationExpression
	: New PrimitiveType DimExprs_man Dims_opt				// PrimitiveType in §4 (Types, Values, and Variables)
	| New ClassOrInterfaceType DimExprs_man Dims_opt		// ClassOrInterfaceType in §4 (Types, Values, and Variables)
	| New PrimitiveType Dims ArrayInitializer			// ArrayInitializer in §10 (Arrays)
	| New ClassOrInterfaceType Dims ArrayInitializer
    ;

DimExprs
	: empty
	| DimExpr
	| DimExprs DimExpr
    ;

DimExpr
	: Annotations '[' Expression ']'
	;

PrimitiveType
    : Annotation_opt NumericType
    | Annotation_opt boolean
    ;

Annotation
    : NormalAnnotation
    | MarkerAnnotation
    | SingleElementAnnotation
    ;

Expression
    : LambdaExpression
    | AssignmentExpression
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

LeftHandSide
	: ExpressionName
	| FieldAccess
	| ArrayAccess
	;

ExpressionName
	: Identifier
	/* more */
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



empty : ;

%%
public Parser(Scanner scanner) : base(scanner)
{
}
