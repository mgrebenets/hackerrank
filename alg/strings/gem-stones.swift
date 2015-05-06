/// Gem Stones
/// https://www.hackerrank.com/challenges/gem-stones
public func gemStones() {
    let n: Int = readLn()
    var input: [Set<Character>] = []
    for _ in 0..<n {
        input.append(Set(getLine()))
    }

    // TODO: this is ugly, find a better way to get all latin1 chars
    // for example look for a way to use "a"..."z" range
//    println("a"..."z")
//    println(String(stringInterpolationSegment: "a"..."z"))
//    let asciiSet1 = Set(String(stringInterpolationSegment: "a"..."z"))
//    println(asciiSet1)
    // map("a"..."z", println)    
    let asciiSet = Set("abcdefghijklmnopqrstuvwxyz")
    println(asciiSet)
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
