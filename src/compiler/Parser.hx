package compiler;

using compiler.AST;
using compiler.Token;

import compiler.Lexer.tokenize;

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

	private function eat(?rt:TokenType = null, ?msg:String = "Missing") {
		final prev = this.tokens.shift();
		if (rt != null && prev.type != rt) {
			Sys.stderr().writeString('Error: expected $rt, got ${prev.type}\n');
			Sys.exit(1);
		}
		return prev;
	}

	private function not_eof():Bool {
		return this.tokens[0].type != EOF;
	}

	private function parse_stmt():Statement {
		// skip to parse_expr

		switch (this.at().type) {
			case TokenType.Var:
				return this.parse_var_declaration();
			case TokenType.Final:
				return this.parse_var_declaration();

			default:
				return this.parse_expr();
		}
	}

	// var ident;
	// ( var | final ) ident = expr;
	private function parse_var_declaration():Statement {
		final isConstant = this.eat().type == TokenType.Final;
		final identifier = this.eat(TokenType.Identifier).value;

		if (this.at().type == TokenType.Semicolon) {
			this.eat();
			if (isConstant) {
				Sys.stderr().writeString("Error: final variable must be initialized");
				Sys.exit(1);
				return null;
			}

			var r:VarDeclaration = {
				kind: VarDeclaration,
				key: identifier,
				constant: false
			};
			return r;
		}

		this.eat(TokenType.Equals);
		final declaration:VarDeclaration = {
			kind: VarDeclaration,
			value: this.parse_expr(),
			key: identifier,
			constant: isConstant
		};

		return declaration;
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
			case OpenBracket:
				this.eat();
				final value = this.parse_expr();
				this.eat(CloseBracket);
				return value;
			default:
				Sys.stderr().writeString('Unexpected token: $tk\n');
				Sys.exit(1);
				return {};
		}
	}
}
