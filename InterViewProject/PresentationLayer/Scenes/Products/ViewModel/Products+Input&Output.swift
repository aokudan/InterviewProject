//
//  Products+Input&Output.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

protocol ProductsInput: AnyObject {
    func viewDidLoad()
    func getImageUrls(with indexPaths:[IndexPath]) -> [String?]

    func numberOfProducts() -> Int
    func didSelectItem(at indexPath: IndexPath)
    func getItem(at indexPath: IndexPath) -> ProductModel
}

protocol ProductsOutput: AnyObject {
    func customise()
    func refresh()
    func setupBindings() //Binder için
}

protocol ProductsOutputToCoordinator: AnyObject {
    func selectedProduct(productDetail: DetailModel)
}
