//
//  ProductCell.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 11.03.2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    var product: ProductModel?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgProduct.image = nil
    }
    
    // MARK: - Properties
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imgProduct: ImageView = {
        let imageView = ImageView(frame: .zero)
        return imageView
    }()
    
    
    lazy var lblTitle: H2HeaderLabel = {
        let lbl = H2HeaderLabel()
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var lblPrice: P1TextLabel = {
        let lbl = P1TextLabel()
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.center = self.contentView.center
        return indicator
    }()
    
}

// MARK: - UI Setup
extension ProductCell {
    private func setupUI() {
        contentView.backgroundColor = .myAppLightGray
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        stackView.addArrangedSubview(imgProduct)
        imgProduct.heightAnchor.constraint(equalTo: imgProduct.widthAnchor, constant: 0).isActive = true

        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(lblPrice)
        
        self.contentView.addSubview(activityIndicator)
        activityIndicator.center = contentView.center
    }
    
    func updateImageViewWithImage(_ image: UIImage?) {
        if let image = image {
            imgProduct.image = image
            imgProduct.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.imgProduct.alpha = 1.0
                self.activityIndicator.alpha = 0
            }, completion: {
                _ in
                self.activityIndicator.stopAnimating()
            })
            
        } else {
            self.imgProduct.image = nil
            self.imgProduct.alpha = 0
            self.activityIndicator.alpha = 1.0
            self.activityIndicator.startAnimating()
        }
    }
    
    func showProductInfo(product: ProductModel){
        lblTitle.text = product.name ?? ""
        lblPrice.text = "\(product.price ?? 0)"
    }
}
