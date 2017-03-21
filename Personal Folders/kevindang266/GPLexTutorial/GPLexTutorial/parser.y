%namespace GPLexTutorial

%union
{
    public int num;
    public string name;
}

%token <num> Number
%token <name> Identifier 
%token If Else Int Boolean BooleanLiteral NullLiteral CharacterLiteral

%left '='
%nonassoc '<'
%left '+'

%%

Program : Statement
        ;

Statement : If '(' Expression ')' Statement Else Statement
          | '{' StatementList '}'
          | Expression ';'
          | Type Identifier ';'
          ;

Type : Int
     | Boolean
     ;

StatementList : StatementList Statement
              | /* empty */
              ;

Expression : Number
           | Identifier
           | Expression '=' Expression
           | Expression '+' Expression
           | Expression '<' Expression
           ;

%%

public Parser(Scanner scanner) : base(scanner)
{
}