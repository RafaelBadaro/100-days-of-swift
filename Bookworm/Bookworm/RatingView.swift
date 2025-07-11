//
//  RatingView.swift
//  Bookworm
//
//  Created by Rafael Badaró on 05/05/25.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating: Int = 5
    
    var offImage: Image?
    var onImage = Image.init(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }

            }
        }
        //Desabilita o toque da row inteira na AddBookView, quando usamos o Form + Section o SwiftUI entende que a fileira inteira é clicavel
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1}
            @unknown default:
                break
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
