typedef Token = {
	value:String,
	type:TokenType
}

enum TokenType {
	Null;

	Number;
	Identifier;
	Equals;
	Var;
	OpenBracket;
	CloseBracket;

	BinOp;

	EOF;
}

final KEYWORDS = ["var" => Var, "null" => Null];
