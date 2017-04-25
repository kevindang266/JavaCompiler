using System;

namespace M11J1.AST
{
    public abstract class Type:Node
    {
    }
    public class VoidType : M11J1.AST.Type
    {
        public override void Dump(int indent)
        {
            
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }
    public class IdentifierType : M11J1.AST.Type
    {
        private string _identifier;

        public IdentifierType(string identifier)
        {
            _identifier = identifier;
        }

        public override void Dump(int indent)
        {
            
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }
    public class ArrayType : M11J1.AST.Type
    {
        private Type _elementType;

        public ArrayType(Type elementType)
        {
           _elementType = elementType;
        }

        public override void Dump(int indent)
        {
            
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }
}
