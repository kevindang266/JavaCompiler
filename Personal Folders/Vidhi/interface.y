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

/* Interface Declaration */

NormalInterfaceDeclaration
	:InterfaceModifiers interface Identifier TypeParameters_opt ExtendsInterface_opt
	|InterfaceBody
	;

AnnotationTypeDeclaration
	:Annotation /*Public, Protected, Private*/ InterfaceModifiers interface Identifier TypeParameters_opt ExtendsInterface_opt
	|InterfaceBody
	;

TypeParameters
	:TypeParameterList
	;

TypeParameterList
	:empty
	|TypeParameterList
	|TypeParameterList_opt TypeParameterList
	;

TypeParameter
	:TypeParameterModifiers Identifier TypeBounds
	;

TypeParameterModifier
	:Annotation
	;

TypeBound	
	:extends TypeVariable
	|extends ClassInterfaceType AdditionalBounds
	;

AdditionalBound	
	:InterfaceType
	;

ExtendsInterfaces
	:extends InterfaceTypeList
	;

InterfaceTypeList
	:empty
	|InterfaceType
	|InterfaceType_opt InterfaceType
	;

InterfaceBody
	: '{' InterfaceBodyDeclarations '}'
	;

InterfaceBodyDeclaration:
	:ConstantDeclaration InterfaceMethodDeclaration ClassDEclaration InterfaceDEclaration
	;

ConstanatDEclaration
	:ConstantModifiers UnannType VariableDeclarationList
	;

ConstantModifier
	:Annotation 
	;

VariableDeclaratorList
	//:VariableDeclarator '{' ',' VariableDeclarator'}'
	;

VariableDeclarator
	//:
	;

VariableDeclaratorId
	//:Identifier [Dims]
	;

Dims
	//:{Annotation} [ ] {{Annotation} [ ]}
	;

VariableInitializer
	:Expression ArrayInitializer
	;

InterfaceMethodDeclaration
	:InterfaceModifiers MethodHeader MethodBody
	;

InterfaceMethodModifier
	:Annotation
	;

MethodHeader
	:Result MethodDeclarator Throws_opt
	|TypeParameters Annotations Result MethodDeclarator Throws_opt
	;

Result
	:UnannType
	//|void
	;

MethodDeclarator
	:Identifier FormalParameterList
	|FormalParameterList_opt FormalParameterList
	|Dims_opt
	;

MethodBody
	:Block
	;


