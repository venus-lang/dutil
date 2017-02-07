module dutil.nogc;

import std.traits : isFunctionPointer, isDelegate, functionAttributes, FunctionAttribute, SetFunctionAttributes, functionLinkage;

static auto ngcptr(T)(T f) if (isFunctionPointer!T ||
            isDelegate!T)
{
    enum attrs = functionAttributes!T | FunctionAttribute.nogc;
    return cast(SetFunctionAttributes!(T, functionLinkage!T, attrs)) f;
};

/// For normal functions
auto ngc(alias Func, T...)(T xs) @nogc { return ngcptr(&Func)(xs); }

/// For templates
auto tngc(alias Func, T...)(T xs) @nogc { return ngcptr(&Func!T)(xs); }

/// For debug writeln
nothrow pure
void dln(string file = __FILE__, uint line = __LINE__, string fun = __FUNCTION__, Args...)(Args args) {
    try {
        import std.stdio : writeln;
        debug tngc!writeln(file, ":", line, ":", " debug: ", args);
    } catch (Exception) { } 
}


@nogc
unittest {
    import std.stdio: writeln;

    // templated nogc 
    tngc!writeln("hello");

    // normal nogc
    int myadd(int a, int b) { return a + b; }
    assert(4 == ngc!myadd(1, 3));


}
