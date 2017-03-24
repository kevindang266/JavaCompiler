using System;

namespace M11J1
{
    public struct MyValueType
    {
        public int num;
        public string name;
        public string keyword;
    };

    public enum Tokens
    {
        EOF = 264,

        VariableArguments = 300, // variable arguments : ...
        DoubleColon = 301, //double colon ::	
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
        BitwiseInclusiveOr,            // |= 
        BitwiseExclusiveOr,            // ^=
        ModulusAnd,                  // %=
        LeftShiftAnd,                // <<=
        RightShiftAnd,     // >>=
        ShiftRightZeroFill,        // >>>=
        Int,
        IntergerLiteral,
        Implements,
        If,
        Final,
        Else,
        Extends,
        Static,
        Boolean,
        Public,
        Class,
        Void,
        CharacterLiteral,
        Identifier
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
			                case Tokens.CharacterLiteral:
                        	    Console.WriteLine("Char ({0})", scanner.yylval.name);
                                break;
                            case Tokens.IntergerLiteral:
                                Console.WriteLine("Interger ({0})", scanner.yylval.name);
                                break;
                            case Tokens.Boolean:
                                Console.WriteLine("Boolean");
                                break;
                            case Tokens.EOF:
                                Console.WriteLine("EOF");
                                break;
                            case Tokens.VariableArguments:
                                Console.WriteLine("...");
                                break;
                            case Tokens.DoubleColon:
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
                            case Tokens.BitwiseInclusiveOr:
                                Console.WriteLine("|=");
                                break;
                            case Tokens.BitwiseExclusiveOr:
                                Console.WriteLine("^=");
                                break;
                            case Tokens.ModulusAnd:
                                Console.WriteLine("%=");
                                break;
                            case Tokens.LeftShiftAnd:
                                Console.WriteLine("<<=");
                                break;

                            case Tokens.RightShiftAnd:
                                Console.WriteLine(">>=");
                                break;
                            case Tokens.ShiftRightZeroFill:
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
                Console.ReadLine();
            }
        }
    }
}
