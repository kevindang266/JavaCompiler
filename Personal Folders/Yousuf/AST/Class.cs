using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace M11J1.AST
{
    public class Class : Node
    {
        string modifier, name;
        ClassMemberDeclaration member;

        public Class( string name, ClassMemberDeclaration member)
        {
           // this.modifier = modifier;
            this.name = name;
            this.member = member;
        }
       public void gencode(StreamWriter codewriter)
        {
            codewriter.WriteLine(".class private {0} extends[mscorlib]System.Object",name);
            codewriter.WriteLine("{");
            member.gencode(codewriter);
            codewriter.WriteLine("}");
        }
        public override void dump(int indent)
        {
            label(indent, "Class Declaration \n");
            //label(indent, "Class Modifier :{0}\n", modifier);
            label(indent, "Class name Identifier :{0}\n", name);
            member.dump(indent + 1);
            
        }
    }
    public class ClassMemberDeclaration : Node
    {
        FieldDeclaration field;
        Method method;

        public ClassMemberDeclaration(Method method)
        {
            this.method = method;
        }
        public void gencode(StreamWriter codewriter)
        {
             method.gencode(codewriter);
            
        }
        public override void dump(int indent)
        {
            label(indent, "Class Member Declaration\n");
            //label(indent, "Class Modifier :{0}\n", modifier);
            method.dump(indent + 1);
        }
    };
}
