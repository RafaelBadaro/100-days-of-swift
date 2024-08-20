import SwiftUI

struct ContentView: View {
    @State private var celcius: Double = 12
    @State private var fahrenheit: Double = 0
    
    
    var body: some View {
        VStack {
            Text("Temperature converter")
            
            HStack{
                Text("\(celcius, specifier: "%.2f")°C")
                Text("\(fahrenheit, specifier: "%.2f")°F")
            }
            
            Button("Convert"){
                convertToFahrenheit()
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func convertToFahrenheit(){
        fahrenheit = (celcius * 9)/5 + 32
    }
}
