using System;
using System.Collections.Generic;
using System.IO;
using M11J1.AST;

namespace M11J1
{
    class Program
    {



        static void Main(string[] args)
        {

            Scanner scanner = new Scanner(
                              //  new FileStream("m11j1.java", FileMode.Open));
                   new FileStream(@"..\..\Tests\m11j1.java", FileMode.Open));
            //Scanner scanner = new Scanner(
            //   new FileStream(args[0], FileMode.Open));


            Parser parser = new Parser(scanner);

            parser.Parse();

            if (Parser.Root != null)
            {
                SemanticAnalysis(Parser.Root);
                Parser.Root.Dump(0);
            }

           // ASTHardCodeTest();
            
            Console.ReadLine();
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
                                    new VariableDeclarationList(
                                        new List<VariableDeclaration> {new VariableDeclaration(new IntType(), "y")}
                                    ),
                                    new ExpressionStatement(
                                        new AssignmentExpression(
                                            new IdentifierExpression("x"),
                                            new NumberExpression(42)
                                        )
                                    ),
                                     new BasicForStatement(
                                        new VariableDeclarationList(
                                        new List<VariableDeclaration> {new VariableDeclaration(new IntType(), "i")}
                                    ),
                                        new BinaryExpression(
                                            new IdentifierExpression("i"), '<', new NumberExpression(5)
                                            ),
                                        new CompoundStatement(

                                            new List<Statement> {
                                                new ExpressionStatement(
                                                                new AssignmentExpression(
                                                                    new IdentifierExpression("y"),
                                                                    new NumberExpression(42)
                                                                )
                                                            )
                                            }
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
}
