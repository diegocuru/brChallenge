//
//  RestaurantRepository.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

enum RestaurantRepository {

    // MARK: - Properties and Data Types
    
    typealias completionBlock = (_ apiError: APIError?, _ restaurants: [Restaurant]?) -> Void
    
    // MARK: - Methods
    
    static func getRestaurants(completionBlock: @escaping completionBlock) {
        API.getRestaurants { apiError, data in
            if let apiError = apiError {
                completionBlock(apiError, nil)
                return
            }
            guard let data = data else {
                let apiError = APIError(code: 0, message: "data is nil")
                completionBlock(apiError, nil)
                return
            }
            guard let restaurantsData = data["restaurants"] as? [[String: Any]] else {
                let apiError = APIError(code: 0, message: "data doesn't contains restaurants")
                completionBlock(apiError, nil)
                return
            }
            let restaurants = restaurantsData.map { Restaurant(dictionary: $0) }
            completionBlock(nil, restaurants)
        }
    }
    
}
