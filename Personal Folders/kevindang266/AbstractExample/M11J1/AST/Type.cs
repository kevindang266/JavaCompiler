using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class Type:Node
    {
    }
    public class VoidType : M11J1.AST.Type
    {
    }
    public class IdentifierType : M11J1.AST.Type
    {
        private string _identifier;

        public IdentifierType(string identifier)
        {
            this._identifier = identifier;
        }
    }
    public class ArrayType : M11J1.AST.Type
    {
        private Type _elementType;

        public ArrayType(Type elementType)
        {
            this._elementType = elementType;
        }
    }
}
