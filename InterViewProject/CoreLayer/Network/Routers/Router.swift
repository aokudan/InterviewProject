//
//  NetworkRouter.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

protocol Router {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}
