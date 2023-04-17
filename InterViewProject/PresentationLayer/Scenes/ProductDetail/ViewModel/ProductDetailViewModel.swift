//
//  ProductDetailViewModel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation

class ProductDetailViewModel: BaseViewModel {
    
    // MARK: - Private Properties
    private let dependency: Dependency

    weak var input: ProductDetailInput?
    weak var output: ProductDetailOutput?
    weak var outputToCoordinator: ProductDetailOutputToCoordinator?
    
    var productDetail: DetailModel! {
        didSet {
            output?.refresh()
        }
    }

    // MARK: - ViewModelType
    typealias Dependency = HasProductDAO
    
    init(dependency: Dependency, detail: DetailModel) {
        self.dependency = dependency
        self.productDetail = detail
        super.init()
        input = self
    }
}

// MARK: - ProductsViewModelInput
extension ProductDetailViewModel: ProductDetailInput {

    func viewDidLoad() {
        output?.customise()
        output?.refresh()
    }
    
    func clickedBack(){
        outputToCoordinator?.goToBack()
    }
}
