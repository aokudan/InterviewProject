//
//  ApiResult.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

enum ApiResult<Value, Error>{
    case success(Value)
    case failure(Error)

    init(value: Value){
        self = .success(value)
    }

    init(error: Error){
        self = .failure(error)
    }
}
