using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    
    class UnannType : Node
    {
        /*
         * UnannType:
         * UnannPrimitiveType  // To be implemented
         * UnannReferenceType 
         */
        private UnannReferenceType _unannReferenceType;

        public UnannType(UnannReferenceType unannReferenceType)
        {
            this._unannReferenceType = unannReferenceType;
        }
    }
}
