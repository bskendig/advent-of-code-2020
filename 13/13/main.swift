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
    print(busId * waitTime)

    var departures: [Int: Int] = [:]
    for (index, bus) in String(input[1]).split(separator: ",").enumerated() where bus != "x" {
        departures[index] = Int(bus)!
    }
    print(departures)

    for departure in departures {
        print("\((departure.value - (departure.key % departure.value)) % departure.value),\(departure.value)")
    }

    let departureArray = departures.sorted(by: { $0.key > $1.key })
    print(departureArray)
    let keys = departureArray.map { $0.key }
    let values = departureArray.map { $0.value }
    print(crt(keys, values))
    // now enter those values into a Chinese Remainder Theorem solver online

    var t = 539_746_751_134_000  // 0
    var done = false
    repeat {
        done = true  // wishful thinking
        t += departures[0]!
        for (index, bus) in departures {
//            print("\(index), \(bus)")
            if (t + index) % bus != 0 {
                done = false
                break
            }
        }
    } while !done
    print(t)
}

main()
