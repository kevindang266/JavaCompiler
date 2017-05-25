using System;
using System.Collections.Generic;
using System.IO;
using Project.AST;

namespace Project
{
    class Program
    {
        static void Main(string[] args)
        {
            var filename = @"..\..\Tests\m11j1.java";
            Scanner scanner = new Scanner(
                new FileStream(filename, FileMode.Open));
            Parser parser = new Parser(scanner);
            parser.Parse();

            if (Parser.Root != null)
            {
                SemanticAnalysis(Parser.Root);
                //Parser.Root.Dump(0);
                CodeGeneration(filename, Parser.Root);
            }

            //ASTHardCodeTest();

            Console.ReadLine();
        }

        public static void CodeGeneration(string inputfile, Node root)
        {
            string path = Directory.GetCurrentDirectory();
            string outputFile = path + @"\test.il";
            if (File.Exists(outputFile))
            {
                File.Delete(outputFile);
            }

            root.GenCode(outputFile);

            root.Emit(outputFile, "ret");
            root.Emit(outputFile, "}}");
            root.Emit(outputFile, "}}");
        }

        public static void SemanticAnalysis(Node root)
        {
            root.ResolveNames(null);
            root.TypeCheck();
        }

        public static void ASTHardCodeTest()
        {
            var pro = new CompilationUnit(
                new ClassDeclaration(
                    new List<Modifier> { Modifier.Public },
                    "HelloWorld",
                    new List<MethodDeclaration>
                    {
                        new MethodDeclaration(
                            new List<Modifier> {Modifier.Public, Modifier.Static},
                            new MethodHeader(new VoidType(),
                                new MethodDeclarator("main",
                                    new List<Parameter> {new FormalParameter(null, new IdentifierType(), "args")}
                                )
                            ),
                            new CompoundStatement(
                                new List<Statement>
                                {
                                    new VariableDeclarationList(
                                        new List<VariableDeclaration> {new VariableDeclaration(new IntType(), "x")}
                                    ),
                                    new ExpressionStatement(
                                        new AssignmentExpression(
                                            new IdentifierExpression("x"),
                                            '=',
                                            new NumberExpression(42)
                                        )
                                    )
                                }
                            )
                        )
                    }
                )
            );

            SemanticAnalysis(pro);
            pro.Dump(0);
        }
    }
    class Global
    {
        public static int LastLabel = 0;
        public static int LastLocal = 0;
    }
}
