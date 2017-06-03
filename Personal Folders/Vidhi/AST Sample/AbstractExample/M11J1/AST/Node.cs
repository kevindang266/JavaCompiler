using System;
using System.Collections;

namespace M11J1.AST
{
    public abstract class Node
    {
        void Indent(int n)
        {
            for (int i = 0; i < n; i++)
                Console.Write("    ");
        }

        public void DumpValue(int indent)
        {
            Indent(indent);
            Console.WriteLine("{0}", GetType().ToString());

            Indent(indent);
            Console.WriteLine("{");

            foreach (var field in GetType().GetFields(System.Reflection.BindingFlags.NonPublic |
                System.Reflection.BindingFlags.Instance))
            {
                object value = field.GetValue(this);
                Indent(indent + 1);
                if (value is Node)
                {
                    Console.WriteLine("{0}:", field.Name);
                    ((Node)value).DumpValue(indent + 2);
                }
                else if (value is String)
                    Console.WriteLine("{0}: {1}", field.Name, value);
                else if (value is IEnumerable)
                {
                    Console.WriteLine("[");
                    var e = (IEnumerable)value;
                    foreach (var item in e)
                    {
                        if (item is Node)
                            ((Node)item).DumpValue(indent + 2);
                        else
                        {
                            Indent(indent + 2);
                            Console.WriteLine(item);
                        }
                    }
                    Indent(indent + 1);
                    Console.WriteLine("]");
                }
            }

            Indent(indent);
            Console.WriteLine("}");
        }
    };
}
