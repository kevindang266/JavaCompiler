using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntermediateLanguage
{
    class Program
    {
        static void Main(string[] args)
        {
            int a;
            int b;
            int c;
            a = 20;
            b = 15;
            if(a>b)
            {
                c = a - b;
                Console.WriteLine(c);
            }
            else
            {
                c = b - a;
                Console.WriteLine(c);
            }
        }
    }
}
