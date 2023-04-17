//
//  ProductsViewModel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation

protocol ProductsViewModelProtocol: AnyObject {
    
}

class ProductsViewModel: BaseViewModel {
    
    // MARK: - Private Properties
    private let dependency: Dependency
    private let selectionProduct: Callback<DetailModel> //2. yöntem ekran yönlendirme için

    weak var input: ProductsInput?
    weak var output: ProductsOutput?
    weak var outputToCoordinator: ProductsOutputToCoordinator?
    
    var products: [ProductModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.output?.refresh()
            }
        }
    }
    
    let results: Binder<[ProductModel]> = Binder([]) //Binder ile yapmak için

    // MARK: - ViewModelType
    typealias Dependency = HasSampleService & HasProductDAO
    
    init(dependency: Dependency, selectionProduct: @escaping Callback<DetailModel>) {
        self.dependency = dependency
        self.selectionProduct = selectionProduct
        super.init()
        input = self
    }
    
    private func retrieveProducts(){
        
        if state == .loading { return }
        state = .loading
        
        dependency.sampleService.getProducts { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let response):
                self.products = response.products
                self.results.value = response.products //binder için 2. yöntem
                self.insertProductsToDB()
                self.state = .idle
            case .failure(let error):
                self.retrieveDBProducts()
                self.state = .error(error.statusMessage)
            }
        }
    }
    
    private func insertProductsToDB(){
        dependency.productDAO.clearStorage()
        dependency.productDAO.saveToStorage(models: products)
    }
    
    private func retrieveDBProducts(){

        dependency.productDAO.fetchItems(with: nil) { (result) in
            switch result {
                case .success(let products):
                    self.products = products ?? []
                case .failure(let error):
                    print(error)
            }
        }
    }
}

// MARK: - ProductsViewModelInput
extension ProductsViewModel: ProductsInput {

    func viewDidLoad() {
        output?.customise()
        output?.setupBindings()
        retrieveProducts()
    }
    
    func getImageUrls(with indexPaths:[IndexPath]) -> [String?] {
        return indexPaths.map { self.products[$0.row].image }
    }
    
    func didSelectItem(at indexPath: IndexPath){
        if state == .loading { return }
        state = .loading
        
        let product = getItem(at: indexPath)
        guard let productId = product.productId else { return }
        
        dependency.sampleService.getProductDetail(for: productId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let detail):
                self.outputToCoordinator?.selectedProduct(productDetail: detail)
                //2. Yöntem olara
                //self.selectionProduct(detail)
                self.state = .idle
            case .failure(let error):
                self.state = .error(error.statusMessage)
            }
        }
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func getItem(at indexPath: IndexPath) -> ProductModel {
        return products[indexPath.row]
    }
}
