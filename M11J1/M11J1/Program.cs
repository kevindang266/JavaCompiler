using System;

namespace M11J1
{
    public struct MyValueType
    {
        public int num;
        public string val;
	public string keyword; 
    };

    public enum Tokens
    {
        EOF = 264,
        BOOLEAN = 265,
	KEYWORDS = 263,

        VARIABLE_ARGUMENTS = 300, // variable arguments : ...
        DOUBLE_COLON = 301, //double colon ::	
        SELECTION,         //->
        EUQL_TO,                //==
        GREATER_THAN_OR_EQUAL_TO,       //>=
        LESS_THAN_OR_EUAL_TO,        //<=
        NOT_EQUAL_TO,       //!=
        CONDITION_AND,         //&&
        CONDITION_OR,             //||
        INCREMENT,                  //++
        DECREMENT,                  //--

        SINGED_LEFT_SHIFT,         //<<
        SINGED_RIGHT_SHIFT,          //>>
        UNSIGNED_RIGHT_SHFIT,          // >>>
        ADD_AND,                 //+=
        SUBTRACT_AND,             //-=
        MULTIPLY_AND,            //*=
        DIVIDE_AND,                  // /=
        BITWISE_AND,            // &=
        BITWISE_INCLUSIVE_OR,            // |= 
        BITWISE_EXCLUSIVE_OR,            // ^=
        MODULUS_AND,                  // %=
        LEFT_SHIFT_AND,                // <<=
        RIGHT_SHIFT_AND,     // >>=
        SHIFT_RIGHT_ZERO_FILL,        // >>>=


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
			    case Tokens.KEYWORDS:
                        	Console.WriteLine("KEYWORDS ({0})", scanner.yylval.keyword);
                        	break;
                            case Tokens.EOF:
                                Console.WriteLine("EOF");
                                break;
                            case Tokens.VARIABLE_ARGUMENTS:
                                Console.WriteLine("...");
                                break;
                            case Tokens.DOUBLE_COLON:
                                Console.WriteLine("::");
                                break;

                            case Tokens.SELECTION:
                                Console.WriteLine("->");
                                break;
                            case Tokens.EUQL_TO:
                                Console.WriteLine("==");
                                break;
                            case Tokens.GREATER_THAN_OR_EQUAL_TO:
                                Console.WriteLine(">=");
                                break;

                            case Tokens.LESS_THAN_OR_EUAL_TO:
                                Console.WriteLine("<=");
                                break;
                            case Tokens.NOT_EQUAL_TO:
                                Console.WriteLine("!=");
                                break;
                            case Tokens.CONDITION_AND:
                                Console.WriteLine("&&");
                                break;

                            case Tokens.CONDITION_OR:
                                Console.WriteLine("||");
                                break;
                            case Tokens.INCREMENT:
                                Console.WriteLine("++");
                                break;
                            case Tokens.DECREMENT:
                                Console.WriteLine("--");
                                break;

                            case Tokens.SINGED_LEFT_SHIFT:
                                Console.WriteLine("<<");
                                break;
                            case Tokens.SINGED_RIGHT_SHIFT:
                                Console.WriteLine(">>");
                                break;
                            case Tokens.UNSIGNED_RIGHT_SHFIT:
                                Console.WriteLine(">>>");
                                break;

                            case Tokens.ADD_AND:
                                Console.WriteLine("+=");
                                break;
                            case Tokens.SUBTRACT_AND:
                                Console.WriteLine("-=");
                                break;
                            case Tokens.MULTIPLY_AND:
                                Console.WriteLine("*=");
                                break;

                            case Tokens.DIVIDE_AND:
                                Console.WriteLine("/=");
                                break;
                            case Tokens.BITWISE_AND:
                                Console.WriteLine("&/");
                                break;
                            case Tokens.BITWISE_INCLUSIVE_OR:
                                Console.WriteLine("|=");
                                break;
                            case Tokens.BITWISE_EXCLUSIVE_OR:
                                Console.WriteLine("^=");
                                break;
                            case Tokens.MODULUS_AND:
                                Console.WriteLine("%=");
                                break;
                            case Tokens.LEFT_SHIFT_AND:
                                Console.WriteLine("<<=");
                                break;

                            case Tokens.RIGHT_SHIFT_AND:
                                Console.WriteLine(">>=");
                                break;
                            case Tokens.SHIFT_RIGHT_ZERO_FILL:
                                Console.WriteLine(">>>=");
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
