//
//  ImageCacheManagerTests.swift
//  FetchRecipesAppTests
//
//  Created by Sean Goldsborough on 4/17/25.
//

import XCTest
@testable import FetchRecipesApp

final class ImageCacheManagerTests: XCTestCase {

    func testCacheInitialization() {
        let cacheManager = ImageCache()
        XCTAssertNotNil(cacheManager.cache, "NSCache should be initialized")
    }
}
