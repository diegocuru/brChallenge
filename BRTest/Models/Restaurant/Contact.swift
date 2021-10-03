//
//  Contact.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

struct Contact {
    let phone: String
    let formattedPhone: String
    let twitter: String
}

// MARK: - Extension

extension Contact {
    
    init(dictionary: [String: Any]) {
        if let phone = dictionary["phone"] as? String {
            self.phone = phone
        } else {
            self.phone = ""
        }
        if let formattedPhone = dictionary["formattedPhone"] as? String {
            self.formattedPhone = formattedPhone
        } else {
            self.formattedPhone = ""
        }
        if let twitter = dictionary["twitter"] as? String {
            self.twitter = twitter
        } else {
            self.twitter = ""
        }
    }
    
}
