//
//  main.swift
//  5
//
//  Created by Brian Kendig on 12/5/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func main() {
    let seats = getInput().split(separator: "\n")
        .map({ String($0)
            .replacingOccurrences(of: "F", with: "0")
            .replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "L", with: "0")
            .replacingOccurrences(of: "R", with: "1")
        })
        .map({ Int($0, radix: 2) ?? 0 })
        .sorted()

    print(seats.last ?? 0)

    let base = seats.first ?? 0
    for (index, seat) in seats.enumerated() {
        if seat != base + index {
            print(seat - 1)  // the missing seat is right before the one where we notice a skip
            break
        }
    }
}

main()
