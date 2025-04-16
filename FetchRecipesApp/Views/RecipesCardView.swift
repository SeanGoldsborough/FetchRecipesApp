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
                // .padding(.horizontal)
                
                //                CachedImage(url: recipe.photo_url_large ?? "") { phase in
                //
                //                    switch phase {
                //                    case .empty:
                //                        ProgressView()
                //                            .frame(width: 100, height: 100)
                //
                //                    case .success(let image):
                //                        image
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fit)
                //                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                //                            .padding()
                //
                //                    case .failure(let error):
                //                        Image(systemName: "xmark")
                //                            .symbolVariant(.circle.fill)
                //                            .foregroundStyle(.red)
                //                            .frame(width: 100, height: 100)
                //                            .background(.black, in: RoundedRectangle(cornerRadius: 8,
                //                                                                     style: .continuous))
                //                    @unknown default:
                //                        EmptyView()
                //                    }
                //
                //                }
                //
                
                
                AsyncImage(url: URL(string: recipe.photo_url_large ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2.0, anchor: .center)
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                }.border(.white, width: 1)
                
                
                HStack {
                    Button("Read Recipe") {
                        if let url = URL(string: recipe.source_url ?? "") {
                            openURL(url)
                        }
                    }
                    .frame(width: 180, height: 48)
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
                            .frame(width: 180, height: 48)
                            .background(.white)
                            //.buttonStyle(.bordered)
                            .cornerRadius(8)
                            .font(.headline)
                            .fontDesign(.serif)
                        }
                    }
                }
                .padding(.top, 8)
                
                Spacer()
                Spacer()
            }
            .padding(.trailing, 32.0)
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
    }
}

//#Preview {
//    RecipesCardView()
//}


//
//  CachedImage.swift
//  AsyncImageStarter
//
//  Created by Tunde Adegoroye on 09/04/2022.
//

import SwiftUI

struct CachedImage<Content: View>: View {
    
    @StateObject private var manager = ImageCacheManager()
    let url: String
    let content: (AsyncImagePhase) -> Content
    
    init(url: String,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }
    
    
    var body: some View {
        ZStack {
            switch manager.currentState {
            case .loading:
                content(.empty)
            case .success(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                } else {
                    content(.failure(CachedImageError.invalidData))
                }
            case .failed(let error):
                content(.failure(error))
            default:
                content(.empty)
            }
        }
        // .animation(animation, value: manager.currentState)
        .task {
            await manager.load(url)
        }
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/600px-RedDot_Burger.jpg") { _ in EmptyView() }
    }
}

extension CachedImage {
    enum CachedImageError: Error {
        case invalidData
    }
}
