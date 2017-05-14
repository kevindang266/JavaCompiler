using System;

namespace M11J1.AST
{
    public abstract class Expression : Node
    {
        public Type Type;
    }
    public class AssignmentExpression : Expression
    {
        private Expression _lhs, _rhs;
        
        public AssignmentExpression(Expression lhs, Expression rhs)
        {
            _lhs = lhs;
            _rhs = rhs;
        }

        public override void Dump(int indent)
        {
            Label(indent, "AssignmentExpression\n");
            Type.Dump(indent + 1, "type");
            _lhs.Dump(indent + 1, "lhs");
            _rhs.Dump(indent + 1, "rhs");
        }

       
    }

    public class IdentifierExpression : Expression
    {
        private string _name;
        private IDeclaration _declaration;
        public IdentifierExpression(string name)
        {
            _name = name;
            _declaration = null;
        }

        public override void Dump(int indent)
        {
            Label(indent,
                _declaration != null
                    ? $"IdentifierExpression {_name} -> {_declaration.DeclarationIds[_name]}\n"
                    : $"IdentifierExpression {_name}\n");
            Type.Dump(indent + 1, "type");
        }

        
    }

    public class NumberExpression : Expression
    {
        private int _value;
        public NumberExpression(int value)
        {
            _value = value;
        }

        public override void Dump(int indent)
        {
            Label(indent, $"NumberExpression {_value}\n" );
            Type.Dump(indent + 1, "type");
        }

       
    }

    public class BinaryExpression : Expression
    {
        private char _op;
        private Expression _lhs, _rhs;
        public BinaryExpression(Expression lhs, char op, Expression rhs)
        {
            _op = op;
            _lhs = lhs;
            _rhs = rhs;
        }
        public override void Dump(int indent)
        {
            Label(indent, "BinaryExpression {0}\n", _op);
            Type.Dump(indent + 1, "type");
            _lhs.Dump(indent + 1, "lhs");
            _rhs.Dump(indent + 1, "rhs");
        }

       
    }
}
