//
//  ProducDetailView.swift
//  InterViewProject
//
//  Created by Abdullah Okudan on 18.03.2022.
//

import Foundation
import UIKit

class ProductDetailView: UIView {

    //let view: UIView
    
    lazy var scrll: UIScrollView = {
        let sc = UIScrollView(frame: .zero)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    lazy var contentView: UIView = {
        let cv = UIView(frame: .zero)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imgProduct: DownloadableImageView = {
        let img = DownloadableImageView(frame: .zero)
        return img
    }()
    
    lazy var lblTitle: H1HeaderLabel = {
        let lbl = H1HeaderLabel(frame: .zero)
        return lbl
    }()
    
    lazy var lblDescription: P1TextLabel = {
        let lbl = P1TextLabel(frame: .zero)
        return lbl
    }()
    
    lazy var btnTest: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Geri Dön", for: .normal)
        btn.addTarget(self, action: #selector(clickedBackButton), for: .touchUpInside)
        return btn
    }()
    
    var backButtonClickedCompletion: ((Bool)->Void)?
    
    override init(frame: CGRect) {
        //self = UIView(frame: frame)
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickedBackButton(){
        backButtonClickedCompletion?(true)
    }
}

extension ProductDetailView {
    func customise(){
        self.backgroundColor = .white
        /*
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])*/
        
        self.addSubview(scrll)
        NSLayoutConstraint.activate([
            scrll.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrll.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrll.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrll.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        self.scrll.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.scrll.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.scrll.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.scrll.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.scrll.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrll.widthAnchor)
        ])
        
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
        
        imgProduct.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        btnTest.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnTest.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.addArrangedSubview(imgProduct)
        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(lblDescription)
        stackView.addArrangedSubview(btnTest)
    }
    
    func refresh(detail: DetailModel?) {
        guard let detail = detail else {return }

        lblTitle.text = detail.name ?? ""
        lblDescription.text = detail.descriptionProduct ?? ""
        imgProduct.downloadWithUrlSession(with: detail.image)
    }
}
