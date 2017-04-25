using System;
using System.Linq;

namespace M11J1.AST
{
    public abstract class Statement : Node
    {
        public LexicalScope LexicalScope { get; set; }
    }

    public class ExpressionStatement : Statement
    {
        private Expression _expression;

        public ExpressionStatement(Expression expression)
        {
            this._expression = expression;
        }

        public override void Dump(int indent)
        {
            
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }

    public class VariableDeclaration : Statement, IDeclaration
    {
        private Type _type;
        private string _name;
        public string DeclarationId { get; set; }

        public VariableDeclaration(Type type, string name)
        {
            this._type = type;
            this._name = name;
            this.LexicalScope = new LexicalScope();
        }

        public override void Dump(int indent)
        {
            Label(indent, "{0}: VariableDeclaration {1}\n", GenerateId(), _name);
            _type.Dump(indent + 1);
        }

        public string GetName()
        {
            return _name;
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return _type.ResolveNames(scope);
        }

        public string GenerateId()
        {
            string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            string id = new string(Enumerable.Repeat(chars, 8)
                .Select(s => s[random.Next(s.Length)]).ToArray());
            DeclarationId = id;
            return id;
        }
    }
}
