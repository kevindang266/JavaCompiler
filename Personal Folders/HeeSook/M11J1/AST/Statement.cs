using System;
using System.Collections.Generic;
using System.Text;

namespace M11J1.AST
{
    public abstract class Statement : Node
    {
        public LexicalScope LexicalScope { get; set; }
    }

    //BasicForStatement
    //	: For '(' Assignment ';' Expression ';' ForUpdate ')' Statement 
    /*
    public class BasicForStatement : Statement
    {
        private readonly Statement _variableDeclaration;
        private readonly Expression _forcond;
        //private readonly Expression _forupdate;
        private readonly Statement _forstmt;

        public BasicForStatement(Statement variableDeclaration, Expression forcond,  Expression forupdat,  Statement forstmt)
        {
            _variableDeclaration = variableDeclaration;
            _forcond = forcond;
            //_forupdate = forupdat;
            _forstmt = forstmt;
        }

        public override void Dump(int indent)
        {
            Label(indent, "BasckForStatement\n");
            _variableDeclaration.Dump(indent + 1, "forinit");
            _forcond.Dump(indent + 1, "forcond");
           // _forupdate.Dump(indent + 1, "forupdat");
            _forstmt.Dump(indent + 1, "forstmt");
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _variableDeclaration.ResolveNames(scope);
            _forcond.ResolveNames(scope);
            //_forupdate.ResolveNames(scope);
            _forstmt.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _variableDeclaration.TypeCheck();
            _forcond.TypeCheck();
            if (!_forcond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            //_forupdate.TypeCheck();
            _forstmt.TypeCheck();
        }
    }
*/

    /*WhileStatement
    WhileStatement:
while ( Expression ) Statement  
         
         */

    public class WhileStatement : Statement
    {
        private readonly Expression _cond;
        private readonly Statement _whilestmt;

        public WhileStatement(Expression cond, Statement whilestmt)
        {
            _cond = cond;
            _whilestmt = whilestmt;
        }

        public override void Dump(int indent)
        {
            Label(indent, "WhileStatement\n");
            _cond.Dump(indent + 1, "cond");
            _whilestmt.Dump(indent + 1, "whilestmt");
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _cond.ResolveNames(scope);
            _whilestmt.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _cond.TypeCheck();
            if (!_cond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for while statement condition\n");
                throw new Exception("TypeCheck error");
            }
            _whilestmt.TypeCheck();
        }

        public override void GenCode(string file)
        {
            _cond.GenCode(file);
            int label = Global.LastLabel++;
            Emit(file, "Br.s while statement", label);
            _whilestmt.GenCode(file);
            Emit(file, "while statement:", label);
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

        public override void GenCode(string file)
        {
            _cond.GenCode(file);
            int elseLabel = Global.LastLabel++;
            Emit(file, "brfalse L{0}", elseLabel);
            _thenStmt.GenCode(file);
            Emit(file, "L{0}:", elseLabel);
            _elseStmt.GenCode(file);
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

        public override void GenCode(string file)
        {
            _expression.GenCode(file);
            Emit(file, "pop");
        }
    }

    /*
     * VariableDeclarationList will be used for multiple declaration.
     * For example: int x, y, z;
     * VariableDeclarationList extends Statement implements IDeclaration
     * This is a statement that can be recognise by IDeclaration when adding variables to Lexical Scope
     */
    public class VariableDeclarationList : Statement, IDeclaration
    {
        private readonly List<VariableDeclaration> _variableNames;

        public VariableDeclarationList(List<VariableDeclaration> variableNames)
        {
            DeclarationIds = new Dictionary<string, string>();
            VariableValues = new Dictionary<string, string>();
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
                variable.Dump(indent);
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
        public Dictionary<string, string> VariableValues { get; set; }

        public override void GenCode(string file)
        {
            foreach (var variableDeclaration in _variableNames)
            {
                variableDeclaration.GenCode(file);
            }
        }

        public int GetNumber(string variableId)
        {
            return int.Parse(VariableValues[variableId]);
        }

        public int GetNumber()
        {
            return 0;
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

        public override void GenCode(string file)
        {
            foreach (var statement in _statements)
            {
                statement.GenCode(file);
            }
        }
    }

    public class VariableDeclaration : Statement, IDeclaration
    {
        private readonly string _name;
        private readonly Type _type;
        private int _num;

        public VariableDeclaration(Type type, string name)
        {
            _type = type;
            _name = name;
            DeclarationIds = new Dictionary<string, string>();
            VariableValues = new Dictionary<string, string>();
        }

        public string DeclarationId { get; set; }
        public Dictionary<string, string> DeclarationIds { get; set; }
        public Dictionary<string, string> VariableValues { get; set; }

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

            var ranId = Guid.NewGuid().ToString().Substring(0, 8);
            DeclarationIds[_name] = ranId;
            DeclarationId = ranId;
            Label(indent, $"{ranId}: VariableDeclaration: {_name}\n");
            _type.Dump(indent + 1, "type");

        }

        public string GetName()
        {
            return _name;
        }

        public int GetNumber()
        {
            return _num;
        }

        public override void ResolveNames(LexicalScope scope)
        {
            var ranId = Guid.NewGuid().ToString().Substring(0, 8);
            DeclarationIds[_name] = ranId;
            DeclarationId = ranId;
            _type.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _type.TypeCheck();
        }

        public override void GenCode(string file)
        {
            _num = Global.LastLocal++;
            Emit(file, ".locals init ([{0}] {1} {2})", _num, _type.CLRName(), _name);
            VariableValues[DeclarationIds[_name]] = _num.ToString();
        }

        public int GetNumber(string variableId)
        {
            //return _num;
            return int.Parse(VariableValues[variableId]);
        }
    }
}