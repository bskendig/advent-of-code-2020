//
//  main.swift
//  6
//
//  Created by Brian Kendig on 12/5/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func parse(_ group: [String]) -> (Int, Int) {
    var yes: [Character: Int] = [:]
    for person in group {
        for q in Array(person) {
            if let qTotal = yes[q] {
                yes[q] = qTotal + 1
            } else {
                yes[q] = 1
            }
        }
    }
    return (yes.keys.count, yes.filter({ $0.value == group.count }).keys.count)
}

func main() {
    let input = getInput().split(separator: "\n", omittingEmptySubsequences: false).map({ String($0) })
    var group: [String] = []
    var total1 = 0
    var total2 = 0
    for line in input {
        if line.isEmpty {
            let sum = parse(group)
            total1 += sum.0
            total2 += sum.1
            group = []
        } else {
            group.append(line)
        }
    }
    print(total1)
    print(total2)
}

main()
