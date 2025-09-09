//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 08/09/25.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                resortDecorativeImageView
                detailViews
                descriptionAndFacilityViews
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    favorites.contains(resort) ? favorites.remove(resort) : favorites.add(resort)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information",
               isPresented: $showingFacility,
               presenting: selectedFacility) { _ in
            // Não importa o que a ação do alert faz
        } message: { facility in
            Text(facility.description)
        }
    }
}

private extension ResortView {
    private var resortDecorativeImageView: some View {
        Image(decorative: resort.id)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottomTrailing) {
                Text("Photo by \(resort.imageCredit)")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.4))
                
            }
    }
    
    private var detailViews: some View {
        HStack {
            if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                VStack(spacing: 10) { SkiDetailsView(resort: resort) }
            } else {
                ResortDetailsView(resort: resort)
                SkiDetailsView(resort: resort)
            }
        }
        .padding(.vertical)
        .background(.primary.opacity(0.1))
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
    
    private var descriptionAndFacilityViews: some View {
        Group {
            Text(resort.description)
                .padding(.vertical)
            
            Text("Facilities")
                .font(.headline)
            facilitiesView
        }
        .padding(.horizontal)
    }
    
    private var facilitiesView: some View {
        HStack {
            ForEach(resort.facilityTypes) { facility in
                Button {
                    selectedFacility = facility
                    showingFacility = true
                } label: {
                    facility.icon
                        .font(.title)
                }
            }
        }
        .padding(.vertical)
    }
    
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
