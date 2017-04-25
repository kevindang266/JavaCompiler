namespace M11J1.AST
{
    public interface IDeclaration
    {
        string DeclarationId { get; set; }
        string GetName();
        string GenerateId();
    }
}
