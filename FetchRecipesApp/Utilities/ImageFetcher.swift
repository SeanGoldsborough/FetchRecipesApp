//
//  ImageFetcher.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/15/25.
//

import Foundation

struct ImageFetcher {
    
    func fetch(_ imgUrl: String) async throws -> Data {
        guard let url = URL(string: imgUrl) else {
            throw FetcherError.invalidUrl
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

private extension ImageFetcher {
    enum FetcherError: Error {
        case invalidUrl
    }
}
