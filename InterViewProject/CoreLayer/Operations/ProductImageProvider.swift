//
//  ProductImageProvider.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import UIKit

class ProductImageProvider {
    
    fileprivate let operationQueue = OperationQueue()

    let url: URL?
    var image: UIImage?
    
    var loadingCompleteHandler: ((UIImage?) ->Void)?

    init(url: URL?, completion:((UIImage?) -> ())? = nil) {
        self.url = url
        self.loadingCompleteHandler = completion
        guard let imageUrl = url else { return }
        
        // Create the operations
        let dataLoad = DataLoadOperation(url: imageUrl)
        let imageDecompress = ImageDecompressionOperation(data: nil)
        let sizeOperation = ImageSizeOperation(image: nil)
        let filterOutput = ImageFilterOutputOperation { [weak self] image in
            guard let self = self else { return }
            self.image = image

            if let handler = self.loadingCompleteHandler {
                DispatchQueue.main.async {
                    handler(image)
                }
            }
        }
        
        let operations = [dataLoad, imageDecompress, sizeOperation, filterOutput]
        
        // Add dependencies
        imageDecompress.addDependency(dataLoad)
        sizeOperation.addDependency(imageDecompress)
        filterOutput.addDependency(sizeOperation)
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}
