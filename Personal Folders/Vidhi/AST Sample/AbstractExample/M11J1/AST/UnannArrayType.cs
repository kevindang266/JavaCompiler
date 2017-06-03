using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class UnannArrayType : Node
    {
/*
 * UnannArrayType:
 * UnannPrimitiveType Dims   //To Be implemented
 * UnannClassOrInterfaceType Dims   //To Be implemented
 * UnannTypeVariable Dims //To Be implemented
 */
        private UnannTypeVariable _unannTypeVariable;

        public UnannArrayType(UnannTypeVariable unannTypeVariable)
        {
            this._unannTypeVariable = unannTypeVariable;
        }
    }
}
