//
//  main.swift
//  12
//
//  Created by Brian Kendig on 12/11/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func main() {
    let instructions = getInput().split(separator: "\n").map { Array(String($0)) }
    let directions = ["E", "S", "W", "N"]
    var x = 0
    var y = 0
    var direction = "E"
    for instruction in instructions {
        var action = String(instruction.prefix(1))
        let valueString = String(instruction.suffix(from: 1))
        var value = Int(valueString)!
//        print("\(action), \(value)")

        if action == "R" {
            value /= 90
            let directionIndex = directions.firstIndex(of: direction)! + value
            direction = directions[directionIndex % 4]
        } else if action == "L" {
            value /= 90
            let directionIndex = directions.firstIndex(of: direction)! - value + 4
            direction = directions[directionIndex % 4]
        } else if action == "F" {
            action = direction
        }

        switch action {
        case "N":
            y -= value
        case "S":
            y += value
        case "E":
            x += value
        case "W":
            x -= value
        default:
            break
        }
    }
    print("\(abs(x) + abs(y))")
}

main()
