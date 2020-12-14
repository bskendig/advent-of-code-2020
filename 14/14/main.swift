//
//  main.swift
//  14
//
//  Created by Brian Kendig on 12/13/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func masked(value: Int, mask: [Character?]) -> Int {
    var binary = String(value, radix: 2)
    binary = String(repeating: "0", count: mask.count - binary.count) + binary
    var masked: [Character] = []
    for (index, char) in binary.enumerated() {
        masked.append((mask[index] != nil) ? mask[index]! : char)
    }
    return Int(String(masked), radix: 2)!
}

func masked(address: Int, mask: [Character?]) -> [Int] {
    var binary = String(address, radix: 2)
    binary = String(repeating: "0", count: mask.count - binary.count) + binary
    var masked: [Character] = []
    var result: [Int] = []
    for (index, char) in binary.enumerated() {
        masked.append((mask[index] != nil) ? (Int(binary[index])! || Int(mask[index]!)!) : "X")
    }
    return Int(String(masked), radix: 2)!
}

func main() {
    let input = getInput().split(separator: "\n").map { Array(String($0)) }
    var mem: [Int: Int] = [:]
    var mask: [Character?] = []
    for line in input {
        if String(line.prefix(7)) == "mask = " {
            mask = line.suffix(from: 7).map { ($0 == "X") ? nil : $0 }
        } else {
            let regex = try! NSRegularExpression(pattern: "^mem\\[(\\d+)\\] = (\\d+)$", options: [])
            let matches = regex.matches(in: String(line), options: [], range: NSMakeRange(0, line.count))
            let address = (String(line) as NSString).substring(with: matches[0].range(at: 1))
            let value = (String(line) as NSString).substring(with: matches[0].range(at: 2))
            mem[Int(address)!] = masked(value: Int(value)!, mask: mask)
        }
    }
    print(mem.values.reduce(0, +))
}

main()
