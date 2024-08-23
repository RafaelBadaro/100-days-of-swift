var str1 = "abc"
var str2 = "bca"

func checkIfSameLetters(str1: String, str2: String) -> Bool{
    return str1.sorted() == str2.sorted()
}

print(checkIfSameLetters(str1: str1, str2: str2))


func getUser() -> (firstName: String, lastName: String, third: Bool, quatro: Int, five: Double) {
    (firstName: "Taylor", lastName: "Swift", third: true, quatro: 4, five: 5.22)
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName) \(user.third) \(user.quatro) \(user.five)")


enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch let error as PasswordError {
    print("There was an error. \(error)")
}

enum MeasureError: Error {
    case unknownItem
}
func measure(itemName: String) throws -> Double {
    switch itemName {
    case "bookcase":
        return 2.0
    case "chair":
        return 1.0
    case "child":
        return 1.3
    case "adult":
        return 1.75
    default:
        return 0.0
    }
}
