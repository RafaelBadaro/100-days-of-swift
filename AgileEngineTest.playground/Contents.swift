import UIKit
import Foundation

func binaryStringToInt(_ S: String) -> Int? {
    return Int(S, radix: 2)
}

public func solution(_ S : inout String) -> Int {
    let onesCount = S.filter { $0 == "1" }.count
    let length = S.count
    return onesCount + (length - 1)
}

var input = ""
for i in 1..<400000 {
    input += "1"
}
//var input = "011100"
let op = solution(&input)
print(op)




