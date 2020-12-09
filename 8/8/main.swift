//
//  main.swift
//  8
//
//  Created by Brian Kendig on 12/8/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

var prog: [String] = []
var pc = 0  // program counter
var acc = 0  // accumulator
var alreadyVisited: Set<Int> = []

func fetch() -> String? {
    guard !alreadyVisited.contains(pc) else {
        return nil
    }
    let instruction = prog[pc]
    alreadyVisited.insert(pc)
    pc += 1
    return instruction
}

func main() {
    prog = getInput().split(separator: "\n").map { String($0) }
    while let line = fetch() {
        let lineArray = line.split(separator: " ")
        let op = String(lineArray[0])
        let val = Int(lineArray[1])!
        switch op {
        case "acc":
            acc += val
        case "jmp":
            pc = pc - 1 + val
        case "nop":
            if pc + val == prog.count {
                break
            }
            break
        default:
            break
        }
    }
    print(acc)
}

main()
