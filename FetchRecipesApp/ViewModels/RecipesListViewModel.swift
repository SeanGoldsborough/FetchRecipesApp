//
//  RecipesListViewModel.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import Foundation
import Combine

class RecipesListViewModel: ObservableObject {
    
    public var networkManager = NetworkManager.shared
    
    @Published var recipes = [Recipe]()
    @Published var enableDebugHappyPath = true
    @Published var enableDebugMisformed = false
    @Published var enableDebugEmpty = false
    
    private var store: [AnyCancellable] = []
    
    public func loadData(url: String) {
        print(s is \(url)")
        Task(priority: .high){
            do {
                let recipes = try await self.networkManager.getData(with: url)
                performUpdatesOnMain {
                    self.recipes = recipes.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" }
                    print("Fetched \(recipes.count) recipes.")
                }
            } catch {
                print("Fetching images failed with error \(error)")
            }
        }
    }
    
    init() {
        
        loadData(url: NetworkManager.Constants.URL.APIHappyPath)

        $enableDebugHappyPath
            .sink(receiveValue: {
                guard $0 else { return }
                self.enableDebugMisformed = false
                self.enableDebugEmpty = false
                self.loadData(url: NetworkManager.Constants.URL.APIHappyPath)
            })
            .store(in: &store)
        
        $enableDebugMisformed
            .sink(receiveValue: {
                guard $0 else { return }
                self.enableDebugHappyPath = false
                self.enableDebugEmpty = false
                self.loadData(url: NetworkManager.Constants.URL.APIMalformedPath)
            })
            .store(in: &store)
        
        $enableDebugEmpty
            .sink(receiveValue: {
                guard $0 else { return }
                self.enableDebugHappyPath = false
                self.enableDebugMisformed = false
                self.loadData(url: NetworkManager.Constants.URL.APIEmptyPath)
            })
            .store(in: &store)
        
    }
    
//    public func loadJSON() -> [Recipe] {
//        self.recipes = networkManager.loadJson()?.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" } ?? []
//        return recipes
//    }
//    
//    public func loadJsonMisformed() -> [Recipe] {
//        self.recipes = networkManager.loadJsonMisformed()?.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" } ?? []
//        for recipe in recipes {
//            print(recipe)
//        }
//        return recipes
//    }
//    
//    public func loadJsonEmpty() -> [Recipe] {
//        self.recipes = networkManager.loadJsonEmpty()?.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" } ?? []
//        return recipes
//    }
    
}
