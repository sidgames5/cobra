import util.MkUtil.mkBool;
import util.MkUtil.mkNull;
import util.MkUtil.mkNumber;
import runtime.Values.ValueType;
import runtime.Environment;
import runtime.Interpreter;
import haxe.io.Bytes;
import sys.io.File;
import compiler.Parser;

using StringTools;

class Main {
	public static final version = "0.1.0";
	static final prompt = 'Cobra v$version> ';

	static final args = Sys.args();

	static final env = new Environment();

	static function main() {
		var options = [];
		var si = 0;

		env.declareVar("true", mkBool(true));
		env.declareVar("false", mkBool(false));
		env.declareVar("null", mkNull());

		for (arg in args) {
			if (arg.startsWith("-")) {
				switch (arg) {
					case "--version", "-v":
						Sys.println('Cobra $version');
					case "--help", "-h":
						Help.print();
				}
				si++;
			}
		}

		// TODO: add checks for arguments
		var ip = args[si];
		var op = args[si + 1];

		if (args.length < 1) {
			while (true) {
				Sys.print(prompt);
				var src = Sys.stdin().readLine();

				final parser = new Parser();

				final program = parser.produceAST(src);

				final result = Interpreter.evaluate(program, env);
				Sys.println(result);
			}
		} else {
			var src = File.getContent(ip);

			final parser = new Parser();

			final program = parser.produceAST(src);

			final result = Interpreter.evaluate(program, env);
			Sys.println(result);
		}
	}
}
