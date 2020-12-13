//
//  main.swift
//  13
//
//  Created by Brian Kendig on 12/12/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func main() {
    let input = getInput().split(separator: "\n").map { Array(String($0)) }
    let timestamp = Int(String(input[0]))!
    let buses = String(input[1]).split(separator: ",").filter({ $0 != "x" }).map { Int($0)! }
    var waitTime = Int.max
    var busId = 0
    for bus in buses {
        let thisWaitTime = bus - (timestamp % bus)
        if thisWaitTime < waitTime {
            waitTime = thisWaitTime
            busId = bus
        }
    }
    print("\(busId), \(waitTime)")
    print(busId * waitTime)
}

main()
