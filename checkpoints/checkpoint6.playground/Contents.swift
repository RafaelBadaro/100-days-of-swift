struct Car {
     let model: String
     let numberOfSeats: Int
     static let gears = [0,1,2,3,4,5,6,7,8,9,10]
     private(set) var currentGear = 0
        
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func switchGear(to newGear: Int){
        if Car.gears.contains(newGear) {
            currentGear = newGear
            print("New gear engaged: \(currentGear)")
        } else {
            print("Invalid gear!")
        }
    }
}

var car = Car(model: "Ford F150", numberOfSeats: 5)

print(car.currentGear)
car.switchGear(to: 5)

car.switchGear(to: 11)

car.switchGear(to: 2)
