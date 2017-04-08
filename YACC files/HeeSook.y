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

// Start HS
/**/

/*15 Expression*/
ExpressionStatement : 
	;

PreIncrementExpression :  //To Be Implemented
	;

PreDecrementExpression :         //To Be Implemented
	;

PostIncrementExpression:       //To Be Implemented
	;

PostDecrementExpression:    //To Be Implemented
	;

ConstantExpression :   //To Be Implemented
	;

MethodInvocation :       //To Be Implemented
	;

ClassinstanceCreationExpression :    //To Be Implemented
	;

VariableModifier:  //To Be Implemented
	;

/*§8 (Classes) */	
UnannType:   //To Be Implemented
	; 

UnannClassType:  //To Be Implemented
	;

ClassType: //To Be Implemented
	;

VariableDeclaratorId :  //To Be Implemented
	; 

/*§14 (Blocks and Statements) */
IdentifierState :  // // To Be Implemented  Identifier -> IdentifierState
	;

Statement
	: StatementWithoutTrailingSubstatement 
    | LabeledStatement  
	| IfThenStatement
	| IfThenElseStatement
	| WhileStatement
	| ForStatement
	;

StatementNoShortIf
	: StatementWithoutTrailingSubstatement 
	| LabeledStatementNoShortIf 
	| IfThenElseStatementNoShortIf 
	| WhileStatementNoShortIf 
	| ForStatementNoShortIf
	;

StatementWithoutTrailingSubstatement
	: Block
	| EmptyStatement
	| ExpressionStatement
	| AssertStatement
	| SwitchStatement
	| DoStatement
	| BreakStatement
	| ContinueStatement
	| ReturnStatement
	| SynchronizedStatement
	| ThrowStatement
	| TryStatement
    ;

EmptyStatement
	: ';'
	;

LabeledStatement
	: IdentifierState ':' Statement
	;

LabeledStatementNoShortIf 
	: IdentifierState ':' StatementNoShortIf   	
	;  

ExpressionStatement
	: StatementExpression ';'
	;

StatementExpression
	: Assignment
	| PreIncrementExpression 
	| PreDecrementExpression       
	| PostIncrementExpression       
	| PostDecrementExpression   
	| MethodInvocation     
	| ClassinstanceCreationExpression    
	;

IfThenStatement
	: If '(' Expression ')' Statement
	;

IfThenElseStatement
	: If '(' Expression ')' StatementNoShortIf Else Statement
	;

IfThenElseStatementNoShortIf
	: If '(' Expression ')' StatementNoShortIf Else StatementNoShortIf
	;

IfThenElseStatementNoShortIf
	: If '(' Expression ')' StatementNoShortIf Else StatementNoShortIf
	;

IfThenElseStatementNoShortIf
	: If '(' Expression ')' StatementNoShortIf Else StatementNoShortIf
	;

AssertStatement
	: Assert Expression ':'
	| Assert Expression ':' Expression ';'
	;

SwitchStatement
	: Switch '(' Expression ')' SwitchBlock
	;

SwitchBlock
	: '{' SwitchBlockStatementGroup '}'
	| SwitchLabel
	;

SwitchBlockStatementGroup
	: SwitchLabels BlockStatements
	;

SwitchLabels
	: SwitchLabel '{' SwitchLabel '}'
	;

SwitchLabel
	: Case ConstantExpression ':'  
	| Case EnumConstantName ':'
	| Default ':'
	;

EnumConstantName 
	: IdentifierState  
	;

WhileStatement
	: While '(' Expression ')' Statement
	;

WhileStatementNoShortIf
	: While '(' Expression ')' StatementNoShortIf
	;

DoStatement
	: Do Statement While '(' Expression ')' ';'
	;

ForStatement
	: BasicForStatement
	| EnhancedForStatement
	;

ForStatementNoShortIf
	: BasicForStatementNoShortIf
	| EnhancedForStatementNoShortIf
	;

BasicForStatement
	: For '(' ForInit ';' Expression ';' ForUpdate ')' Statement
	;

BasicForStatementNoShortIf
	: For '(' ForInit ';' Expression ';' ForUpdate ')' StatementNoShortIf
	;

ForInit
	: StatementExpressionList
	| LocalVariableDeclaration
	;

ForUpdate
	:StatementExpressionList
	;

StatementExpressionList
	: StatementExpression '{' ',' StatementExpression '}'
	;

EnhancedForStatement
	: For '(' VariableModifier UnannType VariableDeclaratorId ':' Expression ')' Statement 
	;

EnhancedForStatementNoShortIf
	: For '(' VariableModifier UnannType VariableDeclaratorId ':' Expression ')' StatementNoShortIf
	;

BreakStatement
	: Break IdentifierState ';'
	;

ContinueStatement
	: Continue IdentifierState ';'
	;

ReturnStatement
	: Return Expression ';'
	;

ThrowStatement
	: Throw Expression ';'
	;

SynchronizedStatement
	: Synchronized '(' Expression ')' Block
	;

TryStatement
	: Try Block Catches
	| Try Block Catches Finally
	| TryWithResourcesStatement
	;

Catches 
	: CatchClause CatchClause
	;

CatchClause
	: Catch CatchFormalParameter Block
	;

CatchFormalParameter
	: VariableModifier CatchType VariableDeclaratorId
	;

CatchType 
	: UnannClassType '|' ClassType
	;

FinallyState 
	: Finally Block
	;

TryWithResourcesStatement
	: Try ResourceSpecification Block Catches FinallyState
	;

ResourceSpecification
	: '(' ResourceList ';' ')'
	;

ResourceList  
	: Resource ';' Resource
	;

Resource
	: VariableModifier UnannType VariableDeclaratorId '=' Expression
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

empty : ;

%%

public Parser(Scanner scanner) : base(scanner)
{
}