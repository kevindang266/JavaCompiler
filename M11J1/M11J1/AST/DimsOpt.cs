using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    /*
     *  
     * {Annotation} [ ] {{Annotation} [ ]}  // To be implemented
     */
    class DimsOpt : Node
    {
        private Dims  _dims;

        public DimsOpt(Dims dims)
        {
            this._dims = dims;
        }
    }
}
