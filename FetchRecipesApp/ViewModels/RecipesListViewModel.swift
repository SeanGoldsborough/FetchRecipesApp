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
    @Published var showError = false
    @Published var flag = ""
    
    private var store: [AnyCancellable] = []
    
    public func loadData(url: String) {
        Task(priority: .high){
            do {
                let recipes = try await self.networkManager.getData(with: url)
                performUpdatesOnMain {
                    if recipes.isEmpty {
                        self.showError = true
                        self.recipes = recipes.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" }
                    } else {
                        self.showError = false
                        self.recipes = recipes.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" }
                    }
                }
            } catch {
                showError = true
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
}

extension RecipesListViewModel {
    
    public func loadJSON(fileName: String) -> [Recipe] {
        self.recipes = networkManager.loadJson(fileName: fileName)?.sorted { $0.cuisine ?? "" < $1.cuisine ?? "" } ?? []
        return recipes
    }
}
