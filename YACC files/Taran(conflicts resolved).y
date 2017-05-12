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
		Throw Throws Transient Try Void Volatile While BooleanLiteral NullLiteral IntegerLiteral
		CharacterLiteral StringLiteral FloatingPointLiteral VariableArguments
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
	| ClassBodyDeclarations	ClassBodyDeclaration		
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

MethodHeader
	: Result MethodDeclarator								
	;

MethodBody
	: Block													
	| ';'
	;
	
Modifiers
	: Modifiers Modifier		 							
	| /* empty */											
	;

Modifier
	: Public											
	| Protected												
	| Final												
	| Static												
	;

Result
	: Void												
	| UnannType 
	;

MethodDeclarator
	: Identifier '(' FormalParameterList ')' Dims_opt		
	;

FormalParameterList
	: /* empty */								
        | FormalParameterList FormalParameter
	;

FormalParameter
	: Modifiers UnannType VariableDeclaratorId			
	;

/* Tarandeep Blocks and Statements and Names */

Block
	: '{' BlockStatements '}'
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
	: UnannType VariableDeclaratorList 
	| VariableModifiers UnannType VariableDeclaratorList
	;

VariableModifiers
	: Modifier
	| VariableModifiers Modifier
	;

//VariableModifier
    //      : Final
	//| Annotation
//	;

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
	: UnannArrayType										
	;

UnannArrayType
	: UnannTypeVariable Dims								
	;

UnannTypeVariable
	: Identifier											
	;

VariableDeclaratorList
	: VariableDeclarator ',' VariableDeclarators
	;

VariableDeclarators
	: VariableDeclarator
	| VariableDeclarators ',' VariableDeclarator
	;

VariableDeclarator
	: VariableDeclaratorId
	| VariableDeclaratorId '=' VariableInitializer
	;

VariableDeclaratorId
    : Identifier Dims_opt 
    //| VariableInitializer
    ;

Dims_opt
	: /* empty */
	| Dims
	;

Dims
	: '[' ']'
	| '[' ']' Dims
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
     // | WhileStatement 
      //| ForStatement 	
      ;

StatementNoShortIf
     : StatementWithoutTrailingSubstatement 
     | LabeledStatementNoShortIf 
     | IfThenElseStatementNoShortIf 
   //  | WhileStatementNoShortIf 
   //  | ForStatementNoShortIf
     ;

StatementWithoutTrailingSubstatement
    : Block 
    | EmptyStatement 
    | ExpressionStatement 
    /*| AssertStatement 
    | SwitchStatement 
    | DoStatement 
    | BreakStatement 
    | ContinueStatement 
    | ReturnStatement 
    | SynchronizedStatement 
    | ThrowStatement 
    | TryStatement */
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

Expression      
    : AssignmentExpression
    ;

Assignment
     : LeftHandSide AssignmentOperator Expression
	 ;

LeftHandSide
	: ExpressionName										
	;

AssignmentOperator
	: '='
	| '+'
	;

AssignmentExpression
	: Assignment												
	| Literal
	;

Literal
   : IntegerLiteral
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
         //| AmbiguousName '.' Identifier 
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
	
%%

public Parser(Scanner scanner) : base(scanner)
{
}

