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
        //components.queryItems = [URLQueryItem]()
        
//        for (key, value) in parameters {
//            let queryItem = URLQueryItem(name: key, value: "\(value)")
//            components.queryItems!.append(queryItem)
//        }
        
        return components.url!
    }
}
