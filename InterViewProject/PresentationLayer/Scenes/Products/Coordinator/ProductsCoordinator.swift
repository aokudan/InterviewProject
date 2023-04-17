//
//  ProductsCoordinator.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

class ProductsCoordinator : BaseCoordinator {

    typealias Dependencies = HasSampleService & HasProductDAO
    
    let router: WireframeProtocol

    private let dependencies: Dependencies
    
    init(router: WireframeProtocol, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() {

        // prepare the associated view and injecting its viewModel
        
        //2. yöntem ekran yönlendirme için
        let selectionProduct: Callback<DetailModel> = { [weak self] product in
            guard let self = self else { return }
            
            let detailoordinator = ProductDetailCoordinator(router: self.router, dependencies: self.dependencies, detail: product)
            // store child coordinator
            self.start(coordinator: detailoordinator)
        }
        
        let viewModel = ProductsViewModel(dependency: dependencies, selectionProduct: selectionProduct)
        let viewController = ProductsViewController(viewModel: viewModel)
        
        viewModel.outputToCoordinator = self

        router.push(viewController, isAnimated: true, onNavigateBack: self.isCompleted)
    }
}

extension ProductsCoordinator: ProductsOutputToCoordinator{
    func selectedProduct(productDetail: DetailModel) {
        let detailoordinator = ProductDetailCoordinator(router: router, dependencies: dependencies, detail: productDetail)
        // store child coordinator
        self.start(coordinator: detailoordinator)

    }
}
