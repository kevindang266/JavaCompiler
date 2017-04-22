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

%start CompilationUnit

%%

/* kevin 22 Apr §4 (Types, Values, and Variables) */

Type
	: PrimitiveType
	| ReferenceType
	;

PrimitiveType
	: Annotations NumericType
	| Annotations Boolean
	;

NumericType
	: IntegralType 
	| FloatingPointType
	;

IntegralType
	: Byte
	| Short
	| Int
	| Long
	| Char
	;

FloatingPointType
	: Float
	| Double
	;

ReferenceType
	: ClassOrInterfaceType
	| TypeVariable
	| ArrayType
	;

ClassOrInterfaceType
	: ClassType
	| InterfaceType
	;

ClassType
	: Annotations Identifier TypeArguments_opt
	| ClassOrInterfaceType '.' Annotations Identifier TypeArguments_opt
	;

InterfaceType
	: ClassType
	;

TypeVariable
	: Annotations Identifier
	;

ArrayType
	: PrimitiveType Dims
	| ClassOrInterfaceType Dims
	| TypeVariable Dims
	;

Dims
	: Annotations '[' ']'
	| Dims AnnotationBrackets
	;

TypeParameter
	: TypeParameterModifiers Identifier TypeBound_opt
	;

TypeParameterModifier
	: Annotation
	;

TypeBound
	: Extends TypeVariable
	| Extends ClassOrInterfaceType AdditionalBounds
	;

AdditionalBound
	: '&' InterfaceType
	;

TypeArguments
	: '<' TypeArgumentList '>'
	;

TypeArgumentList
	: TypeArgument CommaTypeArguments
	;

TypeArgument
	: ReferenceType
	| Wildcard
	;

Wildcard
	: Annotations '?' WildcardBounds_opt
	;

WildcardBounds
	: Extends ReferenceType
	| Super ReferenceType
	;

WildcardBounds_opt
	: empty
	| WildcardBounds
	;

CommaTypeArguments
	: empty
	| ',' TypeArgument
	| CommaTypeArguments ',' TypeArgument
	;

AdditionalBounds
	: empty
	| AdditionalBound
	| AdditionalBounds AdditionalBound
	;

TypeBound_opt
	: empty
	| TypeBound
	;

TypeParameterModifiers
	: empty
	| TypeParameterModifier
	| TypeParameterModifiers TypeParameterModifier
	;

AnnotationBrackets
	: empty
	| Annotations '[' ']'
	;

Dims_opt
	: empty
	| Dims
	;

TypeArguments_opt
	: empty
	| TypeArguments
	;

/* end kevin 22 Apr */

/* kevin 22 Apr §6 (Names) */

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

/* end kevin 22 Apr */

/* kevin 22 Apr §7 (Packages) */

CompilationUnit
	: PackageDeclaration_opt ImportDeclarations TypeDeclarations
	;

PackageDeclaration
	: PackageModifiers Package Identifier DotIdentifiers ';'
	;

PackageModifier
	: Annotation
	;

ImportDeclaration
	: SingleTypeImportDeclaration
	| TypeImportOnDemandDeclaration
	| SingleStaticImportDeclaration
	| StaticImportOnDemandDeclaration
	;

SingleTypeImportDeclaration
	: Import TypeName ';'
	;

TypeImportOnDemandDeclaration
	: Import PackageOrTypeName '.' '*' ';'
	;

SingleStaticImportDeclaration
	: Import Static TypeName '.' Identifier ';'
	;

StaticImportOnDemandDeclaration
	: Import Static TypeName '.' '*' ';'
	;

PackageModifiers
	: empty
	| PackageModifier
	| PackageModifiers PackageModifier
	;

TypeDeclaration
	: ClassDeclaration
	| InterfaceDeclaration 
	| ';'
	;

DotIdentifiers
	: empty
	| '.' Identifier
	| DotIdentifiers '.' Identifier
	;

PackageDeclaration_opt
	: empty
	| PackageDeclaration
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

/* end kevin 22 Apr */

/* kevin 21 Apr §8 (Classes) */

ClassDeclaration
	: NormalClassDeclaration					
	| EnumDeclaration
	;

NormalClassDeclaration
	: ClassModifiers Class Identifier TypeParameters_opt Superclass_opt Superinterfaces_opt ClassBody
	;

ClassModifier 
	: Annotation
	| Public
	| Protected
	| Private
	| Abstract
	| Static
	| Final
	| Strictfp
	;

TypeParameters
	: '<' TypeParameterList '>'
	;

TypeParameterList
	: TypeParameter CommaTypeParameters
	;

Superclass
	: Extends ClassType
	;

Superinterfaces
	: Implements InterfaceTypeList
	;

InterfaceTypeList
	: InterfaceType CommaInterfaceTypes
	;

ClassBody
	: '{' ClassBodyDeclarations '}'	
	;

ClassBodyDeclaration
	: ClassMemberDeclaration
	| InstanceInitializer
	| StaticInitializer
	| ConstructorDeclaration
	;

ClassMemberDeclaration
	: MethodDeclaration  
	| FieldDeclaration 
	| ClassDeclaration
	| InterfaceDeclaration 
	| ';'
	;

FieldDeclaration
	: FieldModifiers UnannType VariableDeclaratorList ';'
	;

FieldModifier
	: Annotation
	| Public
	| Protected
	| Private
	| Static
	| Final
	| Transient
	| Volatile
	;

VariableDeclaratorList
	: VariableDeclarator CommaVariableDeclarator_opt
	;

VariableDeclarator
	: VariableDeclaratorId EqualVariableInitializer_opt
	;

VariableDeclaratorId
	: Identifier Dims_opt
	;

VariableInitializer
	: Expression
	| ArrayInitializer
	;

UnannType
	: UnannPrimitiveType
	| UnannReferenceType
	;

UnannPrimitiveType
	: NumericType 
	| Boolean
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
	: Identifier TypeArguments_opt
	| UnannClassOrInterfaceType '.' Annotations Identifier TypeArguments_opt
	;

UnannInterfaceType
	: UnannClassType
	;

UnannTypeVariable
	: Identifier
	;

UnannArrayType
	: UnannPrimitiveType Dims
	| UnannClassOrInterfaceType Dims
	| UnannTypeVariable Dims
	;

MethodDeclaration
	: MethodModifiers MethodHeader MethodBody
	;

MethodModifier
	: Annotation
	| Public
	| Protected
	| Private
	| Abstract
	| Static
	| Final
	| Synchronized
	| Native
	| Strictfp
	;

MethodHeader
	: Result MethodDeclarator Throws_opt
	| TypeParameters Annotations Result MethodDeclarator Throws_opt
	;

Result
	: UnannType
	| Void
	;

MethodDeclarator
	: Identifier '(' FormalParameterList_opt ')' Dims_opt
	;

FormalParameterList
	: ReceiverParameter
	| FormalParameters ',' LastFormalParameter
	| LastFormalParameter
	;

FormalParameters
	: FormalParameter CommaFormalParameters
	| ReceiverParameter CommaFormalParameters
	;

FormalParameter
	: VariableModifiers UnannType VariableDeclaratorId
	;

VariableModifier
	: Annotation
	| Final
	;

LastFormalParameter
	: VariableModifiers UnannType Annotations VariableArguments VariableDeclaratorId 
	| FormalParameter
	;

ReceiverParameter
	: Annotations UnannType IdentifierDot_opt This
	;

ThrowsNotKeyWord
	: Throws ExceptionTypeList
	;

ExceptionTypeList
	: ExceptionType CommaExceptionTypes
	;

ExceptionType
	: ClassType
	| TypeVariable
	;

MethodBody
	: Block
	| ';'
	;

InstanceInitializer
	: Block
	;

StaticInitializer
	: Static Block
	;

ConstructorDeclaration
	: ConstructorModifiers ConstructorDeclarator Throws_opt ConstructorBody
	;

ConstructorModifier
	: Annotation
	| Public
	| Protected
	| Private
	;

ConstructorDeclarator
	: TypeParameters_opt SimpleTypeName '(' FormalParameterList_opt ')'
	;

SimpleTypeName
	: Identifier
	;

ConstructorBody
	: '{' ExplicitConstructorInvocation_opt BlockStatements_opt '}'
	;

ExplicitConstructorInvocation
	: TypeArguments_opt This '(' ArgumentList_opt ')' ';'
	| TypeArguments_opt Super '(' ArgumentList_opt ')' ';'
	| ExpressionName '.' TypeArguments_opt Super '(' ArgumentList_opt ')' ';'
	| Primary '.' TypeArguments_opt Super '(' ArgumentList_opt ')' ';'
	;

EnumDeclaration
	: ClassModifiers Enum Identifier Superinterfaces_opt EnumBody
	;

EnumBody
	: '{' EnumConstantList_opt Comma_opt EnumBodyDeclarations_opt '}'
	;

EnumConstantList
	: EnumConstant CommaEnumConstants
	;

EnumConstant
	: EnumConstantModifiers Identifier ParenthesisArgumentList_opt ClassBody_opt
	;

EnumConstantModifier
	: Annotation
	;

EnumBodyDeclarations
	: ';' ClassBodyDeclarations
	;

EnumBodyDeclarations_opt
	: empty
	| EnumBodyDeclarations
	;

EnumConstantModifiers
	: empty
	| EnumConstantModifier
	| EnumConstantModifiers EnumConstantModifier
	;

ClassBody_opt
	: empty
	| ClassBody
	;

ParenthesisArgumentList_opt
	: empty
	| '(' ArgumentList_opt ')'
	;

CommaEnumConstants
	: empty
	| ',' EnumConstant
	| CommaEnumConstants ',' EnumConstant
	;

EnumConstantList_opt
	: empty
	| EnumConstantList
	;

ExplicitConstructorInvocation_opt
	: empty
	| ExplicitConstructorInvocation
	;

ConstructorModifiers
	: empty
	| ConstructorModifier
	| ConstructorModifiers ConstructorModifier
	;

CommaExceptionTypes
	: empty
	| ',' ExceptionType
	| CommaExceptionTypes ',' ExceptionType
	;

IdentifierDot_opt
	: empty
	| Identifier '.'
	;

CommaFormalParameters
	: empty
	| ',' FormalParameter
	| CommaFormalParameters ',' FormalParameter
	;

FormalParameterList_opt
	: empty
	| FormalParameterList
	;

Throws_opt
	: empty
	| ThrowsNotKeyWord
	;

MethodModifiers
	: MethodModifier
	| MethodModifiers MethodModifier
	| empty
	;

EqualVariableInitializer_opt
	: empty
	| '=' VariableInitializer
	;

CommaVariableDeclarator_opt
	: empty
	| ',' VariableDeclarator
	| CommaVariableDeclarator_opt ',' VariableDeclarator
	;

FieldModifiers
	: empty
	| FieldModifier
	| FieldModifiers FieldModifier
	;

ClassBodyDeclarations	
	: empty
	| ClassBodyDeclaration
	| ClassBodyDeclarations ClassBodyDeclaration 
	;

CommaInterfaceTypes
	: empty
	| ',' InterfaceType
	| CommaInterfaceTypes ',' InterfaceType
	;

CommaTypeParameters
	: empty
	| ',' TypeParameter
	| CommaTypeParameters ',' TypeParameter
	;

TypeParameters_opt
	: empty
	| TypeParameters
	;

Superinterfaces_opt
	: empty
	| Superinterfaces
	;

Superclass_opt
	: empty
	| Superclass
	;

ClassModifiers
	: empty										
	| ClassModifier	
	| ClassModifiers ClassModifier				
	;

VariableModifiers
	: empty
	| VariableModifier
	| VariableModifiers VariableModifier
	;

/* end kevin 21 Apr */

/* kevin 21 Apr §9 (Interfaces) */

InterfaceDeclaration
	: NormalInterfaceDeclaration
	| AnnotationTypeDeclaration
	;

NormalInterfaceDeclaration
	: InterfaceModifiers Interface Identifier TypeParameters_opt ExtendsInterfaces_opt InterfaceBody
	;

InterfaceModifier
	: Annotation
	| Public
	| Protected
	| Private
	| Abstract
	| Static
	| Strictfp
	;

ExtendsInterfaces
	: Extends InterfaceTypeList
	;

InterfaceBody
	: '{' InterfaceMemberDeclarations '}'
	;

InterfaceMemberDeclaration
	: ConstantDeclaration
	| InterfaceMethodDeclaration
	| ClassDeclaration
	| InterfaceDeclaration
	| ';'
	;

ConstantDeclaration
	: ConstantModifiers UnannType VariableDeclaratorList ';'
	;

ConstantModifiers
	: empty
	| ConstantModifier
	| ConstantModifiers ConstantModifier
	;

ConstantModifier
	: Annotation
	| Public
	| Abstract
	| Default
	| Static
	| Strictfp
	;

InterfaceMethodDeclaration
	: InterfaceMethodModifiers MethodHeader MethodBody
	;

InterfaceMethodModifier
	: Annotation
	| Public
	| Abstract
	| Default
	| Static
	| Strictfp
	;

AnnotationTypeDeclaration
	: InterfaceModifiers '@' Interface Identifier AnnotationTypeBody
	;

AnnotationTypeBody
	: '{' AnnotationTypeMemberDeclarations '}'
	;

AnnotationTypeMemberDeclaration
	: AnnotationTypeElementDeclaration
	| ConstantDeclaration
	| ClassDeclaration
	| InterfaceDeclaration 
	| ';'
	;

AnnotationTypeElementDeclaration
	: AnnotationTypeElementModifiers UnannType Identifier '(' ')' Dims_opt DefaultValue_opt ';'
	;

AnnotationTypeElementModifier
	: Annotation
	| Public
	| Abstract
	;

DefaultValue
	: Default ElementValue
	;

Annotation
	: NormalAnnotation
	| MarkerAnnotation
	| SingleElementAnnotation
	;

NormalAnnotation
	: '@' TypeName '(' ElementValuePairList_opt ')'
	;

ElementValuePairList
	: ElementValuePair CommaElementValuePairs
	;

ElementValuePair
	: Identifier '=' ElementValue
	;

ElementValue
	: ConditionalExpression
	| ElementValueArrayInitializer
	| Annotation
	;

ElementValueArrayInitializer
	: '{' ElementValueList_opt Comma_opt '}'
	;

ElementValueList
	: ElementValue CommaElementValues
	;

MarkerAnnotation
	: '@' TypeName
	;

SingleElementAnnotation
	: '@' TypeName '(' ElementValue ')'
	;

ElementValueList_opt
	: empty
	| ElementValueList
	;

CommaElementValues
	: empty
	| ',' ElementValue
	| CommaElementValues ElementValue
	;

DefaultValue_opt
	: empty
	| DefaultValue
	;

CommaElementValuePairs
	: empty
	| ',' ElementValuePair
	| CommaElementValuePairs ',' ElementValuePair
	;

ElementValuePairList_opt
	: empty
	| ElementValuePairList
	;

Annotations
	: empty
	| Annotation
	| Annotations Annotation
	;

AnnotationTypeElementModifiers
	: empty
	| AnnotationTypeElementModifier
	| AnnotationTypeElementModifiers AnnotationTypeElementModifier
	;

InterfaceMethodModifiers
	: empty
	| InterfaceMethodModifier
	| InterfaceMethodModifiers InterfaceMethodModifier
	;

InterfaceMemberDeclarations
	: empty
	| InterfaceMemberDeclaration
	| InterfaceMemberDeclarations InterfaceMemberDeclaration
	;

InterfaceModifiers
	: empty
	| InterfaceModifier
	| InterfaceModifiers InterfaceModifier
	;

ExtendsInterfaces_opt
	: empty
	| ExtendsInterfaces
	;

AnnotationTypeMemberDeclarations
	: empty
	| AnnotationTypeMemberDeclaration
	| AnnotationTypeMemberDeclarations AnnotationTypeMemberDeclaration
	;

/* end kevin 21 Apr */

/* kevin 21 Apr §10 (Arrays) */

ArrayInitializer
	: '{' VariableInitializerList_opt Comma_opt '}'
	;

VariableInitializerList
	: VariableInitializer CommaVariableInitializers
	;

CommaVariableInitializers
	: empty
	| ',' VariableInitializer
	| CommaVariableInitializers ',' VariableInitializer
	;

VariableInitializerList_opt
	: empty
	| VariableInitializerList
	;

Comma_opt
	: empty
	| ','
	;

/* end kevin 21 Apr */

/* kevin 21 Apr §14 (Blocks and Statements) */

Block
	: '{' BlockStatements_opt '}'
	;

BlockStatements_opt
	: empty
	| BlockStatements_man 
	;

BlockStatements
	: empty
	| BlockStatement
	| BlockStatements BlockStatement
	;

BlockStatements_man
	: BlockStatement BlockStatements
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

AssertStatement 
	: Assert Expression ';'
	| Assert Expression ':' Expression ';'
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

SwitchBlockStatementGroup
	: SwitchLabels_man BlockStatements_man
	;

SwitchLabels			
	: empty
	| SwitchLabel
	| SwitchLabels SwitchLabel
	;

SwitchLabels_man			// custom mandatory
	: SwitchLabel SwitchLabels
	;

SwitchLabel
	: Case ConstantExpression ':'
	| Case EnumConstantName ':'
	| Default ':'
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
	: For '(' ForInit_opt ';' Expression_opt ';' ForUpdate_opt ')' Statement
	;

BasicForStatementNoShortIf
	: For '(' ForInit_opt ';' Expression_opt ';' ForUpdate_opt ')' StatementNoShortIf
	;

ForInit_opt
	: empty
	| ForInit
	;

ForInit
	: StatementExpressionList
	| LocalVariableDeclaration
	;

ForUpdate_opt
	: empty
	| ForUpdate
	;

ForUpdate
	: StatementExpressionList
	;

StatementExpressionList
	: StatementExpression CommaStatementExpressions
	;

EnhancedForStatement
	: For '(' VariableModifiers UnannType VariableDeclaratorId ':' Expression ')' Statement
	;

EnhancedForStatementNoShortIf
	: For '(' VariableModifiers UnannType VariableDeclaratorId ':' Expression ')' StatementNoShortIf
	;

BreakStatement
	: Break Identifier_opt ';'
	;

ContinueStatement
	: Continue Identifier_opt ';'
	;

ReturnStatement
	: Return Expression_opt ';'
	;

ThrowStatement
	: Throw Expression ';'
	;

SynchronizedStatement
	: Synchronized '(' Expression ')' Block
	;

TryStatement
	: Try Block Catches_man 
	| Try Block Catches_opt FinallyNotKeyWord		// make up
	| TryWithResourcesStatement
	;

Catches_opt
	: empty
	| Catches_man
	;

CatchClauses
	: empty
	| CatchClause
	| CatchClauses CatchClause
	;

Catches_man				// custom mandatory
	: CatchClause CatchClauses
	;

CommaStatementExpressions
	: empty
	| ',' StatementExpression
	| CommaStatementExpressions ',' StatementExpression
	;

CatchClause
	: Catch '(' CatchFormalParameter ')' Block
	;

CatchFormalParameter
	: VariableModifiers CatchType VariableDeclaratorId
	;

CatchType
	: UnannClassType VerticalClassType			// UnannClassType in §8 (Classes)
	;

FinallyNotKeyWord_opt
	: empty
	| FinallyNotKeyWord
	;

FinallyNotKeyWord
	: Finally Block
	;

TryWithResourcesStatement
	: Try ResourceSpecification Block Catches_opt FinallyNotKeyWord_opt
	;

ResourceSpecification
	: '(' ResourceList Semicolon_opt ')'
	;

ResourceList
	: Resource SemicolonResources
	;

SemicolonResources
	: empty
	| ';' Resource
	| SemicolonResources ';' Resource
	;

Resource
	: VariableModifiers UnannType VariableDeclaratorId '=' Expression
	;

Semicolon_opt
	: empty
	| ';'
	;

VerticalClassType
	: empty
	| '|' ClassType
	| VerticalClassType '|' ClassType			// UnannClassType in §4 (Types, Values, and Variables)
	;

Identifier_opt
	: empty
	| Identifier
	;

Expression_opt
	: empty
	| Expression
	;

/* end kevin 21 Apr */

/* kevin 15 Apr §15 (Expressions) */

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

UnqualifiedClassInstanceCreationExpression
	: New TypeArguments_opt ClassOrInterfaceTypeToInstantiate '(' ArgumentList_opt ')' ClassBody_opt	// TypeArguments_opt in §4 (Types, Values, and Variables) , ClassBody_opt in §8 (Classes)
	;

ClassOrInterfaceTypeToInstantiate
	: Annotations Identifier DotAnnotationIdentifiers TypeArgumentsOrDiamond_opt				// Annotation in §9 (Interfaces)
	;

TypeArgumentsOrDiamond_opt
	: empty
	| TypeArgumentsOrDiamond
	;

TypeArgumentsOrDiamond
	: TypeArguments					// TypeArguments_opt in §4 (Types, Values, and Variables)
	| '<' '>'
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

ArgumentList_opt
	: empty
	| ArgumentList
	;

ArgumentList
	: Expression CommaExpressions
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

InferredFormalParameterList
	: Identifier CommaIdentifiers
	;

LambdaBody
	: Expression 
	| Block
	;

AssignmentExpression
	: ConditionalExpression 
	| Assignment
	;
	
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

ConstantExpression
	: Expression
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

DotAnnotationIdentifiers
	: empty
	| DotAnnotationIdentifier
	| DotAnnotationIdentifiers DotAnnotationIdentifier
	;

DotAnnotationIdentifier
	: '.' Annotations Identifier
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

/* end kevin 15 Apr */

empty : ;

%%

public Parser(Scanner scanner) : base(scanner)
{
}