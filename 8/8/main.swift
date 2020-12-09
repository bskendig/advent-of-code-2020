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

func run(flipNth: Int? = nil) -> Bool{
    pc = 0
    acc = 0
    alreadyVisited = []
    var nthOp = 0
    while let line = fetch() {
        let lineArray = line.split(separator: " ")
        var op = String(lineArray[0])
        if nthOp == flipNth {
            if op == "jmp" {
                op = "nop"
            } else if op == "nop" {
                op = "jmp"
            }
        }
        let val = Int(lineArray[1])!
        switch op {
        case "acc":
            acc += val
        case "jmp":
            pc = pc - 1 + val
            nthOp += 1
        case "nop":
            if pc + val == prog.count {
                break
            }
            nthOp += 1
        default:
            break
        }
        if pc == prog.count {
            // successfully exited past the end of the program
            return true
        }
    }
    return false
}

func main() {
    prog = getInput().split(separator: "\n").map { String($0) }
    run()
    print(acc)

    var flipNth = 0
    while run(flipNth: flipNth) == false {
        flipNth += 1
    }
    print(acc)
}

main()
