using System;

namespace M11J1.AST
{
    public abstract class Expression : Node
    {
        public Type Type;
        public virtual void GenStoreCode(string file)
        {
            throw new Exception("invalid assignment");
        }
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

        public override void ResolveNames(LexicalScope scope)
        {
            _lhs.ResolveNames(scope);
            _rhs.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _lhs.TypeCheck();
            _rhs.TypeCheck();
            if (!_rhs.Type.Compatible(_lhs.Type))
            {
                Console.WriteLine("type error in assignment\n");
                throw new Exception("TypeCheck error");
            }
            Type = _rhs.Type;
        }

        public override void GenCode(string file)
        {
            _rhs.GenCode(file);
            _lhs.GenStoreCode(file);
            _rhs.GenCode(file);
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

        public override void ResolveNames(LexicalScope scope)
        {
            if (scope != null)
                _declaration = scope.Resolve(_name);

            if (_declaration == null)
            {
                Console.WriteLine("Error: Undeclared identifier {0}\n", _name);
                throw new Exception("Name Resolution error");
            }
        }

        public override void TypeCheck()
        {
            Type = _declaration.GetVariableType();
        }

        public override void GenCode(string file)
        {
            Emit(file, "ldloc {0}", _declaration.GetNumber(_declaration.DeclarationIds[_name]));
        }

        public override void GenStoreCode(string file)
        {
            Emit(file, "stloc {0}", _declaration.GetNumber(_declaration.DeclarationIds[_name]));
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

        public override void ResolveNames(LexicalScope scope)
        {
        }

        public override void TypeCheck()
        {
            Type = new IntType();
        }

        public override void GenCode(string file)
        {
            Emit(file, "ldc.i4 {0}", _value);
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

        public override void ResolveNames(LexicalScope scope)
        {
            _lhs.ResolveNames(scope);
            _rhs.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _lhs.TypeCheck();
            _rhs.TypeCheck();

            switch (_op)
            {
                case '<':
                    if (!_lhs.Type.Equal(new IntType()) || !_rhs.Type.Equal(new IntType()))
                    {
                        Console.WriteLine("invalid arguments for less than expression\n");
                        throw new Exception("TypeCheck error");
                    }
                    Type = new BoolType();
                    break;
                case '+':
                    if (!_lhs.Type.Equal(new IntType()) || !_rhs.Type.Equal(new IntType()))
                    {
                        Console.WriteLine("invalid arguments for addition expression\n");
                        throw new Exception("TypeCheck error");
                    }
                    Type = new IntType();
                    break;
                default:
                    {
                        Console.WriteLine($"Unexpected binary operator '{_op}'\n");
                        throw new Exception("TypeCheck error");
                    }
            }
        }

        public override void GenCode(string file)
        {
            _lhs.GenCode(file);
            _rhs.GenCode(file);
            switch (_op)
            {
                case '<':
                    Emit(file, "clt");
                    break;
                case '+':
                    Emit(file, "add");
                    break;
                default:
                    {
                        Console.WriteLine("Unexpected binary operator '{0}'\n", _op);
                        throw new Exception("GenCode error");
                    }
            }
        }
    }
}
