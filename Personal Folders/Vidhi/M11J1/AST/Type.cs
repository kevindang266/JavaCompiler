namespace M11J1.AST
{
    public abstract class Type:Node
    {
        public bool Compatible(Type other)
        {
            return Equal(other);
        }

        public abstract string CLRName();

        public abstract bool Equal(Type other);
    }
    public class VoidType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "VoidType\n");
        }

        public override void ResolveNames(LexicalScope scope)
        {

        }

        public override bool Equal(Type other)
        {
            return (VoidType)other != null;
        }

        public override void TypeCheck()
        {

        }

        public override string CLRName()
        {
            return "void";
        }

        public override void GenCode(string file)
        {
            throw new System.NotImplementedException();
        }
    }
    public class IntType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "IntType\n");
        }

        public override void ResolveNames(LexicalScope scope)
        {

        }

        public override bool Equal(Type other)
        {
            return (IntType)other != null;
        }

        public override void TypeCheck()
        {

        }

        public override string CLRName()
        {
            return "int32";
        }

        public override void GenCode(string file)
        {
            throw new System.NotImplementedException();
        }
    }
    public class IdentifierType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "IdentifierType\n");
        }

        public override void ResolveNames(LexicalScope scope)
        {

        }

        public override bool Equal(Type other)
        {
            return (IdentifierType)other != null;
        }

        public override void TypeCheck()
        {

        }

        public override string CLRName()
        {
            return string.Empty;
        }

        public override void GenCode(string file)
        {
            throw new System.NotImplementedException();
        }
    }
    public class ArrayType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "ArrayType\n");
        }

        public override void ResolveNames(LexicalScope scope)
        {

        }

        public override bool Equal(Type other)
        {
            return (ArrayType)other != null;
        }

        public override void TypeCheck()
        {
        }

        public override string CLRName()
        {
            return "newarr";
        }

        public override void GenCode(string file)
        {
            throw new System.NotImplementedException();
        }
    }

    public class BoolType : Type
    {
        public override void Dump(int indent)
        {
            Label(indent, "BoolType\n");
        }

        public override void ResolveNames(LexicalScope scope)
        {
        }

        public override void TypeCheck()
        {

        }

        public override bool Equal(Type other)
        {
            return (BoolType)other != null;
        }

        public override string CLRName()
        {
            return "bool";
        }

        public override void GenCode(string file)
        {
            throw new System.NotImplementedException();
        }
    }
}
