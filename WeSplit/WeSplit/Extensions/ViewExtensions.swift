//
//  ViewExtensions.swift
//  WeSplit
//
//  Created by Rafael Badaró on 16/10/24.
//

import Foundation
import SwiftUI

// This is suggestion by ChatGPT
extension View {
    func cardStyle(cornerRadius: CGFloat, borderColor: Color, borderWidth: CGFloat) -> some View {
        self
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .shadow(radius: 10)
    }
}
