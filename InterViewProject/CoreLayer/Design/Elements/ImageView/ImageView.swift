//
//  ImageView.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
import UIKit

class ImageView: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }
    
    func update() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
    }
}

