/// Solve me first
/// https://www.hackerrank.com/challenges/solve-me-first
public func solveMeFirst() {
    let a: Int = readLn()
    let b: Int = readLn()
    println(a + b)
}

#if CLI_BUILD
    import StdIO
    // silence the xcode, it doesn't like just calling solveMeFirst() directly
    let x: Void = solveMeFirst()
#endif
