//
//  main.swift
//  2
//
//  Created by Brian Kendig on 12/2/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func main() {
    let entries = getInput().split(separator: "\n")
    var validPasswordCount1 = 0
    var validPasswordCount2 = 0
    for entry in entries {

        let regex = try! NSRegularExpression(pattern: "^(\\d+)-(\\d+) (.): (.+)$", options: [])
        let s = String(entry)
        let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.count))
        var t: [String] = []
        for i in 0...3 {
            t.append((s as NSString).substring(with: matches[0].range(at: i + 1)))
        }
        let min = Int(t[0])!
        let max = Int(t[1])!
        let char = Character(t[2])
        let password = Array(t[3])

        let count = password.filter({ $0 == char }).count
        if min <= count && count <= max {
            validPasswordCount1 += 1
        }

        if (password[min - 1] == char) != (password[max - 1] == char) {
            validPasswordCount2 += 1
        }
    }
    print(validPasswordCount1)
    print(validPasswordCount2)
}

main()
