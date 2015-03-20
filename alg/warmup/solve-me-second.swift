/// Solve me second
/// https://www.hackerrank.com/challenges/solve-me-second
public func solveMeSecond() {
    let n: Int = readLn()

    let s: String = readLn()
    for _ in 0..<n {
       let ints: [Int] = readLn()
       let sum = ints.reduce(0, +)
       println(sum)
    }
}

#if CLI_BUILD
    import StdIO
    // silence the xcode, it doesn't like just calling solveMeFirst() directly
    let x: Void = solveMeSecond()
#endif
