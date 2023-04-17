//
//  Enums.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

enum ViewModelState: Equatable {
  case loading
  case error(String)
  case idle
  case success(String)
}

enum SortType {
    case price, name
    
    var title: String{
        switch self {
        case .price: return "Price"
        case .name: return "Name"
        }
    }
    
    static let allValues = [price, name]
}
