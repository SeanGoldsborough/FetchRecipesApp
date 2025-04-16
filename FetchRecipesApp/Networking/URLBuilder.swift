//
//  URLBuilder.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import Foundation

extension NetworkManager {
    
    func URLFromPath(path: String) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.URL.APIScheme
        components.host = Constants.URL.APIHost
        components.path = path

        return components.url!
    }
}
