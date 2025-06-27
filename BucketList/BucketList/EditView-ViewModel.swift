//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Rafael Badaró on 26/06/25.
//

import Foundation

extension EditView {
    @Observable
    class ViewModel {
        var location: Location
        
        var newName: String
        var newDescription: String
        
        var loadingState: LoadingState = .loading
        var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            self.newName = location.name
            self.newDescription = location.description
        }
        
    }
    
}
