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
    while c != EOF && c != 10 && countElements(buf) < Int.max {
        buf.append(UnicodeScalar(UInt32(CChar(c))))
        c = getchar()
    }
    return buf
}

/// Read line from standard input and convert to integer
///:returns: integer value
public func readLn() -> Int {
    return getLine().toInt()!
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
    return words.map { $0.toInt()! }
}
