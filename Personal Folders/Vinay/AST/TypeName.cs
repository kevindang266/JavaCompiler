using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
   public class TypeName : Node
    {
        private IdentifierExpression _identifier;

        public override void Dump(int indent)
        {
            
            _identifier.Dump(indent, "Type Name");
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _identifier.ResolveNames(scope);
            
        }
        public override void TypeCheck()
        {
            _identifier.TypeCheck();
        }

    }
}
