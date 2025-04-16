//
//  CachedImage.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/16/25.
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
