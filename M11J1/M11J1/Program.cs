﻿using System;

namespace M11J1
{
    public struct MyValueType
    {
        public int num;
        public string name;
       
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
        IntergerLiteral,
        CharacterLiteral,
        Identifier,
        FloatingPointLiterals,

             /* Tarandeep Keywords*/
        Abstract,
        Assert,
        Boolean,
        Break,
        Byte,
        Case,
        Catch,
        Char,
        Class,
        Const,
        Continue,
        Default,
        Do,
        Double,
        Else,
        Enum,
        Extends,
        Final,
        Finally,
        Float,
        For,
        Goto,
        If,
        Implements,
        Import,
        Instanceof,
        Int,
        Interface,
        Long,
        Native,
        New,
        Package,
        Private,
        Protected,
        Public,
        Return,
        Short,
        Static,
        Strictfp,
        Super,
        Switch,
        Synchronized,
        This,
        Throw,
        Throws,
        Transient,
        Try,
        Void,
        Volatile,
        While,
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
                            case Tokens.FloatingPointLiterals:
                                Console.WriteLine("FloatingPointLiterals ({0})", scanner.yylval.name);
                                break;
                            case Tokens.Identifier:
                                Console.WriteLine("Identifier ({0})", scanner.yylval.name);
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
                            case Tokens.Abstract:
                                Console.WriteLine("Abstract");
                                break;
                            case Tokens.Assert:
                                Console.WriteLine("Assert");
                                break;
                            case Tokens.Boolean:
                                Console.WriteLine("Boolean");
                                break;
                            case Tokens.Break:
                                Console.WriteLine("Break");
                                break;
                            case Tokens.Byte:
                                Console.WriteLine("Byte");
                                break;
                            case Tokens.Case:
                                Console.WriteLine("Case");
                                break;
                            case Tokens.Catch:
                                Console.WriteLine("Catch");
                                break;
                            case Tokens.Char:
                                Console.WriteLine("Char");
                                break;
                            case Tokens.Class:
                                Console.WriteLine("Class");
                                break;
                            case Tokens.Const:
                                Console.WriteLine("Const");
                                break;
                            case Tokens.Continue:
                                Console.WriteLine("Continue");
                                break;
                            case Tokens.Default:
                                Console.WriteLine("Default");
                                break;
                            case Tokens.Do:
                                Console.WriteLine("Do");
                                break;
                            case Tokens.Double:
                                Console.WriteLine("Double");
                                break;
                            case Tokens.Else:
                                Console.WriteLine("Else");
                                break;
                            case Tokens.Enum:
                                Console.WriteLine("Enum");
                                break;
                            case Tokens.Extends:
                                Console.WriteLine("Extends");
                                break;
                            case Tokens.Final:
                                Console.WriteLine("Final");
                                break;
                            case Tokens.Finally:
                                Console.WriteLine("Finally");
                                break;
                            case Tokens.Float:
                                Console.WriteLine("Float");
                                break;
                            case Tokens.For:
                                Console.WriteLine("For");
                                break;
                            case Tokens.Goto:
                                Console.WriteLine("Goto");
                                break;
                            case Tokens.If:
                                Console.WriteLine("If");
                                break;
                            case Tokens.Implements:
                                Console.WriteLine("Implements");
                                break;
                            case Tokens.Import:
                                Console.WriteLine("Import");
                                break;
                            case Tokens.Instanceof:
                                Console.WriteLine("Instanceof");
                                break;
                            case Tokens.Int:
                                Console.WriteLine("Int");
                                break;
                            case Tokens.Interface:
                                Console.WriteLine("Interface");
                                break;
                            case Tokens.Long:
                                Console.WriteLine("Long");
                                break;
                            case Tokens.Native:
                                Console.WriteLine("Native");
                                break;
                            case Tokens.New:
                                Console.WriteLine("New");
                                break;
                            case Tokens.Package:
                                Console.WriteLine("Package");
                                break;
                            case Tokens.Private:
                                Console.WriteLine("Private");
                                break;
                            case Tokens.Protected:
                                Console.WriteLine("Protected");
                                break;
                            case Tokens.Public:
                                Console.WriteLine("Public");
                                break;
                            case Tokens.Return:
                                Console.WriteLine("Return");
                                break;
                            case Tokens.Short:
                                Console.WriteLine("Short");
                                break;
                            case Tokens.Static:
                                Console.WriteLine("Static");
                                break;
                            case Tokens.Strictfp:
                                Console.WriteLine("Strictfp");
                                break;
                            case Tokens.Super:
                                Console.WriteLine("Super");
                                break;
                            case Tokens.Switch:
                                Console.WriteLine("Switch");
                                break;
                            case Tokens.Synchronized:
                                Console.WriteLine("Synchronized");
                                break;
                            case Tokens.This:
                                Console.WriteLine("This");
                                break;
                            case Tokens.Throw:
                                Console.WriteLine("Throw");
                                break;
                            case Tokens.Throws:
                                Console.WriteLine("Throws");
                                break;
                            case Tokens.Transient:
                                Console.WriteLine("Transient");
                                break;
                            case Tokens.Try:
                                Console.WriteLine("Try");
                                break;
                            case Tokens.Void:
                                Console.WriteLine("Void");
                                break;
                            case Tokens.Volatile:
                                Console.WriteLine("Volatile");
                                break;
                            case Tokens.While:
                                Console.WriteLine("While");
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
