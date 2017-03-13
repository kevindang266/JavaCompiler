%namespace M11J1

digit [0-9]
letter [a-zA-Z]

%%

boolean							{ return (int)Tokens.BOOLEAN; }			// Trung Kien Dang - Boolean Literal

.								{
									throw new Exception(String.Format("unexpected character '{0}'", yytext));
								}

%%