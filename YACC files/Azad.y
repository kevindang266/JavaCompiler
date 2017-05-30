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
		BitwiseInclusiveOr BitwiseExclusiveOr ModulusAnd LeftShiftAnd RightShiftAnd ShiftRightZeroFill TypeName 
		
%left '='
%nonassoc '<'
%left '+'
%left '('
%right ')'
%nonassoc ':'
%%



/* hiral  (block & Statement) */



AssertStatement
    : Assert Expression 
    | Assert Expression ':' Expression 
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

SwitchStatement
    : Switch '(' Expression ')' SwitchBlock 	
	;

SwitchBlock
    : '{' SwitchBlockStatementGroups SwitchLabels '}'	
	; 

SwitchBlockStatementGroups
    : empty
	| SwitchBlockStatementGroup
	| SwitchBlockStatementGroups SwitchBlockStatementGroup
	;

SwitchLabels
    : empty
	| SwitchLabel
	| SwitchLabels SwitchLabel
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

WhileStatement
    : While '(' Expression ')' Statement 
	;

WhileStatementNoShortIf
   : While '(' Expression ')' StatementNoShortIf 
   ;

DoStatement
    :  Do Statement While '(' Expression ')' 
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

Block
   :
   ;

BlockStatements
   :
   ;

BlockStatement
   :
   ;
   
LocalVariableDeclarationStatement
   :
   ;

LocalVariableDeclaration
   :
   ;

BreakStatement
      :
	  ; 
ContinueStatement
     : 
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

LabeledStatement
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
