using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


/*
Result MethodDeclarator [Throw_opt] 
TypeParameters {Annotation} Result MethodDeclarator [Throws]  
     */
namespace M11J1.AST
{
    class MethodHeader : Node
    {
        //Result MethodDeclarator
        private Result _result;
        private MethodDeclarator _methodDeclarator;
        //private Throws                        // To be implemented 
        //TypeParameters {Annotation}           // To be implemented 
        //Result MethodDeclarator[Throws]       // To be implemented 

        public MethodHeader() { }
        public MethodHeader(Result result, MethodDeclarator methodDeclarator)
        {
            this._result = result;
            this._methodDeclarator = methodDeclarator;
        }
    }
}
