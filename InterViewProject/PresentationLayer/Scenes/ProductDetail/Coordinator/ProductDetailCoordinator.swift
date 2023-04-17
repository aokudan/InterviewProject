//
//  ProductDetailCoordinator.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation

class ProductDetailCoordinator : BaseCoordinator {

    typealias Dependencies = HasProductDAO
    
    let router: WireframeProtocol

    private let dependencies: Dependencies
    private let productDetail: DetailModel
    
    init(router: WireframeProtocol, dependencies: Dependencies, detail: DetailModel) {
        self.router = router
        self.dependencies = dependencies
        self.productDetail = detail
    }

    override func start() {

        // prepare the associated view and injecting its viewModel
        let viewModel = ProductDetailViewModel(dependency: dependencies, detail: self.productDetail)
        let viewController = ProductDetailViewController(viewModel: viewModel)
        
        viewModel.outputToCoordinator = self

        router.push(viewController, isAnimated: true, onNavigateBack: self.isCompleted)
    }
}

extension ProductDetailCoordinator: ProductDetailOutputToCoordinator {
    func goToBack() {
        router.pop(true)
    }
}
