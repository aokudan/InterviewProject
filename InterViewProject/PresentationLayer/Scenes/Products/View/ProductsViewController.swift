//
//  ProductsViewController.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import UIKit

class ProductsViewController: BaseViewController {

    let viewModel: ProductsViewModel
    let loader: ImageLoader = ImageLoader()
    
    lazy var tblProducts: UITableView = {
        let tbl = UITableView(frame: .zero)
        tbl.backgroundColor = .white
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    lazy var cllProdcuts: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    required init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
        self.viewModel.outputBase = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input?.viewDidLoad()
    }

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = Dimensions.cellItemSize
        let numberOfCellsInRow = floor(Dimensions.screenWidth / Dimensions.cellItemSize.width)
        let inset = (Dimensions.screenWidth - (numberOfCellsInRow * Dimensions.cellItemSize.width)) / (numberOfCellsInRow + 1)
        layout.sectionInset = .init(top: inset,
                                    left: inset,
                                    bottom: inset,
                                    right: inset)
        return layout
    }
}

extension ProductsViewController {

}

// MARK: - UICollectionViewDataSource
extension ProductsViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {
            fatalError("Expected `\(ProductCell.self)` type for reuseIdentifier \(ProductCell.reuseIdentifier). Check the configuration in Main.storyboard.")
        }

        cell.updateImageViewWithImage(nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input?.didSelectItem(at: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension ProductsViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductCell else { return }
        
        let product = self.viewModel.getItem(at: indexPath)
        
        loader.loadImage(from: product.image, indexPath: indexPath) { [unowned cell] image in
            DispatchQueue.main.async {
                cell.updateImageViewWithImage(image)
            }
        }
        
        cell.showProductInfo(product: product)
    }
    
    func collectionView(_ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let _ = cell as? ProductCell else { return }
        
        loader.cancelPrefetching(at: [indexPath])
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension ProductsViewController:UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = viewModel.getImageUrls(with: indexPaths)
        loader.prefetchItem(at: indexPaths, for: urls)
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        loader.cancelPrefetching(at: indexPaths)
    }
}

extension ProductsViewController: ProductsOutput {
    func customise(){

        self.view.backgroundColor = .white
        
        self.view.addSubview(cllProdcuts)
        NSLayoutConstraint.activate([
            cllProdcuts.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            cllProdcuts.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cllProdcuts.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            cllProdcuts.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        cllProdcuts.prefetchDataSource = self
        cllProdcuts.dataSource = self
        cllProdcuts.delegate = self
    }
    
    func refresh() {
        self.navigationItem.title = "Products"
        cllProdcuts.reloadData()
    }
    
    func setupBindings() {
        cllProdcuts.bindTo(viewModel.results)
    }
}

extension ProductsViewController: BaseOutput {
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

