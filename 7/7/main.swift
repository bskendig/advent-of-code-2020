//
//  main.swift
//  7
//
//  Created by Brian Kendig on 12/6/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func findContainers(for bag: String, in foundInside: [String: [String]]) -> [String] {
    guard let containers = foundInside[bag] else {
        return []
    }
    var everythingFoundInside = containers
    for container in containers {
        print(container)
        everythingFoundInside += findContainers(for: container, in: foundInside)
    }
    return everythingFoundInside
}

func countMustContain(for bag: String, in mustContain: [String: [(number: Int, bag: String)]]) -> Int {
    guard let contents = mustContain[bag] else {
        return 0
    }
    var total = 0
    for contained in contents {
        total += contained.number + countMustContain(for: contained.bag, in: mustContain) * contained.number
    }
    return total
}

func main() {
    let rules = getInput().split(separator: "\n").map({ String($0) })
    var foundInside: [String: [String]] = [:]
    var mustContain: [String: [(number: Int, bag: String)]] = [:]
    for rule in rules {
        let regex = try! NSRegularExpression(pattern: "^(.+) bags contain (.+)$", options: [])
        let matches = regex.matches(in: rule, options: [], range: NSMakeRange(0, rule.count))
        let container = (rule as NSString).substring(with: matches[0].range(at: 1))
        let containedString = (rule as NSString).substring(with: matches[0].range(at: 2))
        if containedString == "no other bags." {
            continue
        }
        let containedArray = containedString.split(separator: ",")
        mustContain[container] = []
        for contained in containedArray {
            let regex = try! NSRegularExpression(pattern: "^ ?(\\d+) (.+) bag[s]?.?$", options: [])
            let s = String(contained)
            let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.count))
            let number = (s as NSString).substring(with: matches[0].range(at: 1))
            let thisBag = (s as NSString).substring(with: matches[0].range(at: 2))
            if foundInside[thisBag] == nil {
                foundInside[thisBag] = []
            }
            foundInside[thisBag]?.append(container)
            mustContain[container]?.append((number: Int(number)!, bag: thisBag))
        }
    }

    print(Set(findContainers(for: "shiny gold", in: foundInside)).count)
    print(countMustContain(for: "shiny gold", in: mustContain))}

main()
