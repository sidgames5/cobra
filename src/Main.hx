import runtime.Interpreter;
import haxe.io.Bytes;
import sys.io.File;
import compiler.Parser;

using StringTools;

class Main {
	public static final version = "0.1.0";
	static final prompt = 'Cobra v$version> ';

	static final args = Sys.args();

	static function main() {
		var options = [];
		var si = 0;

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

		var src = File.getContent(ip);

		final parser = new Parser();

		final program = parser.produceAST(src);

		final result = Interpreter.evaluate(program);
		Sys.println(result);
	}
}
