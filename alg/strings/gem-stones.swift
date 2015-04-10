/// Gem Stones
/// https://www.hackerrank.com/challenges/gem-stones
public func gemStones() {
    let n: Int = readLn()
    var input: [Set<Character>] = []
    for _ in 0..<n {
        input.append(Set(getLine()))
    }

    // TODO: this is ugly, find a better way to get all latin1 chars
    let asciiSet = Set("abcdefghijklmnopqrstuvwxyz")
    let intersection = input.reduce(asciiSet) { acc, str in
        acc.intersect(str)
    }
    println(intersection.count)
}

#if CLI_BUILD
    import StdIO
    // silence the xcode, it doesn't like just calling funcName() directly
    let x: Void = gemStones()
#endif
