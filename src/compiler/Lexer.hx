package compiler;

import compiler.Token.KEYWORDS;

using compiler.Token;

class Lexer {
	public static function tokenize(source:String):Array<Token> {
		var tokens = new Array<Token>();

		var buffer = "";

		var src = source.split("");

		while (src.length > 0) {
			if (src[0] == "(")
				tokens.push(token(src.shift(), OpenBracket));
			else if (src[0] == ")")
				tokens.push(token(src.shift(), CloseBracket));
			else if (src[0] == "+" || src[0] == "-")
				tokens.push(token(src.shift(), BinOp));
			else if (src[0] == "*" || src[0] == "/")
				tokens.push(token(src.shift(), BinOp));
			else if (src[0] == "=")
				tokens.push(token(src.shift(), Equals));
			else {
				// Handle multi-char tokens

				if (isInt(src[0])) {
					// Number token
					var num = "";
					while (src.length > 0 && isInt(src[0]))
						num += src.shift();
					tokens.push(token(num, Number));
				} else if (isAlpha(src[0])) {
					// Identifier token
					var ident = "";
					while (src.length > 0 && isAlpha(src[0]))
						ident += src.shift();
					// check for reserved keywords
					final reserved = KEYWORDS[ident];
					if (reserved == null)
						tokens.push(token(ident, Identifier));
					else
						tokens.push(token(ident, reserved));
				} else if (isSkippable(src[0])) {
					src.shift();
				} else {
					Sys.println("ERROR: Unknown character: " + src[0]);
					Sys.exit(1);
				}
			}
		}

		tokens.push(token("EndOfFile", EOF));
		return tokens;
	}

	public static function token(value:String = "", type:TokenType):Token {
		return {value: value, type: type};
	}

	public static function isAlpha(src:String):Bool {
		return src.toUpperCase() != src.toLowerCase();
	}

	public static function isInt(src:String):Bool {
		final c = src.charCodeAt(0);
		final bounds = ["0".charCodeAt(0), "9".charCodeAt(0)];
		return c >= bounds[0] && c <= bounds[1];
	}

	public static function isSkippable(src:String):Bool {
		return src == " " || src == "\t" || src == "\n" || src == "\r";
	}
}
