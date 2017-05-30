
  %visibility internal
  
 -%option stack, classes, minimize, parser, verbose, out:javaCompilerScanner.cs
 -
  Eol             (\r\n?|\n)
  NotWh           [^ \t\r\n]
  Space           [ \t]
 @@ -20,7 +18,6 @@ Static      	static
  Void        	void
  Main			main
  Class			class
 -Dim				Dim
  Bool			bool
  Int				int
  String			string
 @@ -43,16 +40,18 @@ OpSqLBr			"["
  OpSqRBr			"]"
  LeftPar			"("
  RigthPar		")"
 +OpLtBrace		"{"
 +OpRtBrace		"}"
 +SemiColon		";"
  %%
 -{letter}({letter}|{digit})*		{ yylval.text = yytext; return (int)Tokens.IDENTIFIER; }
 +{Letter}({Letter}|{Digit})*		{ yylval.text = yytext; return (int)Tokens.IDENTIFIER; }
  {IntegerLiteral}				{ yylval.num = int.Parse(yytext); return (int)Tokens.INTEGERLITERAL; }
  {Bool}							{ yylval.Bool = yytext; return (int)Tokens.BOOL; }
  {Public}						{ return (int)Tokens.PUBLIC; }
  {Static}						{ return (int)Tokens.STATIC; }
  {Void}							{ return (int)Tokens.VOID; }
  {Main}							{ return (int)Tokens.MAIN; }
  {Class}							{ return (int)Tokens.CLASS; }
 -{Dim}							{ return (int) Tokens.DIM; }	
  {Bool}							{ return (int) Tokens.BOOL; }
  {Int}							{ return (int) Tokens.INT; }
  {String}						{ return (int) Tokens.STRING; }
 @@ -75,4 +74,7 @@ RigthPar		")"
  {RigthPar}						{ return (int) Tokens.OP_RIGHT_PAR; }
  {OpSqLBr}						{ return (int) Tokens.OP_SQ_L_BR; }
  {OpSqRBr}						{ return (int) Tokens.OP_SQ_R_BR; }
 +{OpLtBrace}						{ return (int) Tokens.OP_LT_BRACE; }
 +{OpRtBrace}						{ return (int) Tokens.OP_RT_BRACE; }
 +{SemiColon}						{ return (int) Tokens.SEMICOLON; }
  %% 
View  
161  lex/javaCompiler.y
 @@ -15,14 +15,15 @@
  %token VOID
  %token MAIN
  %token CLASS
 -%token DIM
  %token BOOL
  %token INT
  %token STRING
  %token OP_LEFT_PAR
 +%token OP_RIGHT_PAR
  %token OP_SQ_L_BR
  %token OP_SQ_R_BR
 -
 +%token OP_LT_BRACE OP_RT_BRACE
 +%token SEMICOLON
  //left associated operands
  %left OP_ASSIGN
  %left OP_ADD OP_MINUS
 @@ -36,105 +37,121 @@
  %left OP_LT
  %left OP_GT
  %left OP_GT_EQ
 -%left OP_LT_EQ
 +%left OP_LT_EQ 
  
  %start CompilationUnit
  // YACC Rules
  %%
 -CompilationUnit
 -	: ProgramFile
 -        ;
 +CompilationUnit					:TypeDeclaration
 +								;
 +TypeDeclaration					:ClassDeclaration
 +								;
 +ClassDeclaration				:NormalClassDeclaration
 +								;
 +NormalClassDeclaration			: ClassModifier CLASS IDENTIFIER ClassBody
 +								| CLASS IDENTIFIER ClassBody
 +								;
 +ClassModifier					:PUBLIC
 +								;
 +ClassBody						: OP_LT_BRACE ClassBodyDeclaration OP_RT_BRACE
 +								;
 +ClassBodyDeclaration			:ClassMemberDeclaration
 +								;
 +ClassMemberDeclaration			:MethodDeclaration 
 +								;
 +MethodDeclaration				: MethodModifier MethodHeader MethodBody
 +								|MethodHeader MethodBody;
 +MethodModifier					:PUBLIC STATIC
 +								;
 +MethodHeader					:Result MethodDeclarator
 +								;
 +Result							:VOID;
 +MethodDeclarator				:IDENTIFIER OP_LEFT_PAR FormalParameterList OP_RIGHT_PAR
 +								|IDENTIFIER OP_LEFT_PAR OP_RIGHT_PAR
 +								;
 +FormalParameterList				:LastFormalParameter
 +								;
 +LastFormalParameter				:FormalParameter
 +								;
 +FormalParameter					:UnannType VariableDeclaratorId
 +								;
 +UnannType						:UnannReferenceType
 +								|UnannPrimitiveType
 +								;
 +UnannReferenceType				:UnannArrayType
 +								;
 +UnannArrayType					:UnannTypeVariable Dims
 +								;
 +UnannTypeVariable				:IDENTIFIER;
  
 -ProgramFile						: PackageStatement ImportStatements TypeDeclarations
 -								| PackageStatement ImportStatements
 -								| PackageStatement                  TypeDeclarations
 -								|                  ImportStatements TypeDeclarations
 -								| PackageStatement
 -								|                  ImportStatements
 -								|                                   TypeDeclarations
 +Dims							:OP_SQ_L_BR OP_SQ_R_BR
 +								;
 +MethodBody						:Block
 +								;
 +Block							: OP_LT_BRACE BlockStatements OP_RT_BRACE
 +								;
 +BlockStatements					:BlockStatement
  								;
 -ConditionalExpression			:ConditionalOrExpression
 -								|ConditionalOrExpression ? Expression : ConditionalExpression 
 -								|ConditionalOrExpression ? Expression : LambdaExpression 
 +BlockStatement					:LocalVariableDeclarationStatement
  								;
 -ConditionalOrExpression			:ConditionalAndExpression
 -								|ConditionalOrExpression || ConditionalAndExpression
 +LocalVariableDeclarationStatement: LocalVariableDeclaration SEMICOLON
  								;
 +LocalVariableDeclaration		:UnannType VariableDeclaratorList
 +								;
 +UnannPrimitiveType				:NumericType
 +								;
 +NumericType						:IntegralType
 +								;
 +IntegralType					:INT;
  
 -ConditionalAndExpression		:InclusiveOrExpression
 -								|ConditionalAndExpression && InclusiveOrExpression
 +VariableDeclaratorList			:VariableDeclarator
 +								;
 +VariableDeclarator				:VariableDeclaratorId OP_EQU VariableInitializer
  								;
 -InclusiveOrExpression			:ExclusiveOrExpression 
 -								|InclusiveOrExpression | ExclusiveOrExpression
 +VariableDeclaratorId			:IDENTIFIER
  								;
 -ExclusiveOrExpression			:AndExpression
 -								|ExclusiveOrExpression ^ AndExpression
 +VariableInitializer				:Expression
  								;
 -AndExpression					:EqualityExpression
 -								|AndExpression & EqualityExpression
 +Expression						:AssignmentExpression
  								;
 -EqualityExpression				:RelationalExpression
 -								|EqualityExpression == RelationalExpression
 -								|EqualityExpression != RelationalExpression
 +AssignmentExpression			:ConditionalExpression
  								;
 -RelationalExpression			:ShiftExpression 
 -								|RelationalExpression < ShiftExpression 
 -								|RelationalExpression > ShiftExpression 
 -								|RelationalExpression <= ShiftExpression 
 -								|RelationalExpression >= ShiftExpression 
 -								|RelationalExpression instanceof ReferenceType
 +ConditionalExpression			: ConditionalOrExpression
  								;
 -ShiftExpression					:AdditiveExpression 
 -								|ShiftExpression << AdditiveExpression 
 -								|ShiftExpression >> AdditiveExpression 
 -								|ShiftExpression >>> AdditiveExpression
 +ConditionalOrExpression			: ConditionalAndExpression
  								;
 -AdditiveExpression				:MultiplicativeExpression 
 -								|AdditiveExpression + MultiplicativeExpression 
 -								|AdditiveExpression - MultiplicativeExpression
 +ConditionalAndExpression		: InclusiveOrExpression
  								;
 -MultiplicativeExpression		:UnaryExpression 
 -								|MultiplicativeExpression * UnaryExpression 
 -								|MultiplicativeExpression / UnaryExpression 
 -								|MultiplicativeExpression % UnaryExpression
 +InclusiveOrExpression			: ExclusiveOrExpression 
  								;
 -UnaryExpression					:PreIncrementExpression 
 -								|+ UnaryExpression 
 -								|- UnaryExpression 
 -								|UnaryExpressionNotPlusMinus
 +ExclusiveOrExpression			: AndExpression
 +								;
 +AndExpression					: EqualityExpression
 +								;
 +EqualityExpression				: RelationalExpression
 +								;
 +RelationalExpression			:ShiftExpression
 +								;
 +ShiftExpression					:AdditiveExpression
 +								;
 +AdditiveExpression				:MultiplicativeExpression
 +								;
 +MultiplicativeExpression		:UnaryExpression
 +								;
 +UnaryExpression					:UnaryExpressionNotPlusMinus
  								;
  UnaryExpressionNotPlusMinus     :PostfixExpression 
 -								|~ UnaryExpression 
 -								|! UnaryExpression 
 -								|CastExpression
  								;
  PostfixExpression				:Primary 
 -								|ExpressionName 
 -								|PostIncrementExpression 
 -								|PostDecrementExpression
  								;
  Primary							:PrimaryNoNewArray 
 -								|ArrayCreationExpression
  								;
  
  PrimaryNoNewArray				:Literal 
 -								|ClassLiteral 
 -								|this 
 -								|TypeName . this 
 -								|( Expression ) 
 -								|ClassInstanceCreationExpression 
 -								|FieldAccess 
 -								|ArrayAccess 
 -								|MethodInvocation 
 -								|MethodReference	
  								;
  
 -Literal 						:IntegerLiteral 
 -								|FloatingPointLiteral 
 -								|BooleanLiteral 
 -								|CharacterLiteral 
 -								|StringLiteral 
 -								|NullLiteral	
 +Literal 						:INTEGER_LITERAL 
  								;
  						
 +
