using AST;
using Token;

import Lexer.tokenize;

class Parser {
	public function new() {}

	private var tokens:Array<Token>;

	public function produceAST(src:String):Program {
		this.tokens = tokenize(src);
		final program:Program = {
			kind: Program,
			body: []
		};

		// Parse until EOF
		while (this.not_eof()) {
			program.body.push(this.parse_stmt());
		}

		return program;
	}

	private function at() {
		return this.tokens[0];
	}

	private function eat() {
		final prev = this.tokens.shift();
		return prev;
	}

	private function not_eof():Bool {
		return this.tokens[0].type != EOF;
	}

	private function parse_stmt():Statement {
		// skip to parse_expr

		return this.parse_expr();
	}

	private function parse_expr():Expression {
		return this.parse_additive_expr();
	}

	private function parse_additive_expr():Dynamic {
		var left = this.parse_multiplicative_expr();

		while (this.at().value == "+" || this.at().value == "-") {
			final op = this.eat().value;
			final right = this.parse_multiplicative_expr();
			left = cast {
				kind: BinaryExpr,
				left: left,
				right: right,
				op: op
			};
		}

		return left;
	}

	private function parse_multiplicative_expr():Dynamic {
		var left = this.parse_primary_expr();

		while (this.at().value == "*" || this.at().value == "/") {
			final op = this.eat().value;
			final right = this.parse_primary_expr();
			left = cast {
				kind: BinaryExpr,
				left: left,
				right: right,
				op: op
			};
		}

		return left;
	}

	private function parse_primary_expr():Dynamic {
		final tk = this.at().type;

		switch (tk) {
			case Identifier:
				return {
					kind: Identifier,
					symbol: this.eat().value
				};
			case Number:
				return {
					kind: NumericLiteral,
					value: Std.parseFloat(this.eat().value)
				};
			default:
				Sys.stderr().writeString('Unexpected token: $tk\n');
				Sys.exit(1);
				return {};
		}
	}
}
