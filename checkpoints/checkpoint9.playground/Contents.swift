func getRandomIfLet(_ array: [Int]?) -> Int {
    if let unWrappedArray = array, !unWrappedArray.isEmpty {
        return unWrappedArray.randomElement()!
    }
    
    return Int.random(in: 1...100)
}

func getRandomGuard(_ array: [Int]?) -> Int {
    guard let unWrappedArray = array, !unWrappedArray.isEmpty else {
        return Int.random(in: 1...100)
    }
    return unWrappedArray.randomElement()!
}



func oneLineGetRandom(_ array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}


print(getRandomGuard(nil))
