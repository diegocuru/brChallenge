//
//  APIError.swift
//  BRTest
//
//  Created by Diego Curumaco on 2/10/21.
//

struct APIError {
    let code: Int
    let message: String
}

// MARK: - Extension

extension APIError {
    
    init(type: APIErrorType) {
        switch type {
        case .urlCreation:
            code = -1
            message = "Could not create the URL from string provided"
        case .httpURLResponse:
            code = -2
            message = "Could not create response"
        case .dataNil:
            code = -3
            message = "Could not get the data"
        case .mimmeType:
            code = -4
            message = "Incorrect content type received"
        case .jsonData:
            code = -5
            message = "Incorrect json data received"
        case .imageData:
            code = -6
            message = "Incorrect image data received"
        case .unreachable:
            code = -7
            message = "Could not get response"
        }
    }
    
}
