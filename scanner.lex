%namespace PLT1
digit [0-9]
letter [a-zA-Z]

%%

if				{return (int)Tokens.IF;}
else 				{return (int)Tokens.ELSE;}
int 				{return (int)Tokens.INT;}
bool				{return (int)Tokens.BOOL;}

{letter}({letter}|{digit})*	{return (int)Tokens.IDENT;}
{digit}+	 		{return (int)Tokens.NUMBER;}

"-"				{return '-';}  // SUBTRATION
"*"				{return '*';}    // MULTIPLICATION
"/"			    {return '/';}    //DIVISION
"&"				{return '&';}    //BITWISE_AND
"|"				{return '|';}    //BITWISE_OR
"^"				{return '^';}    //BITWISE_XOR
"%"				{return '%';}    //MODULUS
"+="			{return (int)Tokens.ADD_AND;}
"-="			{return (int)Tokens.SUBTRACT_AND;}
"*="			{return (int)Tokens.MULTIPLY_AND;}
"/="			{return (int)Tokens.DIVIDE_AND;}
"&="			{return (int)Tokens.BITWISE_AND;}



[\r\n\t]			/* skip whitespace */
.				{
					throw new Exception(
						String.Format(
							"unexpected character '{0}'", yytext));
				}


%%


// --------------------- Program.cs- ---------------------------------------

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PLT1
{
    public enum Tokens
    {
        NUMBER = 258,
        IDENT = 259,
        IF = 260,
        ELSE = 261,
        INT = 262,
        BOOL = 263,
        EOF = 264
    };

    public abstract class ScanBase
    {
        public abstract int yylex();
        protected virtual bool yywrap() { return true; }
    }
    class Program
    {
        static void Main(string[] args)
        {

            Scanner scanner = new Scanner(Console.OpenStandardInput());
            Tokens token;
            do
            {
                token = (Tokens)scanner.yylex();
                Console.WriteLine("token {0}", token);
            }
            while (token != Tokens.EOF);

            System.Console.ReadLine();
        }
    }
}
