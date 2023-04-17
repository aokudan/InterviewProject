//
//  Drawable.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 9.03.2022.
//

import Foundation
import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
