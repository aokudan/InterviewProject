//
//  DataLoadOperation.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation
class DataLoadOperation: AsyncOperation {
    
    fileprivate let url: URL
    fileprivate let completion: ((Data?) -> ())?
    fileprivate var loadedData: Data?
    fileprivate var dataTask: URLSessionDataTask?
    
    init(url: URL, completion: ((Data?) -> ())? = nil) {
        self.url = url
        self.completion = completion
        super.init()
    }
    
    override func main() {
        if self.isCancelled { return }
        /*
        let client = APIClient()
        let imageService = ImageService(client: client)
        imageService.getData(url: self.url) { [weak self] response in
            guard let self = self else { return }
            if self.isCancelled { return }
            switch response {
            case .success(let response):
                self.loadedData = response
                self.completion?(response)
            case .failure( _):
                self.loadedData = nil
                self.completion?(nil)
            }
            self.state = .Finished
            
        }
        */
        self.dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if let _data = data {
                self.loadedData = _data
                self.completion?(_data)
                
            }else{
                self.loadedData = nil
                self.completion?(nil)
            }
            
            
            self.state = .Finished
            
        }
        
        dataTask?.resume()
    }
    
    override func cancel() {
        super.cancel()
        dataTask?.cancel()
        dataTask = nil
    }
}

extension DataLoadOperation: ImageDecompressionOperationDataProvider {
    var compressedData: Data? { return loadedData }
}
