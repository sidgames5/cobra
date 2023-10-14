package runtime;

enum ValueType {
	Null;
	Number;
}

typedef RuntimeVal = {
	type:ValueType
}

typedef NullVal = {
	> RuntimeVal,
	value:String
}

typedef NumberVal = {
	> RuntimeVal,
	value:Float
}
