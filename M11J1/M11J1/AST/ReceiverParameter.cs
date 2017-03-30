using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
 * ReceiverParameter:
 * {Annotation} UnannType [Identifier .] this
 */
namespace M11J1.AST
{
    class ReceiverParameter : Node
    {
        /*
         * ReceiverParameter:
         * {Annotation} UnannType [Identifier .] this   // To be Implemented
         */
        private UnannType _unannType;
        private Identifier _identifier;

        public ReceiverParameter(UnannType unannType, Identifier identifier)
        {
            this._unannType = unannType;
            this._identifier = identifier;
        }



    }
}
