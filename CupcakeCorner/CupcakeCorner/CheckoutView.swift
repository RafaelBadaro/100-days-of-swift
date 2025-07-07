//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Rafael Badaró on 16/04/25.
//

import SwiftUI

struct CheckoutView: View {
    
    private let urlString = "https://hws.dev/img/cupcakes@3x.jpg"
    var order: Order
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: urlString), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .accessibilityHidden(true)
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            order.saveAddressToUserDefaults()
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // handle our result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            self.setupAlertTexts(title: "Thank you!",
                                 message: "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!")
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            self.setupAlertTexts(title: "Checkout failed :(",
                                 message:
                                    "Error: \(error.localizedDescription)")
        }
        
        
    }
    
    func setupAlertTexts(title: String, message: String){
        self.alertTitle = title
        self.alertMessage = message
        self.showingAlert = true
    }
}

#Preview {
    CheckoutView(order: Order())
}
