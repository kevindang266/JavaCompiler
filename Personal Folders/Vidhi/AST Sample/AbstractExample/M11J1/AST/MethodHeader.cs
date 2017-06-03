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
    public class MethodHeader : Node
    {
        //Result MethodDeclarator
        private Type _type;
        private MethodDeclarator _methodDeclarator;
        //private Throws                        // To be implemented 
        //TypeParameters {Annotation}           // To be implemented 
        //Result MethodDeclarator[Throws]       // To be implemented 

        public MethodHeader() { }
        public MethodHeader(M11J1.AST.Type type, MethodDeclarator methodDeclarator)
        {
            this._type = type;
            this._methodDeclarator = methodDeclarator;
        }
    }
}
