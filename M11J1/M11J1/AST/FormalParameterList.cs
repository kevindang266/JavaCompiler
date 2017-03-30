using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace M11J1.AST
{
    class FormalParameterList : Node
    {
        /*
         * FormalParameterList:
         * ReceiverParameter 
         * FormalParameters , LastFormalParameter //To be implemented
         * LastFormalParameter  //To be implemented
         */
        private ReceiverParameter _receiverParameter;

        public FormalParameterList(ReceiverParameter receiverParameter)
        {
            this._receiverParameter = receiverParameter;
        }

    }
}
