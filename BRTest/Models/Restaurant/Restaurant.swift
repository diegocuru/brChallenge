//
//  Restaurant.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

struct Restaurant {
    let name: String
    let category: String
    let backgroundImageURL: String?
    let contact: Contact?
    let location: Location?
}

// MARK: - Extension

extension Restaurant {
    
    init(dictionary: [String: Any]) {
        if let name = dictionary["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        if let backgroundImageURL = dictionary["backgroundImageURL"] as? String {
            self.backgroundImageURL = backgroundImageURL
        } else {
            self.backgroundImageURL = nil
        }
        if let category = dictionary["category"] as? String {
            self.category = category
        } else {
            self.category = ""
        }
        if let contact = dictionary["contact"] as? [String: Any] {
            self.contact = Contact(dictionary: contact)
        } else {
            self.contact = nil
        }
        if let location = dictionary["location"] as? [String: Any] {
            self.location = Location(dictionary: location)
        } else {
            self.location = nil
        }
    }
    
}
