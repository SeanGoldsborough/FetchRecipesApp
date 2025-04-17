//
//  RecipesCardView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import SwiftUI

struct RecipesCardView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var recipe: Recipe
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                Text("         ")
                    .foregroundColor(.black)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 0) {
                    HStack {
                        Text(recipe.name ?? "")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black.opacity(0.75))
                            .font(.title2)
                            .bold()
                            .fontDesign(.serif)
                            .padding(4)
                    }
                    .frame(width: geometry.size.width, height: (geometry.size.height * 0.1))
                    .background(.white.opacity(0.33))
                    .border(.white, width: 1)
                    
                    CachedImage(url: recipe.photo_url_large ?? "") { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100)
                            
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                            
                        case .failure(_):
                            Image(systemName: "xmark")
                                .symbolVariant(.circle.fill)
                                .foregroundStyle(.red)
                                .frame(width: 100, height: 100)
                                .background(.black, in: RoundedRectangle(cornerRadius: 8,
                                                                         style: .continuous))
                        @unknown default:
                            EmptyView()
                        }
                        
                    }
                }.border(.white, width: 1)
                
                ZStack {
                    Rectangle().fill(.black.opacity(0.2))
                        .frame(width: geometry.size.width, height: 64)
                        .border(.white, width: 1)
                    HStack {
                        Button("Read Recipe") {
                            if let url = URL(string: recipe.source_url ?? "") {
                                openURL(url)
                            }
                        }
                        .frame(width: 164, height: 48)
                        .background(.white)
                        .cornerRadius(8)
                        .font(.title3)
                        .fontDesign(.serif)
                        
                        if recipe.youtube_url != nil {
                            Button(action: {
                                if let url = URL(string: recipe.youtube_url ?? "") {
                                    openURL(url)
                                }
                            }) {
                                HStack(spacing: 0) {
                                    Image("youtubeicon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .padding(0)
                                        .frame(width: 100, height: 48)
                                }
                                .frame(width: 164, height: 48)
                                .background(.white)
                                .cornerRadius(8)
                                .font(.headline)
                                .fontDesign(.serif)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Spacer()
                Spacer()
            }
            .padding(.trailing, 32.0)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
    }
}


