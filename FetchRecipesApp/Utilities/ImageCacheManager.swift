//
//  ImageCacheManager.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/15/25.
//

import Foundation

final class ImageCacheManager: ObservableObject {
    
    @Published private(set) var currentState: CurrentState?
    
    private let imageFetcher = ImageFetcher()
    
    @MainActor
    func load(_ imgUrl: String,
              cache: ImageCache = .shared) async {
        
        self.currentState = .loading
        
        if let imageData = cache.object(forkey: imgUrl as NSString) {
            self.currentState = .success(data: imageData)
//            #if DEBUG
//            print("📱 Fetching image from the cache: \(imgUrl)")
//            #endif
            return
        }
        
        do {
            let data = try await imageFetcher.fetch(imgUrl)
            self.currentState = .success(data: data)
            cache.set(object: data as NSData,
                      forKey: imgUrl as NSString)
//            #if DEBUG
//            print("📱 Caching image: \(imgUrl)")
//            #endif
        } catch {
            self.currentState = .failed(error: error)
        }
    }
}

extension ImageCacheManager {
    enum CurrentState {
        case loading
        case failed(error: Error)
        case success(data: Data)
    }
}

extension ImageCacheManager.CurrentState: Equatable {
    static func == (lhs: ImageCacheManager.CurrentState,
                    rhs: ImageCacheManager.CurrentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (let .failed(lhsError), let .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (let .success(lhsData), let .success(rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}
