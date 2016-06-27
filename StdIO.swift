//
//  StdIO.swift
//  HackerRank
//

import Foundation

// MARK: Standard Input

/// Reads a line from standard input
///:returns: string form stdin
public func getLine() -> String {
    var buf = String()
    var c = getchar()
    // 10 is ascii code for newline
    // TODO: add |- && count(buf) < Int.max -| when 1.2 is supported
     while c != EOF && c != 10 {
        buf.append(UnicodeScalar(UInt32(c)))
        c = getchar()
    }
    return buf
}

/// Read line from standard input
///:returns: string
public func readLn() -> String {
    return getLine()
}

/// Read line from standard input and convert to integer
///:returns: integer value
public func readLn() -> Int {
    return Int(getLine())!
}

/// Read line and convert to array of strings (words)
///:returns: array of strings
public func readLn() -> [String] {
    return getLine().componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
}

/// Read line and convert to array of integers
///:returns: array of integers
public func readLn() -> [Int] {
    let words: [String] = readLn()
    return words.map { Int($0)! }
}
