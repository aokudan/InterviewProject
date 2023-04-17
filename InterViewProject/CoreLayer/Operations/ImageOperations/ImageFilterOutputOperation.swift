//
//  ImageFilterOutputOperation.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import UIKit

class ImageFilterOutputOperation: ImageFilterOperation {
    
    fileprivate let completion: (UIImage?) -> ()
    
    init(completion: @escaping (UIImage?) -> ()) {
        self.completion = completion
        super.init(image: nil)
    }
    
    override func main() {
        if isCancelled { return }
        completion(filterInput)
    }
}
