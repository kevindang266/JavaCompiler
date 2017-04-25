using System;

namespace M11J1.AST
{
    public abstract class Expression : Node
    {
    }

    public class ExpressionName : Expression
    {
        private string _identifier;

        public ExpressionName(string identifier)
        {
            this._identifier = identifier;
        }

        public override void Dump(int indent)
        {
            
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }

    public class IntegerLiteral : Expression
    {
        private int _value;

        public IntegerLiteral(int value)
        {
            this._value = value;
        }

        public override void Dump(int indent)
        {
            
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }
    public class AssignmentExpression : Expression
    {
        private Expression _lhs, _rhs;
        
        public AssignmentExpression(Expression lhs, Expression rhs)
        {
            this._lhs = lhs;
            this._rhs = rhs;
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
