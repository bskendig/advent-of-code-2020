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

func findContainers(for bag: String, in foundInside: [String : [String]]) -> [String] {
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

func main() {
    let rules = getInput().split(separator: "\n").map({ String($0) })
    var foundInside: [String : [String]] = [:]
    for rule in rules {
        let regex = try! NSRegularExpression(pattern: "^(.+) bags contain (.+)$", options: [])
        let matches = regex.matches(in: rule, options: [], range: NSMakeRange(0, rule.count))
        let container = (rule as NSString).substring(with: matches[0].range(at: 1))
        let containedString = (rule as NSString).substring(with: matches[0].range(at: 2))
        if containedString == "no other bags." {
            continue
        }
        let containedArray = containedString.split(separator: ",")
        for contained in containedArray {
            let regex = try! NSRegularExpression(pattern: "^ ?(\\d+) (.+) bag[s]?.?$", options: [])
            let s = String(contained)
            let matches = regex.matches(in: s, options: [], range: NSMakeRange(0, s.count))
            let thisBag = (s as NSString).substring(with: matches[0].range(at: 2))
            if foundInside[thisBag] == nil {
                foundInside[thisBag] = []
            }
            foundInside[thisBag]?.append(container)
        }
    }

    print(Set(findContainers(for: "shiny gold", in: foundInside)).count)
//    print(foundInside)
}

main()
