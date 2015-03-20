/// Pangrams
/// https://www.hackerrank.com/challenges/pangrams
public func pangrams() {
    let line = getLine()
    let characters = Set(line.stringByReplacingOccurrencesOfString(" ", withString: ""))
    let result = characters.count == 26 ? "pangram" : "not pangram"
    println(result)
}

#if CLI_BUILD
    import StdIO
    // silence the xcode, it doesn't like just calling solveMeFirst() directly
    let x: Void = solveMeFirst()
#endif
