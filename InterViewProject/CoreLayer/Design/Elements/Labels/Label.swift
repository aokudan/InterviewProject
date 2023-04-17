//
//  Label.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
import UIKit

class Label: UILabel {
    
    var theme: LabelTheme {
        return .default
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }
    
    func update() {
        textColor = theme.textTheme.color
        font = theme.textTheme.font
        backgroundColor = theme.backgroundColor
        numberOfLines = 0
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
