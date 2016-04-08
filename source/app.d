import std.stdio;
import dutil.containers;

void main()
{
    HashSet!string set;
    set.add("1", "2");
    writeln(set[]);
}
