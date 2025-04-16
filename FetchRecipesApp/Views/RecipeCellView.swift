//
//  RecipeCellView.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import SwiftUI

struct RecipeCellView: View {
    var name: String
    var image: String
    var body: some View {
        VStack {
            HStack {
                CachedImage(url: image) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 128, height: 128)
                            .cornerRadius(25)
                            .padding(1.5)
                            .cornerRadius(25)
                            .shadow(radius: 10)
                        
                    case .failure(let error):
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
                                
                Text(name)
                    .font(.headline)
                    .fontDesign(.serif)
                    .padding(.leading, 8)
                
                Spacer()
            }
        }
        .padding(0)
    }
}
