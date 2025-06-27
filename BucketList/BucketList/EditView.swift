//
//  EditView.swift
//  BucketList
//
//  Created by Rafael Badaró on 15/06/25.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @State private var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        self.onSave = onSave
        
        _viewModel = State(wrappedValue:
                            ViewModel(location: location))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                PlaceDetailsSection(name: $viewModel.newName, description: $viewModel.newDescription)
                NearbyPagesSection(loadingState: viewModel.loadingState, pages: viewModel.pages)
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID() // Usado em conjunto com o "var id: UUID" da struct "Location"
                    newLocation.name = viewModel.newName
                    newLocation.description = viewModel.newDescription
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(viewModel.location.latitude)%7C\(viewModel.location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            viewModel.pages = items.query.pages.values.sorted()
            viewModel.loadingState = .loaded
        } catch {
            viewModel.loadingState = .failed
        }
    }
}

struct PlaceDetailsSection: View {
    @Binding var name: String
    @Binding var description: String

    var body: some View {
        Section {
            TextField("Place name", text: $name)
            TextField("Description", text: $description)
        }
    }
}


struct NearbyPagesSection: View {
    let loadingState: LoadingState
    let pages: [Page]

    var body: some View {
        Section("Nearby...") {
            switch loadingState {
            case .loading:
                Text("Loading...")
            case .loaded:
                PagesListView(pages: pages)
            case .failed:
                Text("Please try again later.")
            }
        }
    }
}

struct PagesListView: View {
    let pages: [Page]

    var body: some View {
        ForEach(pages, id: \.pageid) { page in
            PageRow(page: page)
        }
    }
}

struct PageRow: View {
    let page: Page

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(page.title)
                .font(.headline)
            Text(": ")
            Text(page.description)
                .italic()
        }
    }
}



#Preview {
    EditView(location: .example) { _ in }
}
