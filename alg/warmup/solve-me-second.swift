/// Solve me second
/// https://www.hackerrank.com/challenges/solve-me-second
public func solveMeSecond() {
    let n: Int = readLn()

    for i in 0..<n {
        let ints: [Int] = readLn()
        let sum = ints.reduce(0, +)
        println(sum)
    }
}
