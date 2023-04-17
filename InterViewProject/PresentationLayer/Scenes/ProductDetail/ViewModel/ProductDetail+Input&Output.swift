//
//  ProductDetail+Input&Output.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
protocol ProductDetailInput: AnyObject {
    func viewDidLoad()
    func clickedBack()
}

protocol ProductDetailOutput: AnyObject {
    func customise()
    func refresh()
}

protocol ProductDetailOutputToCoordinator: AnyObject {
    func goToBack()
}
