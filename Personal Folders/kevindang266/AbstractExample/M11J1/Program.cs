using System;
using System.IO;
using M11J1.AST;
using System.Collections.Generic;

namespace M11J1
{
    class Program
    {
        static void Main(string[] args)
        {
            Scanner scanner = new Scanner(
                new FileStream(@"..\..\Tests\m11j1.java", FileMode.Open));
            Parser parser = new Parser(scanner);
            parser.Parse();
            //Parser.Root.DumpValue(0);
            Console.ReadLine();

            //List<ClassModifier> modifiers = new List<ClassModifier>() { AST.ClassModifier.Public };
            //var pro = new ClassDeclaration(modifiers, "helloworld");
            //pro.DumpValue(0);

            //List<ClassModifier> modifiers = new List<ClassModifier>() { ClassModifier.Public };

            //var pro = new CompilationUnit("test", new ClassDeclaration(modifiers, "HelloWorld",
            //    new List<MethodDeclaration>{
            //        new MethodDeclaration(new List<MethodModifier> {MethodModifier.Public, MethodModifier.Static }, new MethodHeader(new VoidType(),
            //        new MethodDeclarator("main", new List<FormalParameter> {
            //            new FormalParameter(new AST.ArrayType(new IdentifierType("String")), "args") })), new MethodBody(
            //                    new List<Statement> { new VariableDeclaration(new AST.IdentifierType("x")),
            //                        new ExpressionStatement( new AssignmentExpression(new ExpressionName("x"), new IntegerLiteral(42))) }
            //                ))
            //    }));
            //pro.DumpValue(0);

            //var ex = new ExpressionStatement(new AssignmentExpression())
        }
    }
}
