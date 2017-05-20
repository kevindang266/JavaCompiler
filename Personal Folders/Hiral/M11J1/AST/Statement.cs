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

        public override void ResolveNames(LexicalScope scope)
        {
            _cond.ResolveNames(scope);
            _thenStmt.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _cond.TypeCheck();
            if (!_cond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            _thenStmt.TypeCheck();
            
        }
    }

    public class WhileStatement : Statement
    {

        private readonly Expression _cond;
        private readonly Statement _stmt;
        public WhileStatement(Expression cond, Statement stmt)
        {
            _cond = cond;
            _stmt = stmt;

      }

    public override void Dump(int indent)
        {
            
            Label(indent, "WhileStatement\n");
            _cond.Dump(indent + 1, "cond");
            _stmt.Dump(indent + 1, "stmt");

        }

        public override void ResolveNames(LexicalScope scope)
        {
            _cond.ResolveNames(scope);
            _stmt.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _cond.TypeCheck();
            if (!_cond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            _stmt.TypeCheck();
            
        }
    }

    public class forStatement : Statement
    {
        private Expression init;
        private Expression cond;
        private Expression loop;
        private Statement execute;
        

        public forStatement(Expression init, Expression cond, Expression loop, Statement execute)
        {
            this.init = init;
            this.cond = cond;
            this.loop = loop;
            this.execute = execute;
        }
           

        public override void Dump(int indent)
        {
            Label(indent, "ForStatement\n");
            init.Dump(indent + 1, "init");
            cond.Dump(indent + 1, "cond");
            loop.Dump(indent + 1, "loop");
            execute.Dump(indent + 1, "execute");
        }

        public override void ResolveNames(LexicalScope scope)
        {
            init.ResolveNames(scope);
            cond.ResolveNames(scope);
            loop.ResolveNames(scope);
            execute.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            init.TypeCheck();
            cond.TypeCheck();
            loop.TypeCheck();
            if (!init.Type.Equal(new BoolType())&& !cond.Type.Equal(new BoolType())&& !loop.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            execute.TypeCheck();
           
        }
    }



    public class IfStatement : Statement
    {
        private Expression cond;
        private Statement thenStmt, elseStmt;

        public IfStatement(Expression cond, Statement thenStmt)
        {
            this.cond = cond;
            this.thenStmt = thenStmt;
            
        }

        public override void Dump(int indent)
        {
            Label(indent, "IfStatement\n");
            cond.Dump(indent + 1, "cond");
            thenStmt.Dump(indent + 1, "then");
            
        }

        public override void ResolveNames(LexicalScope scope)
        {
            cond.ResolveNames(scope);
            thenStmt.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            cond.TypeCheck();
            if (!cond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            thenStmt.TypeCheck();
           
        }
    }

    public class DoStatement : Statement 
    {
        private Statement _doStmt;
        private Expression _whilecond;
       public DoStatement(Statement doStmt, Expression whilecond)
        {

            _doStmt = doStmt;
            _whilecond = whilecond;
        }


        public override void Dump(int indent)
        {
            Label(indent, "DoStatement\n");
            _doStmt.Dump(indent + 1, "do");
            _whilecond.Dump(indent + 1, "while");
            
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _doStmt.ResolveNames(scope);
            _whilecond.ResolveNames(scope);
            
        }

        public override void TypeCheck()
        {
            _whilecond.TypeCheck();
            if (!_whilecond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for do statement condition\n");
                throw new Exception("TypeCheck error");
            }
            _doStmt.TypeCheck();
            
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

        public override void ResolveNames(LexicalScope scope)
        {
            _cond.ResolveNames(scope);
            _thenStmt.ResolveNames(scope);
            _elseStmt.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _cond.TypeCheck();
            if (!_cond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            _thenStmt.TypeCheck();
            _elseStmt.TypeCheck();
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

    public override void ResolveNames(LexicalScope scope)
    {
        _expression.ResolveNames(scope);
    }

    public override void TypeCheck()
    {
        _expression.TypeCheck();
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

    public override void ResolveNames(LexicalScope scope)
    {
        foreach (var child in _variableNames)
            child.ResolveNames(LexicalScope);
    }

    public override void TypeCheck()
    {
        foreach (var variableDeclaration in _variableNames)
            variableDeclaration.TypeCheck();
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

    public override void ResolveNames(LexicalScope scope)
    {
        LexicalScope.SetParentScope(scope);

        // Add parameter from method declaration to the symbol table for this lexical scope
        if (_globalParameter != null)
            foreach (var parameter in _globalParameter)
            {
                var decl = parameter.GetVariableDeclaration() as IDeclaration;
                if (decl != null)
                    foreach (var name in decl.GetList())
                        LexicalScope.SymbolTable[name.GetName()] = name;
            }

        // Add local variable declarations to the symbol table for this lexical scope
        foreach (var child in _statements)
        {
            var decl = child as IDeclaration;
            if (decl != null)
                foreach (var name in decl.GetList())
                    LexicalScope.SymbolTable[name.GetName()] = name;
        }

        foreach (var child in _statements)
        {
            child?.ResolveNames(LexicalScope);
        }
    }

    public override void TypeCheck()
    {
        foreach (var statement in _statements)
        {
            statement?.TypeCheck();
        }
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
        return new List<VariableDeclaration> { new VariableDeclaration(_type, _name) };
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

    public override void ResolveNames(LexicalScope scope)
    {
        _type.ResolveNames(scope);
    }

    public override void TypeCheck()
    {
        _type.TypeCheck();
    }
}
}