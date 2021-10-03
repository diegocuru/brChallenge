//
//  API.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

import Foundation
import UIKit

enum API {
    
    // MARK: - Enums
    
    private enum Endpoint {
        case restaurants
        
        private var prefix: String {
            return "https://"
        }
        private var domainBase: String {
            return "s3.amazonaws.com"
        }
        private var endpoint: String {
            switch self {
            case .restaurants:
                return "/br-codingexams/restaurants.json"
            }
        }
        var url: URL? {
            switch self {
            case .restaurants:
                let urlString = prefix+domainBase+endpoint
                return URL(string: urlString)
            }
        }
    }
    
    // MARK: - Properties and Data Type
    
    typealias dictionaryCompletionBlock = (_ apiError: APIError?, _ data: [String: Any]?) -> Void
    typealias imageCompletionBlock = (_ apiError: APIError?, _ image: UIImage?) -> Void
    
    // MARK: - Methods
    
    static func getRestaurants(completionBlock: @escaping dictionaryCompletionBlock) {
        guard let url = Endpoint.restaurants.url else {
            completionBlock(APIError.init(type: .urlCreation), nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpError = httpError(response: response) {
                completionBlock(httpError, nil)
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else {
                completionBlock(APIError(type: .mimmeType), nil)
                return
            }
            guard let data = data else {
                completionBlock(APIError(type: .dataNil), nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let restaurantsDictionary = json as? [String: Any] else {
                    completionBlock(APIError(type: .jsonData), nil)
                    return
                }
                completionBlock(nil, restaurantsDictionary)
            } catch {
                completionBlock(APIError(type: .jsonData), nil)
            }
        }.resume()
    }
    
    static func getImage(from url: String, completionBlock: @escaping imageCompletionBlock) {
        guard let url = URL(string: url) else {
            completionBlock(APIError.init(type: .urlCreation), nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpError = httpError(response: response) {
                completionBlock(httpError, nil)
                return
            }
            guard let data = data else {
                completionBlock(APIError(type: .dataNil), nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completionBlock(APIError(type: .imageData), nil)
                return
            }
            completionBlock(nil, image)
        }.resume()
    }
    
    // MARK: - Private
    
    private static func httpError(response: URLResponse?) -> APIError? {
        guard let response = response else {
            return APIError(type: .unreachable)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return APIError(type: .httpURLResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            return APIError(code: httpResponse.statusCode, message: "Request error")
        }
        return nil
    }
    
}
