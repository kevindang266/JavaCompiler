using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/*
 * UnannTypeVariable:
 * Identifier
 */
namespace M11J1.AST
{
    class UnannTypeVariable : Node
    {
        private Identifier _identifier;

        public UnannTypeVariable() { }
        public UnannTypeVariable(Identifier identifier)
        {
            this._identifier = identifier;
        }
    }
}
