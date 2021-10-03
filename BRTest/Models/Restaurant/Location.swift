//
//  Location.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

struct Location {
    let address: String
    let crossStreet: String
    let latitude: Double
    let longitude: Double
    let postalCode: String
    let state: String
}

// MARK: - Extension

extension Location {
    
    init(dictionary: [String: Any]) {
        if let address = dictionary["address"] as? String {
            self.address = address
        } else {
            self.address = ""
        }
        if let crossStreet = dictionary["crossStreet"] as? String {
            self.crossStreet = crossStreet
        } else {
            self.crossStreet = ""
        }
        if let latitude = dictionary["lat"] as? Double {
            self.latitude = latitude
        } else {
            self.latitude = 0.0
        }
        if let longitude = dictionary["lng"] as? Double {
            self.longitude = longitude
        } else {
            self.longitude = 0.0
        }
        if let postalCode = dictionary["postalCode"] as? String {
            self.postalCode = postalCode
        } else {
            self.postalCode = ""
        }
        if let state = dictionary["state"] as? String {
            self.state = state
        } else {
            self.state = ""
        }
    }
    
}
