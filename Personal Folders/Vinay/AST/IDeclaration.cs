using System.Collections.Generic;

namespace M11J1.AST
{
    public interface IDeclaration
    {
        Type GetVariableType();
        Dictionary<string, string> DeclarationIds { get; set; }
        List<VariableDeclaration> GetList();
    }
}
