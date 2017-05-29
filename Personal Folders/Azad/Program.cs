using System.IO;
using group2JavaCompiler.AST;

namespace group2JavaCompiler
{
    class Program
    {
        static void Main(string[] args)
        {
            var filename = args[0];
            var file = new FileStream(args[0], FileMode.Open);
            Scanner scanner = new Scanner(file);
            Parser parser = new Parser(scanner);
            parser.Parse();
            Parser.root.dump(0);
            var writer = new StreamWriter(filename + ".il");
            writer.WriteLine("﻿.assembly {0} {{}}",filename);
            Parser.root.gencode(writer);
            writer.Close();
            Class root = new Class("public", "Test",
            new Method("public static",
            new NamedType("void"),
            "main",new Arguments(new ArrayType(new NamedType("String")), "args"),
            new VariableDeclarationStatement(new NamedType("double"), new IdentifierExpression("x"), new IntegerLiteralExpression(42))
                             )
                          );
             root.dump(0);
        }
    }
}
