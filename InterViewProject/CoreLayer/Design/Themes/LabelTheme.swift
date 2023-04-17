//
//  labelTheme.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
import UIKit

struct LabelTheme {
     
    let textTheme: TextTheme
    let backgroundColor: UIColor
     
    static let `default` = LabelTheme(textTheme: .default, backgroundColor: .clear)
    static let headerH1 = LabelTheme(textTheme: .headerH1, backgroundColor: .clear)
    static let headerH2 = LabelTheme(textTheme: .headerH2, backgroundColor: .clear)
    static let textP1 = LabelTheme(textTheme: .textP1, backgroundColor: .clear)
}
