package compiler;

typedef Token = {
	value:String,
	type:TokenType
}

enum TokenType {
	// Literal types
	Number;
	Identifier;

	// Keywords
	Var;
	Final;

	// Grouping, Operators
	Equals;
	OpenBracket;
	CloseBracket;
	BinOp;
	Semicolon;

	// End of file
	EOF;
}

final KEYWORDS = ["var" => Var, "final" => Final];
