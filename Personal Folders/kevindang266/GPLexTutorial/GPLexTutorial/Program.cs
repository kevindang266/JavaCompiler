using System;

namespace GPLexTutorial
{
    public struct MyValueType
    {
        public int num;
        public bool bval;
        public string name;
    };

    public enum Tokens
    {
        NUMBER = 258,
        IDENT = 259,
        IF = 260,
        ELSE = 261,
        INT = 262,
        BOOL = 263,
        EOF = 264,
        BOOLVAL = 265,
        NULL = 266,
        CHAR = 267
    };

    public abstract class ScanBase
    {
        public MyValueType yylval;
        public abstract int yylex();
        protected virtual bool yywrap() { return true; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                using (var input = System.IO.File.OpenRead(args[0]))
                {
                    Scanner scanner = new Scanner(input);
                    Tokens token;
                    do
                    {
                        token = (Tokens)scanner.yylex();
                        switch (token)
                        {
                            case Tokens.NUMBER:
                                Console.WriteLine("NUMBER ({0})", scanner.yylval.num);
                                break;
                            case Tokens.IDENT:
                                Console.WriteLine("IDENT ({0})", scanner.yylval.name);
                                break;
                            case Tokens.IF:
                                Console.WriteLine("IF");
                                break;
                            case Tokens.ELSE:
                                Console.WriteLine("ELSE");
                                break;
                            case Tokens.INT:
                                Console.WriteLine("INT");
                                break;
                            case Tokens.BOOL:
                                Console.WriteLine("BOOL");
                                break;
                            case Tokens.BOOLVAL:
                                Console.WriteLine("BOOL VALUE ({0})", scanner.yylval.bval);
                                break;
                            case Tokens.CHAR:
                                Console.WriteLine("CHAR ({0})", scanner.yylval.name);
                                break;
                            case Tokens.NULL:
                                Console.WriteLine("NULL");
                                break;
                            case Tokens.EOF:
                                Console.WriteLine("EOF");
                                break;
                            default:
                                Console.WriteLine("'{0}'", (char)token);
                                break;
                        }
                    }
                    while (token != Tokens.EOF);
                }
                Console.ReadLine();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}

