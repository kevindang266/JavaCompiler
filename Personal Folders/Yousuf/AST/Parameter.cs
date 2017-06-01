using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
namespace M11J1.AST
{
    public class Parameter : Node
    {
        Type type;
        VariableDeclaratorId id;
        string modifiers;
        private bool isVarArgs;
        public void gencode(StreamWriter codewriter)
        {
            type.gencode(codewriter);
            id.gencode(codewriter);
        }
        public Parameter()
        {
        }

        public Parameter(Type type, VariableDeclaratorId id)
        {
            this.id = id;
            this.type = type;
        }

        public Parameter(string modifiers, Type type, VariableDeclaratorId id)
        {
            this.modifiers = modifiers;
            this.id = id;
            this.type = type;
        }

        public Parameter(string modifiers, Type type, bool isVarArgs, VariableDeclaratorId id)
        {
            this.isVarArgs = isVarArgs;
            this.modifiers = modifiers;
            this.id = id;
            this.type = type;
        }

        public override void dump(int indent)
        {
            label(indent, "Parameter declaration \n");
            type.dump(indent );
            id.dump(indent);
        }
    }
}
