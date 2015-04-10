/// Solve me second
/// https://www.hackerrank.com/challenges/solve-me-second
public func solveMeSecond() {
    let n: Int = readLn()

    let s: String = readLn()
    for _ in 0..<n {
       let ints: [Int] = readLn()
        // 1.2 wants combine:
       let sum = ints.reduce(0, combine: +)
       println(sum)
    }
}

#if CLI_BUILD
    import StdIO
    // silence the xcode, it doesn't like just calling funcName() directly
    let x: Void = solveMeSecond()
#endif
