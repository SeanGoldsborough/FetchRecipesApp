//
//  ImageFetcherTests.swift
//  FetchRecipesAppTests
//
//  Created by Sean Goldsborough on 4/17/25.
//

import XCTest
@testable import FetchRecipesApp

final class ImageFetcherTests: XCTestCase {
    
    func testStoreAndRetrieveFromCache() async {
        let cache = ImageCache.shared
        let cacheManager = ImageCacheManager()
        let url = "testURL"
        let data = "Test URL String Value".data(using: .utf8)! as NSData

        cache.set(object: data, forKey: url as NSString)

        let fetchedData = cache.object(forkey: url as NSString)! as NSData
        
        // MARK: fetchedData should equal the stored data
        XCTAssertEqual(fetchedData, data)
    }
}
