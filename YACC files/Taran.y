%namespace Yfile
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
%left '('
%right ')'
%nonassoc ':'

%%
/* Tarandeep Blocks and Statements and Names */
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
	//| ClassDeclaration 
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
	: //Final
	//| Annotation
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
	| Long
	| Char
	| Byte
	| Short
	;

FloatingPointType
    : Float
	| Double
	;

UnannReferenceType
       : UnannClassOrInterfaceType 
       | UnannTypeVariable 
       | UnannArrayType 
       ;

UnannClassOrInterfaceType
    : UnannClassType 
    | UnannInterfaceType 
	;
UnannClassType
    : empty
    //| Identifier [TypeArguments] 
  // | UnannClassOrInterfaceType . {Annotation} Identifier [TypeArguments] 
   ;

UnannInterfaceType
   : UnannClassType 
   ;

UnannTypeVariable
   : Identifier
   ;
  
UnannArrayType
    : empty
    // |UnannPrimitiveType Dims 
   //| UnannClassOrInterfaceType Dims 
   //| UnannTypeVariable Dims  
   ;

VariableDeclaratorList
	: VariableDeclarator ',' VariableDeclarators
	;

VariableDeclarators
	: empty
	| VariableDeclarator
	| VariableDeclarators ',' VariableDeclarator
	;

VariableDeclarator
	: VariableDeclaratorId
	| VariableDeclaratorId '=' VariableInitializer
	;

VariableDeclaratorId
    : Identifier Dims_opt 
    | VariableInitializer
	;

Dims_opt
 :
 ;

VariableInitializer
     : Expression 
    // |ArrayInitializer 
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
     : Identifier ':' Statement 
     ;

LabeledStatementNoShortIf
     : Identifier ':' StatementNoShortIf 
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
    | ClassInstanceCreationExpression 
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

AssertStatement  // To be implemented
     :
	 ;
SwitchStatement
      :
	  ; 
DoStatement 
      :
	   ;
BreakStatement
      :
	  ; 
ContinueStatement
     : 
	 ; 
ReturnStatement
     :
	  ; 
SynchronizedStatement 
     : 
	 ;
ThrowStatement
     : 
	 ; 
TryStatement
     :
	  ; 
WhileStatementNoShortIf 
      : 
	  ;
ForStatementNoShortIf 
     : 
	  ;
WhileStatement
     : 
	  ; 
ForStatement 
      : 
	  ;
Assignment
     : 
	  ;
PreIncrementExpression 
    : 
	 ;
PreDecrementExpression
     : 
	 ;
PostIncrementExpression
    : 
	 ;
PostDecrementExpression 
     :
	  ;
MethodInvocation 
    : 
	 ;
ClassInstanceCreationExpression
     :
	  ;
Expression      // To be implemented
    :
    ;
	/* Names */
TypeName 
         : Identifier 
         | PackageOrTypeName '.' Identifier
         ;

PackageOrTypeName 
         : Identifier 
         | PackageOrTypeName '.' Identifier 
         ;

ExpressionName 
         : Identifier 
         | AmbiguousName '.' Identifier 
         ;

MethodName 
         : Identifier 
         ;

PackageName 
         : Identifier 
         | PackageName '.' Identifier
	     ;

AmbiguousName 
         : Identifier 
         | AmbiguousName '.' Identifier
         ; 
empty
    : 
	 ;	

%%

public Parser(Scanner scanner) : base(scanner)
{
}

