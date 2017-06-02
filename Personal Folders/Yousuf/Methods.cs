using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
namespace M11J1.AST
{
    public class Method : Node
    {
        public string modifier, name;
        public Type type;
        public VariableDeclarationStatement stmt;
        public Parameter parameters;
        public CompoundStatement body;
                public Method(Type type, String name)
        {
           // this.modifier = modifiers;
            this.type = type;
            this.name = name;
        }

        public Method( Type type, String name, Parameter parameters)
        {
            //this.modifier = modifiers;
            this.type = type;
            this.name = name;
            this.parameters = parameters;
        }
        public Method( Type type, String name, Parameter parameters, CompoundStatement body)
        {
            //this.modifier = modifiers;
            this.type = type;
            this.name = name;
            this.parameters = parameters;
            this.body = body;
        }
        public void gencode(StreamWriter codewriter)
        {
            codewriter.Write(".method public static ");
            type.gencode(codewriter);
            codewriter.Write(name);
            codewriter.Write("(");
            parameters.gencode(codewriter);
            codewriter.Write(")");
            // { 0} {1}({2})", type,name,parameters);
            codewriter.WriteLine("{");
            //member.gencode(codewriter);
            codewriter.WriteLine("}");
        }

        public override void dump(int indent)
        {
            label(indent, "Method Declaration\n");
            label(indent+1, "Method Type:");
            type.dump(indent);
            label(indent+1, "Method name :{0}\n", name);
            parameters.dump(indent+1);
            label(indent, "MethodBody\n");
            body.dump(indent+1);
        }
    }
}
