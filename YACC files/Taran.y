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


%%
// Names (Tarandeep Kaur)

TypeName 
         : Identifier 
         | PackageOrTypeName '.' Identifier
         ;

PackageOrTypeName 
         : Identifier 
         |PackageOrTypeName '.' Identifier 
         ;

ExpressionName 
         : Identifier 
         |AmbiguousName '.' Identifier 
         ;

MethodName 
         : Identifier 
         ;

PackageName 
         : Identifier 
         |PackageName '.' Identifier
	 ;

AmbiguousName 
         : Identifier 
         |AmbiguousName '.' Identifier
         ; 


// Blocks and statement (Taran)
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
   : //Identifier [TypeArguments] 
  // | UnannClassOrInterfaceType . {Annotation} Identifier [TypeArguments] 
  /* to be done */
  ;
UnannInterfaceType
   : UnannClassType 
   ;
UnannTypeVariable
   : Identifier
   ;
  
UnannArrayType
   //: UnannPrimitiveType Dims 
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
VariableInitializer
    // : Expression 
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

StatementWithoutTrailingSubstatement:
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
     : if '(' Expression ')' Statement 
	 ;

IfThenElseStatement:
     : if '(' Expression ')' StatementNoShortIf else Statement 
	 ;

IfThenElseStatementNoShortIf:
     : if '(' Expression ')' StatementNoShortIf else StatementNoShortIf 
	 ;


%%

public Parser(Scanner scanner) : base(scanner)
{
}
