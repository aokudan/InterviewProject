//
//  ImageService.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

protocol DataServiceType {
    func getData(url: URL?, completion: @escaping (ApiResult<Data, ErrorModel>) -> ())
}

class DataService: DataServiceType {
    
    private let client: ClientType

    init(client: ClientType) {
        self.client = client
    }
    
    func getData(url: URL?, completion: @escaping (ApiResult<Data, ErrorModel>) -> ()) {
        self.client.requestData(url: url, completion: completion)
    }
}
