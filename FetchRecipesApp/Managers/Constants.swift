//
//  Constants.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

/*
 The following JSON endpoints provide the data for your project.
 
 All Recipes: https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json
 You’ll also find test endpoints to simulate various scenarios.

 Malformed Data: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json
 Empty Data: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json
 If a recipe is malformed, your app should disregard the entire list of recipes and handle the error gracefully. If the recipes list is empty, the app should display an empty state to inform users that no recipes are available.
*/

import Foundation
extension NetworkManager {
    struct Constants {
        struct URL {
            static let APIScheme = "https"
            static let APIHost = "d3jbb8n5wk0qxi.cloudfront.net"
            static let APIHappyPath = "/recipes.json"
            static let APIMalformedPath = "recipes-malformed.json"
            static let APIEmptyPath = "recipes-empty.json"
        }
    }
}
