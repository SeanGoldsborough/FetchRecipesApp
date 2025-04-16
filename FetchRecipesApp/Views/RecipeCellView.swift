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
                AsyncImage(url: URL(string: image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                          .scaleEffect(2.0, anchor: .center)
                }
                .frame(width: 128, height: 128)
                .cornerRadius(25)
                .padding(1.5)
                //.background(.black)
                .cornerRadius(25)
                .shadow(radius: 10)
                                
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
