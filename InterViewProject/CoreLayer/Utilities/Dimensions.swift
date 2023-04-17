//
//  Dimensions.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 11.03.2022.
//

import UIKit

struct Dimensions {
    static let screenWidth: CGFloat
        = UIScreen.main.bounds.width
    static let screenHeight: CGFloat
        = UIScreen.main.bounds.height
    
    static let cellItemSize
        = CGSize(width: Dimensions.screenWidth * 0.45,
                 height: Dimensions.screenWidth * 0.55)
    
}
