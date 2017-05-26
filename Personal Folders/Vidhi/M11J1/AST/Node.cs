using System;
using System.IO;

namespace M11J1.AST
{
    public abstract class Node
    {
        public abstract void Dump(int indent);
        public abstract void ResolveNames(LexicalScope scope);
        public abstract void TypeCheck();
        public abstract void GenCode(string file);
        public void Emit(string outputFile, string fmt, params object[] args)
        {
            var line = string.Format(fmt, args);
            using (var file = File.AppendText(outputFile))
            {
                file.WriteLine(line);
                file.Close();
            }
        }
        private void Indent(int n)
        {
            for (int i = 0; i < n; i++)
                Console.Write("    ");
        }
        protected void Label(int i, string fmt, params object[] args)
        {
            Indent(i);
            Console.Write(fmt, args);
        }
        public void Dump(int i, string name)
        {
            Label(i, "{0}:\n", name);
            Dump(i + 1);
        }
    }
}
