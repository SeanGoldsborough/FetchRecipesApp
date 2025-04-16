//
//  RecipesDetailView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import SwiftUI

struct RecipesDetailView: View {
    
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .center, content: {
            RecipesCardView(recipe: recipe)
                .padding(.horizontal)
            
        })
        .background(.yellow.opacity(0.5))
    }
}

//#Preview {
//    let recipe = FoodItem()
//    RecipesDetailView(recipe: recipe)
//}
