using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
namespace M11J1.AST
{
    public class VariableDeclaratorId : Node
    {
        private String name;

        private int arrayCount;
        public void gencode(StreamWriter codewriter)
        {
            codewriter.Write(name);
        }
        public VariableDeclaratorId()
        {
        }

        public VariableDeclaratorId(String name)
        {
            this.name = name;
        }

        public VariableDeclaratorId( String name, int arrayCount)
        {
            this.name = name;
            this.arrayCount=arrayCount;
        }
        public override void dump(int indent)
        {
            label(indent, "Identifier:{0}\n",name);
        
        }
    }
}
