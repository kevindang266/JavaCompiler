using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class FormalParameter : Node
    {
        private Type _type;
        private string _identifier;

        public FormalParameter(Type type, string identifier)
        {
            this._type = type;
            this._identifier = identifier;
        }
    }
}
