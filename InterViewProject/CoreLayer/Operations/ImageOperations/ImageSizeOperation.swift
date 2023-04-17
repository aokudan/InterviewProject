//
//  TiltShiftOperation.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import UIKit

class ImageSizeOperation : ImageFilterOperation {
    
    override func main() {
        if isCancelled { return }
        guard let inputImage = filterInput else { return }
                
        if isCancelled { return }
        filterOutput = inputImage
    }
}
