//
//  DataManager.swift
//  day60-challenge-fetch-json
//
//  Created by Rafael Badaró on 25/05/25.
//

import Foundation

class DataManager {
    private static let JSONURL = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
    @MainActor
    func fetchUsers() async -> [User] {
        do {
            let (data, _) = try await URLSession.shared.data(from: Self.JSONURL)
            
            let decoder = JSONDecoder()
            // Necessario pra fazer o decode correto da propriedade "registered" de User
            // Ela é Date e mas vem como String do JSON
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            return decodedUsers
        } catch {
            print("Deu erro: \(error.localizedDescription)")
        }
    
        return []
    }
}
