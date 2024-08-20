for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5){
        print("\(i) - FizzBuzz")
        continue
    }
    
    if i.isMultiple(of: 3){
        print("\(i) - Fizz")
        continue
    }
    
    if i.isMultiple(of: 5){
        print("\(i) - Buzz")
        continue
    }
    
    print(i)
}


/** Saving this here cause I find it pretty :)
 func fizzbuzz(number: Int) -> String {
     switch (number % 3 == 0, number % 5 == 0) {
     case (true, false):
         return "Fizz"
     case (false, true):
         return "Buzz"
     case (true, true):
         return "FizzBuzz"
     case (false, false):
         return String(number)
     }
 }

 print(fizzbuzz(number: 15))
 
 
 */
