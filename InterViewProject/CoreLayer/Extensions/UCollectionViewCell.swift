//
//  UCollectionViewCell.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 11.03.2022.
//

import UIKit

protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { .init(describing: self) }
}

extension UICollectionViewCell: ReuseIdentifiable {}
