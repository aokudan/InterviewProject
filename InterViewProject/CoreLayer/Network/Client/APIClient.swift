//
//  APIClient.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

protocol ClientType {
    func request<T: Codable>(router: Router, completion: @escaping (ApiResult<T, ErrorModel>) -> ())
    func requestData(url: URL?, completion: @escaping (ApiResult<Data, ErrorModel>) -> ())
}

class APIClient: ClientType {
    
    func request<T: Codable>(router: Router, completion: @escaping (ApiResult<T, ErrorModel>) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let err = error {
                completion(.failure(ErrorModel(statusMessage: err.localizedDescription, success: false, statusCode: 0)))
                return
            }
            guard response != nil, let data = data else {
                return
            }
        
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
    
    func requestData(url: URL?, completion: @escaping (ApiResult<Data, ErrorModel>) -> ()) {

        guard let _url = url else { return }
        var urlRequest = URLRequest(url: _url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let err = error {
                completion(.failure(ErrorModel(statusMessage: err.localizedDescription, success: false, statusCode: 0)))
                return
            }
            guard response != nil, let data = data else {
                return
            }
        
            DispatchQueue.main.async {
                
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
}

