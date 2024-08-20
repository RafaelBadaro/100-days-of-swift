import SwiftUI

struct ContentView: View {
    
    // var colors: Set<String> = Set(["Red", "Blue", "Red", "Green", "Yellow"])
    
    var colors: [String] = ["Red", "Blue", "Red", "Green", "Yellow"]
    
    @State private var numberOfItems: Int = 0
    @State private var numberOfUniqueItems: Int = 0
    
    var body: some View {
        VStack {
            List(Array(colors), id: \.self) { color in
                Text(color)
            }
            
            VStack {
                Text("Number of items: \(numberOfItems)")
                
                Button {
                    printNumberOfItems()
                } label: {
                    Text("Get number of items")
                    
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                
                Text("Number of Unique items: \(numberOfUniqueItems)")
                
                Button {
                    printNumberOfUniqueItems()
                } label: {
                    Text("Get number of Unique items")
                    
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
            }
            .padding()
        }
    }
    
    
    func printNumberOfItems () {
        numberOfItems = colors.count
    }
    
    func printNumberOfUniqueItems() {
        // If using a Set, it can only have unique items
        //numberOfUniqueItems = colors.count
        
        // If using an array
        var uniqueArray: [String] = []
        for color in colors {
            if !uniqueArray.contains(color) {
                uniqueArray.append(color)
            }
        }
        
        numberOfUniqueItems = uniqueArray.count
    }
    
}
