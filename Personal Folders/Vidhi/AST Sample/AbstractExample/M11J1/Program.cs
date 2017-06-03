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
            //Console.WriteLine("starting...");
            //Scanner scanner = new Scanner(
            //    new FileStream(@"..\..\Tests\m11j1.java", FileMode.Open));
            //Parser parser = new Parser(scanner);
            //Console.WriteLine("parsing...");
            //parser.Parse();
            //Console.WriteLine("finished.");
            //Console.ReadLine();

            var classModifier = new ClassModifier("public");
            List<ClassModifier> modifiers = new List<ClassModifier>();
            modifiers.Add(classModifier);

            var pro = new CompilationUnit("test", new ClassDeclaration(modifiers, "HelloWorld", 
                new List<MethodDeclaration>{
                    new MethodDeclaration(new List<MethodModifier> {MethodModifier.Public, MethodModifier.Static }, new MethodHeader(new VoidType(), 
                    new MethodDeclarator("main", new List<FormalParameter> {
                        new FormalParameter(new AST.ArrayType(new IdentifierType("String")), "args") })), new MethodBody())
                }));
            pro.DumpValue(0);

            //var ex = new ExpressionStatement(new AssignmentExpression())
        }
    }
}
