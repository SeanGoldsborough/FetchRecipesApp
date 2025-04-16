//
//  ErrorMessages.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import Foundation

enum CustomError: String, Error {
    case badConnection = "Unable to complete your request"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "No data was received from the server. Please try again."
    case invalidData = "The data received from the server was invalid."
}
