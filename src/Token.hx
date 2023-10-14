typedef Token = {
	value:String,
	type:TokenType
}

enum TokenType {
	Number;
	Identifier;
	Equals;
	Var;
	OpenBracket;
	CloseBracket;

	BinOp;

	EOF;
}

final KEYWORDS = ["var" => Var];
