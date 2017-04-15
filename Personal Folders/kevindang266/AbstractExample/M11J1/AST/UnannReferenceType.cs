using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    /*
     * UnannReferenceType:
     * UnannClassOrInterfaceType //To Be implemented
     * UnannTypeVariable   //To Be implemented
     * UnannArrayType
     */
    public class UnannReferenceType : Node
    {

        private UnannArrayType _unannArrayType;

        public UnannReferenceType(UnannArrayType unannArrayType)
        {
            this._unannArrayType = unannArrayType;
        }

    }
}
