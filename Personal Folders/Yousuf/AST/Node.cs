using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public abstract class Node
    {
        public abstract void dump(int indent);

        private void indent(int N)
        {
            for (int i = 0; i < N; i++)
                Console.Write("    ");
        }

        protected void label(int i, string fmt, params object[] args)
        {
            indent(i);
            Console.Write(fmt, args);
        }

        public void dump(int i, string name)
        {
            label(i, "{0}:\n", name);
            dump(i + 1);
        }
    }
}
