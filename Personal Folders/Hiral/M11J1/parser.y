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
%type <statement> BlockStatement, Statement, SelectionStatement
%type <listString> VariableDeclaratorList, CommaVariableDeclarator_opt
%type <expression> Assignment, LeftHandSide, Expression, AssignmentExpression, Literal, ExpressionName, ConditionalExpression
%type <variableList> LocalVariableDeclaration
%type <variableDeclarationList> LocalVariableDeclarationStatement
		
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
	: Assignment ';'										{ $$ = new AST.ExpressionStatement($1); }
	| SelectionStatement									{ $$ = $1; }
	| Block													{ $$ = $1; }
	;

SelectionStatement
	: If '(' Expression ')' Statement %prec NoElse
	| If '(' Expression ')' Statement Else Statement		{ $$ = new AST.IfThenElseStatement($3, $5, $7); }
	;
	
Assignment
	: LeftHandSide AssignmentOperator Expression			{ $$ = new AST.AssignmentExpression($1, $3); }
	;

LeftHandSide
	: ExpressionName										{ $$ = $1; }
	;

AssignmentOperator
	: '='
	| '+'
	;

Expression
	: AssignmentExpression									{ $$ = $1; }
	| ConditionalExpression									{ $$ = $1; }
	;

ConditionalExpression
	: LeftHandSide '<' Expression							{ $$ = new AST.BinaryExpression($1,'<',$3); }
	;

AssignmentExpression
	: Literal												{ $$ = $1; }
	| Assignment
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

Statement
		: StatementWithoutTrailingSubstatement					{ $$ = $1; } 
		| IfThenStatement										{$$ = $1; } 
		| IfThenElseStatement									{$$ = $1; } 
		| WhileStatement										{ $$ = $1; } 
		| LabeledStatement										 { $$ = $1;} 
		;
		
StatementNoShortIf
		: StatementWithoutTrailingSubstatement					{$$ = $1; } 
		| IfThenElseStatementNoShortIf							{$$ = $1; } 
		;


StatementWithoutTrailingSubstatement
		: ExpressionStatement 									{ $$ = $1; } 
		| Block													{ $$ = $1; } 
		| BreakStatement										{ $$ = $1;} 
		| DoStatement											{ $$ = $1; } 
		| ContinueStatement										{ $$ = $1;} 
		| ReturnStatement										{ $$ = $1;} 
		| ThrowStatement										{ $$ = $1;} 
		| SynchronizedStatement									{ $$ = $1;} 
		| SwitchStatement										{ $$ = $1;} 
		| AssertStatement										{ $$ = $1;} 
		| TryStatement											{ $$ = $1;} 
;
AssertStatement
    : Assert Expression                                              { $$ = new AssertStatement($2);}
    | Assert Expression ':' Expression ';'	                         { $$ = new AssertStatement($2, $4);} 
	;

SwitchStatement
    : Switch '(' Expression ')' SwitchBlock 	                     { $$ = new SwitchStatement($3, $5); }
	;

SwitchBlock
    : '{' SwitchBlockStatementGroups SwitchLabels '}'	              { $$ = $2; }
	; 

SwitchBlockStatementGroups
    : empty
	| SwitchBlockStatementGroup                                       { $$ = new List<Statement> {$1}; }  
	| SwitchBlockStatementGroups SwitchBlockStatementGroup            { $$ = $1; $$.Add($2); } 
	;

SwitchLabels
    : empty
	| SwitchLabel                                                      { $$ = new List<Statement> {$1};} 
	| SwitchLabels SwitchLabel                                         { $$ = $1; $$.Add($2); }
	;	 

WhileStatement
    : While '(' Expression ')' Statement                               { $$ = new WhileStatement($3, $5); }
	;

DoStatement
    :  Do Statement While '(' Expression ')'                           { $$ = new DoStatement($2, $5); }
	; 
IfThenStatement
		: IF '(' Expression ')' Statement						        { $$ = new IfStatement($3, $5,null); } 
		;

IfThenElseStatement
		: IF '(' Expression ')' StatementNoShortIf ELSE Statement				{ $$ = new IfStatement($3, $5, $7); } 
		;

IfThenElseStatementNoShortIf
	: IF '(' Expression ')' StatementNoShortIf ELSE StatementNoShortIf		{ $$ = new IfStatement($3, $5, $7); } 
    ;

LabeledStatement
		: IDENTIFIER ':' Statement								      { $$ = new LabeledStatement($1,$3);} 
		;

	Block 
		: '{' BlockStatements_Opt '}'							{ $$ = new BlockStatement($2); } 
;

BlockStatements_Opt
		: BlockStatements										{ $$ = $1; } 
		| /* Empty */											{ $$ = null; } 
;

BlockStatements
		: BlockStatement										{ $$ = new List<Statement> { $1 };} 
		| BlockStatements BlockStatement						{ $$ = $1; $$.Add($2); } 
;
   


BreakStatement
		: BREAK Identifier_opt ';'			{ if($2 == null){$$ = new BreakStatement();} else {$$ = new BreakStatement($2);} } 
; 
ContinueStatement
		: CONTINUE Identifier_opt ';'	    { if($2 == null){$$ = new ContinueStatement();} else {$$ = new ContinueStatement($2);} } 
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

LambdaParameters
	: Identifier
	| '(' FormalParameterList_opt ')'
	| '(' InferredFormalParameterList ')'
	;

FormalParameterList_opt
	: empty
	| FormalParameterList
	| FormalParameterList_opt FormalParameterList
	;

LambdaBody
	: Expression 
	| Block
	;

InferredFormalParameterList
	: Identifier CommaIdentifiers
	;	

CommaIdentifiers		
	: empty
	| CommaIdentifier
	| CommaIdentifiers CommaIdentifier
	;

FormalParameterList
	 : ReceiverParameter
     | FormalParameters ',' LastFormalParameter
     | LastFormalParameter 
	 ;

CommaIdentifier
	: ',' Identifier
	;

LastFormalParameter
	: FormalParameter
	| '{'VariableModifier'}' UnannType '{'Annotation'}' VariableDeclaratorId 
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
	| FloatingPointType
	;

IntegralType
	: Int
	| Byte
	| Short 
	| Long
	| Char 
	;

FloatingPointType
    : Float
	| Double
	;

UnannReferenceType
	: UnannArrayType
	| UnannClassOrInterfaceType
	| UnannTypeVariable
	;

UnannArrayType
	: UnannTypeVariable Dims
	| UnannClassOrInterfaceType Dims
	| UnannPrimitiveType Dims
	;

UnannClassOrInterfaceType
    : ClassType
	| InterfaceType
	;

ClassType
    :                                                     // ClassType in §4 (Types, Values, and Variables)
	;

InterfaceType
    :                                                       // InterfaceType in §4 (Types, Values, and Variables)
	;

UnannTypeVariable
	: Identifier
	;

VariableModifier
	//| Anotation
	: Final
	;

FormalParameters
    :FormalParameter  comma_FormalParameter_opt 
    |ReceiverParameter comma_FormalParameter_opt 
    ; 

comma_FormalParameter_opt
    : empty
	|',' FormalParameter
	| comma_FormalParameter_opt ',' FormalParameter
	;

FormalParameter
	: VariableModifiers UnannType VariableDeclaratorId
	;

VariableModifiers
	: empty
	| VariableModifier
	| VariableModifiers VariableModifier
	;

VariableModifier_opt
    : empty
	| VariableModifier
	| VariableModifier_opt VariableModifier
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

ReceiverParameter
    : Annotations UnannType '[' Identifier '.' ']' This 
	;



SwitchBlockStatementGroup
    : SwitchLabels BlockStatements 
	;

SwitchLabel
    : Case ConstantExpression ':'
    | Case EnumConstantName ':'
    | Default ':'
	;

ConstantExpression
    : Expression	
	;
EnumConstantName
    : Identifier
	;

WhileStatementNoShortIf
   : While '(' Expression ')' StatementNoShortIf                         
   ;

ForStatement
    : BasicForStatement
	| EnhancedForStatement
	;

ForStatementNoShortIf
   : BasicForStatementNoShortIf
   | EnhancedForStatementNoShortIf 
   ; 
BasicForStatementNoShortIf
   : For '(' ForInit_opt  Expression_opt  ForUpdate_opt ')' StatementNoShortIf 
   ;

EnhancedForStatementNoShortIf
    : For '(' VariableModifiers UnannType VariableDeclaratorId ':' Expression ')' StatementNoShortIf 
	;

BasicForStatement
    : For '(' ForInit_opt  Expression_opt  ForUpdate_opt ')' Statement 
	;

ForUpdate_opt
    : empty
	| ForUpdate
	| ForUpdate_opt ForUpdate
	;
ForUpdate 
    : StatementExpressionList
	;


Expression_opt
    : empty
	| Expression
	| Expression_opt Expression
	;


EnhancedForStatement
    :  For '(' VariableModifier_opt UnannType VariableDeclaratorId ':' Expression ')' Statement
	; 

ForInit_opt
    : empty
	| ForInit
    ;

ForInit
    : StatementExpressionList
	| LocalVariableDeclaration
	;

StatementExpressionList
    : StatementExpression Comma_StatementExpression_opt
	;

Comma_StatementExpression_opt
    : empty
	| ',' StatementExpression
	| Comma_StatementExpression_opt ',' StatementExpression
	;

StatementExpression
    :                                                            // AssignmentExpression in §15 (Expressions)
	;


AssignmentExpression
	:                                                                  // AssignmentExpression in §15 (Expressions)            
	;

Assignment
    :                                                                  // AssignmentExpression in §15 (Expressions)            
	;

empty
    : 
	;	

EmptyStatement
	: 
	;

ExpressionStatement
  :
  ;

IfThenElseStatement
  :
  ;

IfThenElseStatementNoShortIf
  :
  ;



BreakStatement
		: 
        ;
IfThenStatement
   :
   ;

ThrowStatement
    :
    ;

TryStatement
	:
    ;

LabeledStatementNoShortIf
   :
   ;

ReturnStatement
   :
   ;

SynchronizedStatement
   :
   ;
%%

public Parser(Scanner scanner) : base(scanner)
{
}