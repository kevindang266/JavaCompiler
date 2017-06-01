using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
namespace M11J1.AST
{

    public abstract class Type : Node
    {
        public abstract void gencode(StreamWriter codewriter);
       

    }

    public class NamedType : Type
    {
        private string name;

        public NamedType(string name)
        {
            this.name = name;
        }

        public override void dump(int indent)
        {
            label(indent, "Type {0}\n", name);
        }

        public override void gencode(StreamWriter codewriter)
        {
            codewriter.Write(name);
        }
    };
    public class IntType : Type
    {
        public override void dump(int indent)
        {
            label(indent, "INT\n");
        }

        public override void gencode(StreamWriter codewriter)
        {
            codewriter.Write(".int\t");
        }
    };


    public class BoolType : Type
    {
        public override void dump(int indent)
        {
            label(indent, "BOOLEAN\n");
        }

        public override void gencode(StreamWriter codewriter)
        {
            throw new NotImplementedException();
        }
    };
    public class ArrayType : Type
    {
        NamedType elementType;

        public ArrayType(NamedType elementType)
        {
            this.elementType = elementType;
        }

        public override void dump(int indent)
        {
            label(indent, "Array\n");
            elementType.dump(indent + 1);
        }

        public override void gencode(StreamWriter codewriter)
        {
            elementType.gencode(codewriter);
            codewriter.Write("[]");
        }
    };
    public class VoidType : Type
    {
             public VoidType()
        {
            
        }
        public override void gencode(StreamWriter codewriter)
        {
            codewriter.Write("void ");

        }
        public override void dump(int indent)
        {
            label(indent, "VOID\n");
        }
    };
}
