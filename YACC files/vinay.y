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

/* vinay Packages and arrays */

CompilationUnit
	: PackageDeclaration_opt ImportDeclarations TypeDeclarations
	;

PackageDeclaration_opt
	: empty
	| PackageDeclaration
	;


PackageDeclaration
	:PackageModifiers package Identifier DotIdentifiers
	;

DotIdentifiers // custom Name
	: empty
	| '.' Identifier 
	| DotIdentifiers '.' Identifier
	;

ImportDeclarations
	: empty 
	| ImportDeclaration
	| ImportDeclarations ImportDeclaration
	;

ImportDeclaration
	: SingleTypeImportDeclaration 
	| TypeImportOnDemandDeclaration 
	| SingleStaticImportDeclaration 
	| StaticImportOnDemandDeclaration
	;

TypeDeclarations
	: empty 
	| TypeDeclaration
	| TypeDeclarations TypeDeclaration
	;

TypeDeclaration
	: ClassDeclaration
	| InterfaceDeclaration 
	| ';'
	;

SingleTypeImportDeclaration 
	: import TypeName
	;

TypeImportOnDemandDeclaration
	: import TypeName '.' '*'
	;

SingleStaticImportDeclaration
	: import static TypeName '.' Identifier
	;

StaticImportOnDemandDeclaration
	: import static TypeName '.' '*' 
	;

ArrayInitializer
	: '{' VariableInitializerList_opt Comma_opt '}' 
	;

VariableInitializerList_opt
	: empty
	| VariableInitializerList
	;

Comma_opt	// custom name
	: empty
	| ',' 
	;

VariableInitializerList
	: VariableInitializer CommaVariableInitializers
	;

CommaVariableInitializers // custom name
	: empty
	| ',' VariableInitializer
	| CommaVariableInitializers ',' VariableInitializer
	;

VariableInitializer
	: Expression 
	| ArrayInitializer
	;

Expression 
	: LambdaExpression 
	| AssignmentExpression
	;

LambdaExpression 
	:
	;
import
	:
	;

InterfaceDeclaration
	:
	;

PackageModifiers
	:
	;

package
	:
	;

static
	:
	;

TypeName
	:
	;

empty : ;

%%

public Parser(Scanner scanner) : base(scanner)
{
}
