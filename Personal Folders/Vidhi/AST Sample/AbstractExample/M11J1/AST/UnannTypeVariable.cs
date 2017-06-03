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
    public class UnannTypeVariable : Node
    {
        private string _identifier;

        public UnannTypeVariable() { }
        public UnannTypeVariable(string identifier)
        {
            this._identifier = identifier;
        }
    }
}
