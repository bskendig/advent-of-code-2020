//
//  main.swift
//  4
//
//  Created by Brian Kendig on 12/4/20.
//

import Foundation

func getInput() -> String {
    let path = Bundle.main.path(forResource: "input", ofType: "txt")
    return try! String(contentsOfFile: path!)
}

func isValid(passportData: [String], extendedValidation: Bool = false) -> Bool {
    var fields: [String: String] = [:]
    for line in passportData {
        let fieldRawData = line.split(separator: " ")
        for fieldRawData in fieldRawData {
            let data = fieldRawData.split(separator: ":")
            fields[String(data[0])] = String(data[1])
        }
    }
    let fieldsRequired: Set<String> = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    if !extendedValidation {
        return fieldsRequired.isSubset(of: Set(fields.keys))
    }

    guard let byr = Int(fields["byr"] ?? ""), byr >= 1920, byr <= 2002,
          let iyr = Int(fields["iyr"] ?? ""), iyr >= 2010, iyr <= 2020,
          let eyr = Int(fields["eyr"] ?? ""), eyr >= 2020, eyr <= 2030 else {
        return false
    }

    guard let hgt = fields["hgt"] else {
        return false
    }
    if hgt.suffix(2) == "cm", let number = Int(hgt.dropLast(2)) {
        if number < 150 || number > 193 {
            return false
        }
    } else if hgt.suffix(2) == "in", let number = Int(hgt.dropLast(2)) {
        if number < 59 || number > 76 {
            return false
        }
    } else {
        return false
    }

    guard let hcl = fields["hcl"], hcl.range(of: "^#[a-f0-9]{6}$", options: .regularExpression, range: nil, locale: nil) != nil else {
        return false
    }

    guard let ecl = fields["ecl"], ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ecl) else {
        return false
    }

    guard let pid = fields["pid"], pid.range(of: "^[0-9]{9}$", options: .regularExpression, range: nil, locale: nil) != nil else {
        return false
    }

    // debugging - show valid passports
//    fields.removeValue(forKey: "cid")
//    print(fields.sorted(by: { $0.key < $1.key }).map({ "\($0.key):\($0.value)" }))

    return true
}

func main() {
    var validPassportCount1 = 0
    var validPassportCount2 = 0
    var passportData: [String] = []
    for line in getInput().split(separator: "\n", omittingEmptySubsequences: false).map({ String($0) }) {
        if !line.isEmpty {
            passportData.append(line)
        } else {
            if isValid(passportData: passportData) {
                validPassportCount1 += 1
            }
            if isValid(passportData: passportData, extendedValidation: true) {
                validPassportCount2 += 1
            }
            passportData = []  // move on to the next one
        }
    }

    // get the last one
    if isValid(passportData: passportData) {
        validPassportCount1 += 1
    }
    if isValid(passportData: passportData, extendedValidation: true) {
        validPassportCount2 += 1
    }

    print(validPassportCount1)
    print(validPassportCount2)
}

main()
