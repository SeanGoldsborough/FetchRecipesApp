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
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Recipes.self, from: data)
        
        performUpdatesOnMain {
            self.recipes = decoded.recipes ?? []
        }
        return decoded.recipes ?? []
    }
}

extension NetworkManager {
    
    func loadJson(fileName: String) -> [Recipe]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Recipes.self, from: data)
                if let recipeData = jsonData.recipes {
                    self.recipes = recipeData
                }
                return jsonData.recipes
            } catch {
                print("error:\(error)")
                return nil
            }
        }
        return nil
    }
    
    func readJSONFile(forName name: String) -> String {
       do {
          if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
             let jsonString = try? String(contentsOfFile: bundlePath) {
              print("JSONSTRING: \(jsonString)")
              return jsonString
          }
       } catch {
          print(error)
           return ""
       }
        return ""
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
