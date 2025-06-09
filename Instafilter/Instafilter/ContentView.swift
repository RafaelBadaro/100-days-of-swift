//
//  ContentView.swift
//  Instafilter
//
//  Created by Rafael Badaró on 29/05/25.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct ContentView: View {
    @State private var processedImage: Image?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var filterAmount = 0.5
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture",
                                               systemImage: "photo.badge.plus",
                                               description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                Text("Current filter: \(currentFilter.name)")
                    .font(.caption)
                
                VStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                    
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius, applyProcessing)
                    
                    Text("Scale")
                    Slider(value: $filterScale)
                        .onChange(of: filterScale, applyProcessing)
                    
                    Text("Amount")
                    Slider(value: $filterAmount)
                        .onChange(of: filterAmount, applyProcessing)
                }
                .disabled(processedImage == nil)
                
                HStack {
                    Button("Change filter", action: changeFilter)
                        .disabled(processedImage == nil)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage,
                                  preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
                
                Button("Vibrance") { setFilter(CIFilter.vibrance()) }
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Dither") { setFilter(CIFilter.dither()) }
                
            }
        }
        
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            self.applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputAmountKey) {
            currentFilter.setValue(filterAmount, forKey: kCIInputAmountKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
       
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            //requestReview()
        }
    }
}

#Preview {
    ContentView()
}
