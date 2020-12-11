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

func seat(_ x: Int, _ y: Int) -> Character {
    guard 0 <= y, y < layout.count, 0 <= x, x < layout[0].count else {
        return "."
    }
    return layout[y][x]
}

func neighbors(_ x: Int, _ y: Int) -> Int {
    let adjacentSeats = [seat(x-1, y-1), seat(x, y-1), seat(x+1, y-1),
                         seat(x-1, y), seat(x+1, y),
                         seat(x-1, y+1), seat(x, y+1), seat(x+1, y+1)]
    return adjacentSeats.filter({ $0 == "#" }).count
}

func countOccupiedSeats() -> Int {
    return layout.reduce(0, { $0 + $1.filter({ $0 == "#" }).count })
}

func show(layout: [[Character]]) {
    print(layout.map({ String($0) }).joined(separator: "\n"))
}

func next() -> [[Character]] {
    var nextLayout: [[Character]] = []
    for (y, row) in layout.enumerated() {
        var nextRow: [Character] = []
        for (x, seat) in row.enumerated() {
            var nextSeat: Character = seat
            if seat == "L" && neighbors(x, y) == 0 {
                nextSeat = "#"
            } else if seat == "#" && neighbors(x, y) >= 4 {
                nextSeat = "L"
            }
            nextRow.append(nextSeat)
        }
        nextLayout.append(nextRow)
    }
    return nextLayout
}

func main() {
    layout = getInput().split(separator: "\n").map { Array(String($0)) }
    var nextLayout = next()
    repeat {
//        show(layout: layout)
        layout = nextLayout
        nextLayout = next()
    } while layout != nextLayout
    print(countOccupiedSeats())
}

main()
