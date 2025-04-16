//
//  UIImageView+Ext.swift
//  FetchRecipesApp
//
//  Created by Sean Goldsborough on 4/14/25.
//

import Foundation
import UIKit
import SwiftUI

let cachedImages = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString:String) {
        self.image = nil
        var encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    
        if let cacheImage = cachedImages.object(forKey: urlString as NSString)  {
            self.image = cacheImage
            return
        }
        
        let url = URL(string: encodedURLString)
        let request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }

            if let downloadedImage = UIImage(data:data!){
                performUpdatesOnMain {
                    cachedImages.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
        })
        task.resume()
    }
}
