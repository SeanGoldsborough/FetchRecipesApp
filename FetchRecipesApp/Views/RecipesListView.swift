//
//  RecipesListView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import SwiftUI
import SwiftData

struct RecipesListView: View {
    
    @Environment(\.modelContext) private var modelContext        
    @ObservedObject var networkManager = NetworkManager.shared
    @ObservedObject var recipesListViewModel = RecipesListViewModel()
    
    @State private var showDebugView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationStack {
                HStack {
                    Image("FoodIcon")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(.rect(cornerRadius: 25))
                    
                    Text("FoodieApp")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        showDebugView.toggle()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.trailing)
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding(8)
                .sheet(isPresented: $showDebugView) {
                    DebugView(viewModel: recipesListViewModel)
                }
                
                List(recipesListViewModel.recipes) { recipe in
                    
                    // MARK: check to see if we have name, if not, we don't display recipe cell.
                    if recipe.name != nil {
                        NavigationLink(destination: RecipesDetailView(recipe: recipe)) {
                            RecipeCellView(name: recipe.name ?? "",
                                           image: recipe.photo_url_small ?? "",
                                           cuisine: ("\(recipe.cuisine?.cuisineFlag(cuisineName: recipe.cuisine) ?? "") " + "\(recipe.cuisine ?? "")"))
                            .padding(0)
                        }
                    }
                }
                .background(.gray.opacity(0.2))
                .scrollContentBackground(.hidden)
                .listRowSpacing(8.0)
                .refreshable {
                    await recipesListViewModel.reload()
                }
                .alert("Error: " + CustomError.invalidResponse.rawValue, isPresented: $recipesListViewModel.showError) {
                    Button("Retry", role: .cancel) {
                        recipesListViewModel.loadData(url: NetworkManager.Constants.URL.APIHappyPath)
                    }
                }
                
            }
            .padding(0)
        }
    }
}

#Preview {
    RecipesListView()
}
