//
//  ProductDetailViewModelTest.swift
//  TurkcellAssignmentTests
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import XCTest
@testable import TurkcellAssignment

class ProductDetailViewModelTests: XCTestCase {
    
    typealias Dependency = HasProductDAO
    
    // MARK: System Under Test
    private var sut: ProductDetailViewModel!
    private var navigationController: UINavigationController!
    private var router: Wireframe!
    private var coordinator: ProductDetailCoordinator!
    private var dependencies: Dependency!
    
    // MARK: - Set Up & Tear Down
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        router = Wireframe(navigationController: navigationController)
        dependencies = AppDependency()
        
        
        // Initial mock data
        if let data = LoadTestData.readLocalFile("TestProductDetailData", withExtension: "json"){
            let product: DetailModel = try! JSONDecoder().decode(DetailModel.self, from: data)
            sut = ProductDetailViewModel(dependency: dependencies, detail: product)
            coordinator = ProductDetailCoordinator(router: router, dependencies: dependencies, detail: product)
        }
    }
    
    override func tearDown() {
        navigationController = nil
        sut = nil
        router = nil
        coordinator = nil
        dependencies = nil
        super.tearDown()
    }
    
    // MARK: - View Model Tests
    func testWhenViewDidLoad_TriesToLoadData() {
        
        let expectation = expectation(description: "Load product detail data")
        
        XCTAssertNotNil(sut.productDetail)
        XCTAssertEqual(sut.productDetail.name, "Apples")
        XCTAssertEqual(sut.productDetail.image, "https://s3-eu-west-1.amazonaws.com/developer-application-test/images/1.jpg")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2.0)
    }
}
