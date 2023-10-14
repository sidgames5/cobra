class Help {
	public static function print() {
		Sys.println("Cobra v" + Main.version);
		bar("-");
		Sys.println("Usage: cobra [options] input output");
		bar("-");
		Sys.println("--version, -v | Prints the current version of cobra");
		Sys.println("--help, -h    | Prints the help menu");
	}

	private static function bar(char:String) {
		for (c in 0...("Cobra v" + Main.version).length) {
			Sys.print(char);
		}
		Sys.print("\n");
	}
}
