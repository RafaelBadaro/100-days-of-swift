class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    
    init(){
        super.init(legs: 4)
    }
    
    func speak(){
        print("Dog bark!")
    }
}

class Corgi: Dog {
    override func speak(){
        print("Corgi bark!")
    }
}

class Poodle: Dog {
    override func speak(){
        print("Poodle bark!")
    }
}

class Cat: Animal {
    
    let isTame: Bool
    
    init(isTame: Bool){
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak(){
        print("Cat purr!")
    }
}

class Persian: Cat {
    override func speak(){
        print("Persian purr!")
    }
}

class Lion: Cat {
    override func speak(){
        print("Lion purr!")
    }
}


var animal = Poodle()
print(animal.legs)
animal.speak()
