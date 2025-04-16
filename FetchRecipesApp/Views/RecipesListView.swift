//
//  RecipesListView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import SwiftUI
import SwiftData

struct NewItem: Identifiable {
    let id = UUID()
    let name: String
}

struct RecipesListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    let recipes = Bundle.main.path(forResource: "recipies", ofType: "json")
    
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
                    if recipe.name != nil {
                        Section(header: Text("\(recipe.cuisine ?? "")")) {
                            NavigationLink(destination: RecipesDetailView(recipe: recipe)) {
                                RecipeCellView(name: recipe.name ?? "", image: recipe.photo_url_small ?? "")
                                    .padding(0)
                            }
                        }
                    }
                }
                .background(.yellow.opacity(0.5))
                .scrollContentBackground(.hidden)
                .listRowSpacing(8.0)
            }
            .padding(0)
        }
    }
}

//@ViewBuilder
//func HeaderView() -> some View {
//    HStack {
//        Image("FoodIcon")
//            .resizable()
//            .frame(width: 48, height: 48)
//            .clipShape(.rect(cornerRadius: 25))
//
//        Text("FoodieApp")
//            .font(.largeTitle)
//            .fontWeight(.light)
//            .multilineTextAlignment(.center)
//
//        Spacer()
//
//        Button(action: {
//            showDebugView.toggle()
//        }) {
//            Image(systemName: "gearshape.fill")
//                .resizable()
//                .frame(width: 32, height: 32)
//                .padding(.trailing)
//        }
//
//    }
//    .padding(8)
//    //.background(.yellow)
//}

#Preview {
    RecipesListView()
}
