/// Solve me first
/// https://www.hackerrank.com/challenges/solve-me-first
public func solveMeFirst() {
// getLine returns as string
// readLn - gets a string then reads (converts) to a given type
// TODO: have a look at haskel stdin to see what's the core set of methods

// most often used: readLn, getLine, read
// readLn without convertion should be just like getLine, but have a look at the sum example
// it sums two ints, how?

// have a look at treplicateM, should the same be used here?
// this will allow to read custom input
// not just COUNT:[ARR] format,but COUNT1:[ARR1] COUNT2:[ARR2] and so on

// and finally mapM_ what's with that thing?
///
///:param: max specifies the number of bytes to read
///:returns: the string, or nil if an error was encountered trying to read Stdin
    let a: Int = readLn()
    let b: Int = readLn()
    println(a + b)
}

#if CLI
    import StdIO
    // silence the xcode, it doesn't like just calling solveMeFirst() directly
    let x: Void = solveMeFirst()
#endif
