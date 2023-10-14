import haxe.io.Bytes;
import sys.io.File;

using StringTools;

class Main {
	static final version = "0.1.0";
	static final prompt = 'Cobra v$version> ';

	static function main() {
		var file = Sys.args()[0];

		final parser = new Parser();

		while (true) {
			Sys.print(prompt);
			final input = Sys.stdin().readLine();

			if (input.contains("exit")) {
				Sys.exit(0);
			}

			final program = parser.produceAST(input);
			Sys.println(program);
		}
	}
}
