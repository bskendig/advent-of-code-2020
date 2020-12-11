//
//  main.swift
//  11
//
//  Created by Brian Kendig on 12/11/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

var layout: [[Character]] = []

func seat(_ x: Int, _ y: Int) -> Character? {
    guard 0 <= y, y < layout.count, 0 <= x, x < layout[0].count else {
        return nil
    }
    return layout[y][x]
}

func neighbors(_ x: Int, _ y: Int, keepGoing: Bool = false) -> Int {
    let directions: [(dx: Int, dy: Int)] = [(-1, -1), (0, -1), (1, -1),
                                            (-1,  0),          (1,  0),
                                            (-1,  1), (0,  1), (1,  1)]
    var adjacentSeats: [Character] = []
    var visibleSeat: Character?
    for direction in directions {
        var newX = x
        var newY = y
        repeat {
            newX += direction.dx
            newY += direction.dy
            visibleSeat = seat(newX, newY)
        } while visibleSeat == "." && keepGoing
        if let visibleSeat = visibleSeat {
            adjacentSeats.append(visibleSeat)
        }
    }
    return adjacentSeats.filter({ $0 == "#" }).count
}

func show(layout: [[Character]]) {
    print(layout.map({ String($0) }).joined(separator: "\n"))
}

func next(keepGoing: Bool) -> [[Character]] {
    let occupyMinimum = keepGoing ? 5 : 4
    var nextLayout: [[Character]] = []
    for (y, row) in layout.enumerated() {
        var nextRow: [Character] = []
        for (x, seat) in row.enumerated() {
            var nextSeat: Character = seat
            if seat == "L" && neighbors(x, y, keepGoing: keepGoing) == 0 {
                nextSeat = "#"
            } else if seat == "#" && neighbors(x, y, keepGoing: keepGoing) >= occupyMinimum {
                nextSeat = "L"
            }
            nextRow.append(nextSeat)
        }
        nextLayout.append(nextRow)
    }
    return nextLayout
}

func countOccupiedSeats(keepGoing: Bool = false) -> Int {
    var nextLayout = next(keepGoing: keepGoing)
    repeat {
//        show(layout: layout)
        layout = nextLayout
        nextLayout = next(keepGoing: keepGoing)
    } while layout != nextLayout
    return layout.reduce(0, { $0 + $1.filter({ $0 == "#" }).count })
}


func main() {
    let startingLayout = getInput().split(separator: "\n").map { Array(String($0)) }

    layout = startingLayout
    print(countOccupiedSeats())

    layout = startingLayout
    print(countOccupiedSeats(keepGoing: true))
}

main()
