namespace M11J1.AST
{
    public class CompilationUnit : Node
    {
        private ClassDeclaration _classDeclaration;
        private string _compilationName;

        public CompilationUnit (ClassDeclaration classDeclaration)
        {
            _compilationName = "Test";
            _classDeclaration = classDeclaration;
            _classDeclaration.CompilationName = _compilationName;
        }

        public override void Dump(int indent)
        {
            Label(indent, "Compilation Unit\n");
            _classDeclaration.Dump(indent, "Class Declaration");
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _classDeclaration.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _classDeclaration.TypeCheck();
        }

        public override void GenCode(string file)
        {
            Emit(file, ".assembly {0} {{}}", _compilationName);
            _classDeclaration.GenCode(file);
        }
    }
}
