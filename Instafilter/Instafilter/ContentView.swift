//
//  ContentView.swift
//  Instafilter
//
//  Created by Rafael Badaró on 29/05/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture",
                         selection: $pickerItems,
                         maxSelectionCount: 3,
                         matching: .images)
            
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                for item in pickerItems {
                    if let loadingImage = try? await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadingImage)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
