protocol Building {
    var rooms: Int { get set }
    var cost: Int { get set }
    var realStateAgent: String { get set }
    var type: String { get set }
    func printSalesSummary()
}

extension Building {
    func printSalesSummary(){
        print("Its a \(type) and It has \(rooms) rooms, it costs \(cost)$ and it's real state agent is \(realStateAgent)")
    }
}

struct House : Building {
    var type = "House"
    var rooms = 4
    var cost = 500_000
    var realStateAgent = "Scott"
}

struct Office: Building{
    var type = "Office"
    var rooms = 34
    var cost = 1_000_000
    var realStateAgent = "Jake"
}

var house = House()
var office = Office()

house.printSalesSummary()
office.printSalesSummary()
