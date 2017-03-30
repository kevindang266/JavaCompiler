using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    class UnannArrayType : Node
    {
/*
 * UnannArrayType:
 * UnannPrimitiveType Dims   //To Be implemented
 * UnannClassOrInterfaceType Dims   //To Be implemented
 * UnannTypeVariable Dims //To Be implemented
 */
        private UnannTypeVariable _unannTypeVariable;
        private DimsOpt _dimsOpt;

        public UnannArrayType(UnannTypeVariable unannTypeVariable , DimsOpt dimsOpt)
        {
            this._unannTypeVariable = unannTypeVariable;
            this._dimsOpt = dimsOpt;
        }
    }
}
