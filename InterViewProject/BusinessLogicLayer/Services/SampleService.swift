//
//  SampleService.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

protocol SampleServiceType {
    func getProducts(completion: @escaping (ApiResult<ProductsResponseModel, ErrorModel>) -> ())
    func getProductDetail(for productId:String, completion: @escaping (ApiResult<DetailModel, ErrorModel>) -> ())
}

class SampleService: SampleServiceType {
    
    private let client: ClientType

    init(client: ClientType) {
        self.client = client
    }
    
    func getProducts(completion: @escaping (ApiResult<ProductsResponseModel, ErrorModel>) -> ()) {
        self.client.request(router: SampleServiceRouter.getProducts, completion: completion)
    }
    
    func getProductDetail(for productId:String, completion: @escaping (ApiResult<DetailModel, ErrorModel>) -> ()) {
        self.client.request(router: SampleServiceRouter.getProductDetail(productId: productId), completion: completion)
    }
}
