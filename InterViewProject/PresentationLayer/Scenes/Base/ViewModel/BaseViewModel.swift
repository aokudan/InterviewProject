//
//  BaseViewModel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import Foundation

protocol BaseViewModelProtocol: AnyObject {
    
}

class BaseViewModel: BaseViewModelProtocol {
    
    weak var inputBase: BaseInput?
    weak var outputBase: BaseOutput?
    
    var state: ViewModelState = .idle {
        didSet {
            outputBase?.didUpdateState()
        }
    }

    
    init() {
        inputBase = self
    }
}

// MARK: - ProductsViewModelInput
extension BaseViewModel: BaseInput {

}
