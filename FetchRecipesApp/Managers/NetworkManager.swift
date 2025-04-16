//
//  NetworkManager.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import Foundation

class NetworkManager : ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var recipes = [Recipe]()
    
    init() { }
        
    func getData(with URLString: String) async throws -> [Recipe] {
        let url = URLFromPath(path: URLString)
        print("URL  IS: \(url)")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Recipes.self, from: data)
        
        self.recipes = decoded.recipes ?? []
        print("recipes from getData call: \(self.recipes)")
        return decoded.recipes ?? []
    }
}

//extension NetworkManager {
//    func loadJson() -> [Recipe]? {
//        print("load json called")
//        if let url = Bundle.main.url(forResource: "recipies", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(Recipes.self, from: data)
//                if let recipeData = jsonData.recipes {
//                    self.recipes = recipeData
//                    //print("Last Recipe: \(self.recipes.last)")
//                }
//                return jsonData.recipes
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
//    
//    func loadJsonMisformed() -> [Recipe]? {
//        print("loadJsonMisformedcalled")
//        if let url = Bundle.main.url(forResource: "recipiesMalformed", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(Recipes.self, from: data)
//                if let recipeData = jsonData.recipes {
//                    self.recipes = recipeData
//                    //print("Last Recipe: \(self.recipes.last)")
//                }
//                return jsonData.recipes
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
//    
//    func loadJsonEmpty() -> [Recipe]? {
//        print("loadJsonEmpty called")
//        if let url = Bundle.main.url(forResource: "recipiesEmpty", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(Recipes.self, from: data)
//                if let recipeData = jsonData.recipes {
//                    self.recipes = recipeData
//                    print("Last Recipe - loadJsonEmpty: \(self.recipes.last)")
//                }
//                return jsonData.recipes
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
//}








//protocol APIClientProtocol {
//    func fetch<T: Decodable>(for: T.Type, from urlString: String) async throws -> T
//}
//
//class APIClient: APIClientProtocol {
//    
//    init() { }
//    
//    func fetch<T: Decodable>(for: T.Type, from urlString: String) async throws -> T {
//        
//        guard let url = URL(string: urlString) else {
//            throw APIError.invalidUrl
//        }
//        
//        let (data, urlResponse) = try await URLSession.shared.data(from: url)
//        
//        guard let httpUrlResponse = urlResponse as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
//            throw APIError.invalidResponse
//        }
//        
//        do {
////            let rawString = String(data: data, encoding: .utf8) ?? "No data"
////            print("OUTPUT: \n\(rawString)")
//            let result = try JSONDecoder().decode(T.self, from: data)
//            return result
//        } catch {
//            print("Decoding Error: \(error)")
//            throw APIError.invalidData
//        }
//    }
//}
//
//enum APIError: Error {
//    case invalidUrl
//    case invalidResponse
//    case invalidData
//}


//protocol ClaimServiceProtocol {
//    func fetchClaims() async throws -> [Claim]
//}
//
//class ClaimService: ClaimServiceProtocol {
//    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
//    
//    func fetchClaims() async throws -> [Claim] {
//        return try await withCheckedThrowingContinuation { continuation in
//            AF.request(baseURL)
//                .validate()
//                .responseDecodable(of: [Claim].self) { response in
//                    switch response.result {
//                    case .success(let claims):
//                        continuation.resume(returning: claims)
//                    case .failure(let error):
//                        continuation.resume(throwing: NetworkError.serverError(error))
//                    }
//                }
//        }
//    }
//}
