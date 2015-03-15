import Foundation


// haskell ref
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

/// Reads a line from standard input
///
///:param: max specifies the number of bytes to read
///:returns: the string, or nil if an error was encountered trying to read Stdin
public func getLine(max: Int = Int.max) -> String {
  assert(max > 0, "max must be between 1 and Int.max")

  var buf = String()
  var c = getchar()
  // 10 is ascii code for newline
  while c != EOF && c != 10 && countElements(buf) < max {
      buf.append(UnicodeScalar(UInt32(CChar(c))))
      c = getchar()
  }
  return buf
}

// Read line and convert to integer
public func readLn(max: Int = Int.max) -> Int {
  return getLine(max: max).toInt()!
}

// Read line and convert to array of strings (words)
public func readLn(max: Int = Int.max) -> [String] {
  return getLine(max: max).componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
}

// Read line and convert to array of integers
public func readLn(max: Int = Int.max) -> [Int] {
  let words: [String] = readLn(max: max)
  return words.map { $0.toInt()! }
}


let a: Int = readLn()
let b: Int = readLn()

println("\(a + b)")
