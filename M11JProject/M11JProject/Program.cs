using System;

namespace M11JProject
{
    public struct MyValueType
    {
        public int num;
        public string val;
    };

    public enum Tokens
    {
        NUMBER = 258,
        IDENTIFIER = 259,
        IF = 260,
        ELSE = 261,
        INT = 262,
        EOF = 264,
        BOOLEAN = 265,
        BOOLEANVALUE = 266
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
                            case Tokens.IDENTIFIER:
                                Console.WriteLine("IDENTIFIER ({0})", scanner.yylval.val);
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
                            case Tokens.BOOLEAN:
                                Console.WriteLine("BOOLEAN");
                                break;
                            case Tokens.BOOLEANVALUE:
                                Console.WriteLine("BOOLEAN VALUE ({0})", scanner.yylval.val);
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
                Console.ReadLine();
            }
        }
    }
}
