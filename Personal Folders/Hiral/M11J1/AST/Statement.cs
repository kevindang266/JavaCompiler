using System;
using System.Collections.Generic;
using System.Text;

namespace M11J1.AST
{
    public abstract class Statement : Node
    {
        public LexicalScope LexicalScope { get; set; }
    }
    public class IfThenStatement : Statement
    {
        private Expression cond;
        private Statement thenstmt;

        public IfThenStatement(Expression cond, Statement thenstmt)
        {
            _cond = cond;
            _thenStmt = thenStmt;



    public override void Dump(int indent)
        {

            Label(indent, "IfThenStatement\n");
            _cond.Dump(indent + 1, "cond");
            _thenStmt.Dump(indent + 1, "then");

        }

        public override void ResolveNames(LexicalScope scope)
        {

            if (_thenStmt == null)
            {
                _cond.ResolveNames(scope);
                _thenStmt.ResolveNames(scope);
            }

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

    public class BlockStatement : Statement
    {
        private Statement varStatement;
        private Expression expStatement;
        public BlockStatement(Statement varStatement, Expression expStatement)
        {
            this.varStatement = varStatement;
            this.expStatement = expStatement;
        }

        public override void Dump(int indent)
        {
            Label(indent, "BLockStatement\n");
            _cond.Dump(indent + 1, "cond");
            varStatement.Dump(indent + 1, "");
            expStatement.Dump(indent + 1, "");
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _cond.ResolveNames(scope);
            varStatement.ResolveNames(scope);
            expStatement.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _cond.TypeCheck();
            if (!_cond.Type.Equal(new BoolType()))
            {
                Console.WriteLine("Invalid type for block statement condition\n");
                throw new Exception("TypeCheck error");
            }
            expStatement.TypeCheck();
            varStatement.TypeCheck();
        }

        public override void GenCode(string file)
        {
            _cond.GenCode(file);
            int Label = Global.LastLabel++;
            Emit(file, "brfalse L{0}", Label);
            expStatement.GenCode(file);
            Emit(file, "L{0}:", Label);
            varStatement.GenCode(file);
        }
    }

    public class WhileStatement : Statement
    {

        private Expression _cond;
        private Statement _state;

        public WhileStatement(Expression _cond, Statement _state)
        {
            this.Cond = _cond;
            this.Statements = _state;
        }

        public override void Dump(int indent)
        {
            Label(indent, "WhileStatement\n");
            cond.Dump(indent + 1, "Expression");
            stat.Dump(indent + 1, "Statement");
        }
        public override bool ResolveNames(LexicalScope scope)
        {

            var newScope = getNewScope(scope, null);

            return _cond.ResolveNames(newScope) & _state.ResolveNames(newScope);
        }
        public override void TypeCheck()
        {
            this.Cond.TypeCheck();

            if (!Cond.type.isTheSameAs(new NamedType("BOOLEAN")))
            {
                System.Console.WriteLine("Type error in WhileStatement\n");
                throw new Exception("TypeCheck error");
            }

            Statements.TypeCheck();
        }
        public override void GenCode(StringBuilder xy)
        {
            int CodeLabel, TestLabel, FinalLabel;

            CodeLabel = LastLabel++;
            TestLabel = LastLabel++;
            FinalLabel = LastLabel++;

            cg.emit(xy, "\tbr.s\tL{0}\n", TestLabel);
            cg.emit(xy, "L{0}:\n", CodeLabel);
            Statements.GenCode(sb);
            cg.emit(xy, "L{0}:\n", TestLabel);
            Cond.GenCode(sb);
            cg.emit(xy, "L{0}:", FinalLabel);
            cg.emit(xy, "\tbrtrue.s\tL{0}\n", CodeLabel);
        }

    }
    public class IfStatement : Statement
    {
        private Expression exp;
        private Statement ThenStmts, ElseStmts;
        public IfStatement(Expression Expr, Statement ThenStmts, Statement ElseStmts)
        {
            this.exp = exp; this.ThenStmts = ThenStmts; this.ElseStmts = ElseStmts;
        }

        public override void Dump(int indent)
        {
            Label(indent, "IfStatement\n");
            exp.Dump(indent + 1);
            ThenStmts.Dump(indent + 1);
            ElseStmts.Dump(indent + 1);
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            var newScope = getNewScope(scope, null);

            if (ElseStmts == null)
                return CondExpr.ResolveNames(newScope) & ThenStmts.ResolveNames(newScope);
            else
                return CondExpr.ResolveNames(newScope) & ThenStmts.ResolveNames(newScope) & ElseStmts.ResolveNames(newScope);
        }

        public override void TypeCheck()
        {
            Expr.TypeCheck();

            if (!CondExpr.type.isTheSameAs(new NamedType("BOOLEAN")))
            {
                Console.WriteLine("Invalid type for if statement condition\n");
                throw new Exception("TypeCheck error");
            }
            ThenStmts.TypeCheck();
            if (ElseStmts != null)
                ElseStmts.TypeCheck();
        }

        public override void GenCode(StringBuilder sb)
        {
            CondExpr.GenCode(sb);

            int elseLabel = LastLabel++;
            int endLabel = 0;
            cg.emit(sb, "\tbrfalse L{0}\n", elseLabel);
            ThenStmts.GenCode(sb);
            if (ElseStmts != null)
            {
                endLabel = LastLabel++;
                cg.emit(sb, "\tbr L{0}\n", endLabel);
            }
            cg.emit(sb, "L{0}:\n", elseLabel);
            if (ElseStmts != null)
            {
                ElseStmts.GenCode(sb);
                cg.emit(sb, "L{0}:\n", endLabel);
            }
        }
    }
    public class LabeledStatement : Statement
    {
        
        private string name;
        private statement stat;

        public LabeledStatement(string name, Statement stat)
        {
            this.name = name;
            this.statement = stat;
        }

        public override void Dump(int indent)
        {
            Label(indent, "LabelStatement\n");
            name.Dump(indent + 1, "Name");
            stat.Dump(indent + 1, "Statement");
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return statement.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            statement.TypeCheck();
        }
        public override void GenCode()
        {

        }
    }

    public class BreakStatement : Statement
    {
        
        private String str;

        public BreakStatement(String str)
        {
            this.Name = str;
        }
        public override void Dump(int indent)
        {
            Label(indent, "BreakStatement\n");
            str.Dump(indent + 1, "String");
           
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
        public override void TypeCheck()
        {
            
        }
        public override void GenCode()
        {
            

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
            return new List<VariableDeclaration> { new VariableDeclaration(_type, _name) };
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

    public class SwitchStatement : Statement
    {

        private Expression expression;
        private List<Statement> block;

        public SwitchStatement(Expression exp, List<Statement> block)
        {
            this.expression = exp;
            this.block = block;
        }

        public override void Dump(int indent)
        {
            Label(indent, "Switch Statement\n");
            exp.Dump(indent + 1, "Expression");
            block.Dump(indent + 1, "Block");

        }

        public override bool ResolveNames(LexicalScope scope)
        {

            var newScope = getNewScope(scope, null);

            bool loopResolve = true;

            if (block != null)
            {
                foreach (Statement each in block)
                {
                    Declaration decl = each as Declaration;
                    if (decl != null)
                    {
                        decl.AddItemsToSymbolTable(scope);
                    }
                    loopResolve = loopResolve & each.ResolveNames(scope);
                }
            }

            return loopResolve && expression.ResolveNames(scope);
        }


        public override void TypeCheck()
        {
            this.expression.TypeCheck();

            if (!expression.type.isTheSameAs(new NamedType("INT")))
            {
                System.Console.WriteLine("Type error in SwitchStatement\n");
                throw new Exception("TypeCheck error");
            }

            foreach (SwitchBlockGroup Blk in block)
            {
                Blk.setswichExprType(expression.type);
                Blk.TypeCheck();
            }

        }
       // switch statement require lable for  all of the label statements,so it required to create them and then pass them to any label in the switch blocks.
        /// Also note that if there is a default statement then after the switch block the break statement needs to point to that,
/// otherwise it needs to point to the end of the switch block

        public override void GenCode()
        {
        }
    }
    public class AssertStatement : Statement
    {

        private Expression exp1;
        private Expression exp2;

        public AssertStatement(Expression exp1)
        {
            this.exp1 = exp1;
        }


        public AssertStatement(Expression exp1, Expression exp2)
        {
            this.exp1 = exp1;
            this.exp2 = exp2;
        }

        public override void Dump(int indent)
        {
            Label(indent, "AssertStatement\n");
            exp1.Dump(indent + 1);
            exp2.Dump(indent + 1);
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            var Scope = getNewScope(scope, null);
            bool value = expression1.ResolveNames(Scope);
            if (expression2 != null)
            {
                return value & exp2.ResolveNames(Scope);
            }
            return value;
        }

        public override void TypeCheck()
        {
            this.exp1.TypeCheck();

            if (!expression1.type.isTheSameAs(new NamedType("BOOLEAN")))
            {
                System.Console.WriteLine("Type error in AssertStatement\n");
                throw new Exception("TypeCheck error");
            }

            if (expression2 != null)
            {
                this.expression2.TypeCheck();
                if (expression2.type.isTheSameAs(new NamedType("VOID")))
                {
                    System.Console.WriteLine("Type error in AssertStatement\n");
                    throw new Exception("TypeCheck error");
                }
            }
        }

        public class TryStatement : Statement
        {
            private Statement TryStmts, CatchStmts, FinallyStmts;

            public TryStatement(Statement tryStatements, Statement CatchStmts, Statement FinallyStmts)
            {
                this.TryStmts = tryStatements;
                this.CatchStmts = CatchStmts;
                this.FinallyStmts = FinallyStmts;
            }

            public override bool ResolveNames(LexicalScope scope)
            {
                var newScope = getNewScope(scope, null);
                bool loopResolve = TryStmts.ResolveNames(newScope);
                if (CatchStmts != null)
                    loopResolve = loopResolve & CatchStmts.ResolveNames(newScope);
                if (FinallyStmts != null)
                    loopResolve = loopResolve & FinallyStmts.ResolveNames(newScope);
                return loopResolve;
            }

            public override void TypeCheck()
            {
                TryStmts.TypeCheck();
                if (CatchStmts != null)
                    CatchStmts.TypeCheck();
                if (FinallyStmts != null)
                    FinallyStmts.TypeCheck();
            }
            public override void GenCode()
            {
                
            }

        }

    }



}