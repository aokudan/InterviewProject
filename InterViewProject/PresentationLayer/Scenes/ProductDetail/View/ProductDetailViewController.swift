//
//  ProductDetailViewController.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 15.03.2022.
//

import Foundation
import UIKit

class ProductDetailViewController: ViewController<ProductDetailView> {

    let viewModel: ProductDetailViewModel
    
    required init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.output = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input?.viewDidLoad()
    }
}

extension ProductDetailViewController {

}

extension ProductDetailViewController: ProductDetailOutput {
    func customise(){
        ui.customise()
        ui.backButtonClickedCompletion = { [weak self] cStatus in
            guard let self = self else { return }
            self.viewModel.clickedBack()
        }
    }
    
    func refresh() {
        self.navigationItem.title = "Product Detail"
        ui.refresh(detail: viewModel.productDetail)
    }
}

extension ProductDetailViewController: BaseOutput {
    func didUpdateState() {
        switch viewModel.state {
        case .idle:
            removeLoadingIndicator()
        case .loading:
            showLoadingIndicator(onView: self.view)
        case .error(let message):
            removeLoadingIndicator()
            showAlertMessage(message: message)
        case .success( _):
            break
        }
    }
}


