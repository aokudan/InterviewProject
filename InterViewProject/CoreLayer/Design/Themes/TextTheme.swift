//
//  TextTheme.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
import UIKit

struct TextTheme {
    
    let color: UIColor
    let font: UIFont
    
    static let `default` = TextTheme(color: UIColor.myAppBlack, font: UIFont(name: "Helvetica", size: 12)!)
    static let headerH1 = TextTheme(color: UIColor.myAppBlack, font: UIFont(name: "Helvetica-Bold", size: 18)!)
    static let headerH2 = TextTheme(color: UIColor.myAppBlack, font: UIFont(name: "Helvetica-Bold", size: 15)!)
    static let textP1 = TextTheme(color: UIColor.myAppBlack, font: UIFont(name: "Helvetica", size: 15)!)
}
