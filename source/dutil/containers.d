module dutil.containers;

public import containers;

ref HashSet!E add(E)(ref HashSet!E hashset, E[] vs ...) {
    foreach(v; vs) {
        hashset.insert(v);
    }
    return hashset;
}
