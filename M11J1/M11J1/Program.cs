using System;

namespace M11J1
{
    public struct MyValueType
    {
        public int num;
        public string val;
    };

    public enum Tokens
    {
        EOF = 264,
        BOOLEAN = 265,
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
                            case Tokens.BOOLEAN:
                                Console.WriteLine("BOOLEAN");
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

                    Console.ReadLine();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}
