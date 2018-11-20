#!/usr/bin/swift

import Foundation

//@discardableResult
//func shell() -> String {
//    let task = Process()
//    task.launchPath = "/usr/bin/env"
//    task.arguments = ["git", "branch"]
//    task.launch()
//    task.waitUntilExit()
//}

//@discardableResult
//func shell(_ args: String...) -> Int32 {
//    let task = Process()
//    task.launchPath = "/usr/bin/env"
//    task.arguments = args
//    task.launch()
//    task.waitUntilExit()
//    return task.terminationStatus
//}

@discardableResult
func shell(_ arguments: [String]) -> String?
{
    let path = "/usr/bin/env"
    let task = Process()
    task.launchPath = path
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)

    return output
}



print("Enter path: ")
let path = readLine() ?? ""

while true {

    let branches = shell(["git", "branch"]) ?? ""
    let branchArray = branches.components(separatedBy:"\n")
    for (index, branchName) in branchArray.enumerated() {
        print("\(index). \(branchName)")
    }

    let numbers = readLine() ?? ""

    if numbers.contains("q") || numbers.contains("n") {
        break
    }

    let separatedNumbers = numbers.components(separatedBy: ",")

    print("Delete these branches?")

    var branchNames = [String]()
    for line in separatedNumbers {
        if line.contains("-") {
            let parts = line.components(separatedBy: "-")
            let first = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let second = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
            let firstInt = Int(first) ?? 0
            let secondInt = Int(second) ?? 0
            for i in firstInt...secondInt {
                branchNames.append(branchArray[i])
            }
        }
        else {
            let index = Int(line) ?? 0
            branchNames.append(branchArray[index])
        }
    }

    for name in branchNames {
        print("\(name)")
    }

    let confirm = readLine() ?? ""

    if confirm == "y" || confirm == "Y" {
        for branch in branchNames {
            let trimmed = branch.trimmingCharacters(in: .whitespacesAndNewlines)
                print("deleting \(trimmed)")
                shell(["git", "branch", "-D", trimmed])
        }

        print("Done")
    }
    else {
        print("Aborted")
    }

    let prompt = readLine() ?? ""
    if prompt.contains("q") || prompt.contains("n") {
        break
    }
}
