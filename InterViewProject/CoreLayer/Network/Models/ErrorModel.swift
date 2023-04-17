//
//  ErrorModel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

struct ErrorModel: Codable {
    let statusMessage: String
    let success: Bool?
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage
        case success
        case statusCode = "status_code"
    }
}
