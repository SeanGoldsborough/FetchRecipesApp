//
//  ImageCache.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/15/25.
//

import Foundation

class ImageCache {
    
    typealias CacheType = NSCache<NSString, NSData>
    
    static let shared = ImageCache()
    
    init() {}
    
    lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()
    
    func object(forkey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }
    
    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
