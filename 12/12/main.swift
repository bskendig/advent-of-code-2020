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
    // part 1
    let instructions = getInput().split(separator: "\n").map { Array(String($0)) }
    let directions = ["E", "S", "W", "N"]
    var x = 0
    var y = 0
    var direction = "E"
    for instruction in instructions {
        var action = String(instruction.prefix(1))
        var value = Int(String(instruction.suffix(from: 1)))!

        if action == "R" || action == "L" {
            value /= 90
            let directionIndex = directions.firstIndex(of: direction)! + (value * (action == "R" ? 1 : -1)) + 4
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

    // part 2
    x = 0
    y = 0
    var wpX = 10
    var wpY = -1
    for instruction in instructions {
        switch String(instruction) {
        case "R90", "L270":
            let tempX = -wpY
            wpY = wpX
            wpX = tempX
        case "L90", "R270":
            let tempX = wpY
            wpY = -wpX
            wpX = tempX
        case "R180", "L180":
            wpX = -wpX
            wpY = -wpY
        default:
            let action = String(instruction.prefix(1))
            let value = Int(String(instruction.suffix(from: 1)))!
            switch action {
            case "F":
                x += wpX * value
                y += wpY * value
            case "N":
                wpY -= value
            case "S":
                wpY += value
            case "E":
                wpX += value
            case "W":
                wpX -= value
            default:
                break
            }
        }
    }
    print("\(abs(x) + abs(y))")
}

main()
