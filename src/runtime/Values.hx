package runtime;

enum ValueType {
	Null;
	Number;
	Bool;
}

typedef RuntimeVal = {
	type:ValueType
}

typedef NullVal = {
	> RuntimeVal,
	value:String
}

typedef BoolVal = {
	> RuntimeVal,
	value:Bool
}

typedef NumberVal = {
	> RuntimeVal,
	value:Float
}
