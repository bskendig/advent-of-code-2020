//
//  main.swift
//  9
//
//  Created by Brian Kendig on 12/9/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func validSum(number: Int, from: [Int]) -> Bool {
    for (startingIndex, i) in from.enumerated() {
        for j in Array(from[startingIndex + 1 ..< from.count]) {
            if i + j == number {
                return true
            }
        }
    }
    return false
}

func main() {
    let numbers = getInput().split(separator: "\n").map { Int($0)! }
    let preamble = 25
    for i in (preamble + 1) ..< numbers.count {
        let subset: [Int] = Array(numbers[i - preamble ... i - 1])
        let number = numbers[i]
        if !validSum(number: number, from: subset) {
            print(number)
            break
        }
    }
}

main()
