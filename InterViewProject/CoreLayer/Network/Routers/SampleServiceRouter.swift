//
//  SampleServiceRouter.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

enum SampleServiceRouter: Router {
    
    case getProducts
    case getProductDetail(productId: String)

    var scheme: String {
        switch self {
        case .getProducts, .getProductDetail:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getProducts, .getProductDetail:
            return "s3-eu-west-1.amazonaws.com"
        }
    }

    var path: String {
        switch self {
        case .getProducts:
            return "/developer-application-test/cart/list"
        case .getProductDetail(let productId):
            return "/developer-application-test/cart/\(productId)/detail"
        }
    }

    /*
     [URLQueryItem(name: "ids", value: "2759162243,2759143811"),
         URLQueryItem(name: "page", value: "1"),
         URLQueryItem(name: "access_token", value: accessToken)]
     */
    var parameters: [URLQueryItem] {
        switch self {
        case .getProducts:
            return []
        case .getProductDetail:
            return []
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getProducts, .getProductDetail:
            return .get
        }
    }
    
}
