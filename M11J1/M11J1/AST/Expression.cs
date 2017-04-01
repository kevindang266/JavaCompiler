using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public abstract class Expression : Node
    {
    }

    public class IntegerLiteral : Expression
    {
        private int _value;

        public IntegerLiteral(int value)
        {
            this._value = value;
        }
    }
}
