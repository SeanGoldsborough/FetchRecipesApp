//
//  String + Ext.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/16/25.
//

import Foundation
extension String {
    func cuisineFlag(cuisineName: String?) -> String {
        guard let cuisine = cuisineName else { return "" }
        let lowerCaseCuisine = cuisine.lowercased()
        
        switch lowerCaseCuisine{
        case "american":
            return CuisineFlags.american.rawValue
        case "british":
            return CuisineFlags.british.rawValue
        case "canadian":
            return CuisineFlags.canadian.rawValue
        case "croatian":
            return CuisineFlags.croatian.rawValue
        case "french":
            return CuisineFlags.french.rawValue
        case "greek":
            return CuisineFlags.greek.rawValue
        case "italian":
            return CuisineFlags.italian.rawValue
        case "malaysian":
            return CuisineFlags.malaysian.rawValue
        case "polish":
            return CuisineFlags.polish.rawValue
        case "portuguese":
            return CuisineFlags.portuguese.rawValue
        case "russian":
            return CuisineFlags.russian.rawValue
        case "tunisian":
            return CuisineFlags.tunisian.rawValue
        default:
            return ""
        }
    }
}
