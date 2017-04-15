using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{ 
    public class MethodBody : Node
    {
        private List<Statement> _statements;

        public MethodBody(List<Statement> statements)
        {
            this._statements = statements;
        }
        //private Block _block;
        //private char _semicolon;
        //public MethodBody() {}
        //public MethodBody(Block block)
        //{
        //    this._block = block; 
        //}
        //public MethodBody(char semicolon)
        //{
        //    this._semicolon = semicolon;
        //}
    }
}
