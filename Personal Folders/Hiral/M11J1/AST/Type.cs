namespace M11J1.AST
{
    public abstract class Type:Node
    {
        public bool Compatible(Type other)
        {
            return Equal(other);
        }

        public abstract bool Equal(Type other);
    }
    public class VoidType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "VoidType\n");
        }

       
        public override bool Equal(Type other)
        {
            return (VoidType)other != null;
        }

        
    }
    public class IntType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "IntType\n");
        }

        

        public override bool Equal(Type other)
        {
            return (IntType)other != null;
        }

        
    }
    public class IdentifierType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "IdentifierType\n");
        }

        

        public override bool Equal(Type other)
        {
            return (IdentifierType)other != null;
        }

       
    }
    public class ArrayType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "ArrayType\n");
        }

       

        public override bool Equal(Type other)
        {
            return (ArrayType)other != null;
        }

        
    }

    public class BoolType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "BoolType\n");
        }

       
        public override bool Equal(Type other)
        {
            return (BoolType)other != null;
        }
    }
}
