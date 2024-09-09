let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

func filterEvenNumbers(num: Int) -> Bool{
    !num.isMultiple(of: 2)
}

func mapToText(num: Int) -> Void {
    print("\(num) is a lucky number")
}

luckyNumbers
    .filter(filterEvenNumbers)
    .sorted()
    .map(mapToText)


// Its possible to do it in one line
print("----------")
luckyNumbers
    .filter { !$0.isMultiple(of: 2) }
    .sorted()
    .map { print("\($0) is a lucky number") }
