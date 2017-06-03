using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public abstract class Statement : Node
    {
    }

    public class ExpressionStatement : Statement
    {
        private Expression _expression;

        public ExpressionStatement(Expression expression)
        {
            this._expression = expression;
        }
    }

    public class DeclarationStatement : Statement
    {
    }
}
