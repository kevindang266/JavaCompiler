using System;
using System.Collections.Generic;

namespace M11J1.AST
{
    public abstract class Statement : Node
    {
        public LexicalScope LexicalScope { get; set; }
    }

    public class IfThenStatement : Statement
    {
        private readonly Expression _cond;
        private readonly Statement _thenStmt;

      public IfThenStatement(Expression cond,Statement thenStmt)
        {
            _cond = cond;
            _thenStmt = thenStmt;
        }


        public override void Dump(int indent)
        {
            
            Label(indent, "IfThenStatement\n");
            _cond.Dump(indent + 1, "cond");
            _thenStmt.Dump(indent + 1, "then");
            
        }
    }

    public class WhileStatement : Statement
    {

        private readonly Expression _cond;
        public WhileStatement(Expression cond)
        {
            _cond = cond;

      }

    public override void Dump(int indent)
        {
            
            Label(indent, "WhileStatement\n");
            _cond.Dump(indent + 1, "cond");
        }
    }



    public class IfStatement : Statement
    {
        private Expression cond;
        private Statement thenStmt, elseStmt;

        public IfStatement(Expression cond, Statement thenStmt, Statement elseStmt)
        {
            this.cond = cond;
            this.thenStmt = thenStmt;
            this.elseStmt = elseStmt;
        }

        public override void Dump(int indent)
        {
            Label(indent, "IfStatement\n");
            cond.Dump(indent + 1, "cond");
            thenStmt.Dump(indent + 1, "then");
            elseStmt.Dump(indent + 1, "else");
        }

        
    }

    public class IfThenElseStatement : Statement
    {
        private readonly Expression _cond;
        private readonly Statement _thenStmt;
        private readonly Statement _elseStmt;

        public IfThenElseStatement(Expression cond, Statement thenStmt, Statement elseStmt)
        {
            _cond = cond;
            _thenStmt = thenStmt;
            _elseStmt = elseStmt;
        }

        public override void Dump(int indent)
        {
            Label(indent, "IfThenElseStatement\n");
            _cond.Dump(indent + 1, "cond");
            _thenStmt.Dump(indent + 1, "then");
            _elseStmt.Dump(indent + 1, "else");
        }

       
    }

    public class ExpressionStatement : Statement
    {
        private readonly Expression _expression;

        public ExpressionStatement(Expression expression)
        {
            _expression = expression;
        }

        public override void Dump(int indent)
        {
            Label(indent, "ExpressionStatement\n");
            _expression.Dump(indent + 1);
        }

        
    }

    public class VariableDeclarationList : Statement, IDeclaration
    {
        private readonly List<VariableDeclaration> _variableNames;

        public VariableDeclarationList(List<VariableDeclaration> variableNames)
        {
            DeclarationIds = new Dictionary<string, string>();
            _variableNames = variableNames;
        }
        public Dictionary<string, string> DeclarationIds { get; set; }

        public List<VariableDeclaration> GetList()
        {
            return _variableNames;
        }

        public Type GetVariableType()
        {
            return null;
        }

        public override void Dump(int indent)
        {
            foreach (var variable in _variableNames)
            {
                var ranId = Guid.NewGuid().ToString().Substring(0, 8); //GenerateId();
                DeclarationIds[variable.GetName()] = ranId;
                variable.DeclarationIds[variable.GetName()] = ranId;

                Label(indent, $"{ranId}: VariableDeclaration: {variable.GetName()}\n");
                variable.GetVariableType().Dump(indent + 1);
            }
        }

       
    }

    public class CompoundStatement : Statement
    {
        private List<Parameter> _globalParameter;
        private readonly List<Statement> _statements;

        public CompoundStatement(List<Statement> stmts)
        {
            _statements = stmts;
            LexicalScope = new LexicalScope();
        }

        public override void Dump(int indent)
        {
            Label(indent, "CompoundStatement\n");
            if (_statements.Count > 0)
                foreach (var statement in _statements)
                    statement?.Dump(indent + 1);
        }

        public void SetGlobalParameter(MethodHeader methodHeader)
        {
            _globalParameter = methodHeader.GetMethodDeclarator().GetParameters();
        }

        

       
    }

    public class VariableDeclaration : Statement, IDeclaration
    {
        private readonly string _name;
        private readonly Type _type;

        public VariableDeclaration(Type type, string name)
        {
            _type = type;
            _name = name;
            DeclarationIds = new Dictionary<string, string>();
        }

        public string DeclarationId { get; set; }
        //private List<string> _variableNames;
        public Dictionary<string, string> DeclarationIds { get; set; }

        public Type GetVariableType()
        {
            return _type;
        }

        public List<VariableDeclaration> GetList()
        {
            return new List<VariableDeclaration> {new VariableDeclaration(_type, _name)};
        }

        public override void Dump(int indent)
        {
            //if (_variableNames != null && _variableNames.Count > 0)
            //{
            //    foreach (var variableName in _variableNames)
            //    {
            //        var ranId = Guid.NewGuid().ToString().Substring(0, 8);
            //        DeclarationIds[variableName] = ranId;
            //        Label(indent, $"{ ranId}: VariableDeclaration: {variableName}\n");
            //        _type.Dump(indent, "type");
            //    }
            //}
            //else
            //{
            var ranId = Guid.NewGuid().ToString().Substring(0, 8);
            DeclarationIds[_name] = ranId;
            DeclarationId = ranId;
            Label(indent, $"{ranId}: VariableDeclaration: {_name}\n");
            _type.Dump(indent + 1, "type");
            //}
        }

        public string GetName()
        {
            return _name;
        }

        
    }
}