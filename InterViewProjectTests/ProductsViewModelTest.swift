//
//  ProductsViewModelTest.swift
//  TurkcellAssignmentTests
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import XCTest
@testable import TurkcellAssignment

class ProductsViewModelTests: XCTestCase {
    typealias Dependency = HasClient & HasSampleService & HasProductDAO
    
    // MARK: System Under Test
    private var sut: ProductsViewModel!
    private var navigationController: UINavigationController!
    private var router: Wireframe!
    private var coordinator: ProductsCoordinator!
    private var dependencies: Dependency!
    
    // MARK: - Set Up & Tear Down
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        router = Wireframe(navigationController: navigationController)
        dependencies = AppDependency()
        sut = ProductsViewModel(dependency: dependencies)
        coordinator = ProductsCoordinator(router: router, dependencies: dependencies)
        
        // Initial mock data
        if let data = LoadTestData.readLocalFile("TestProductsData", withExtension: "json"){
            let products: [ProductModel] = try! JSONDecoder().decode([ProductModel].self, from: data)
            sut.products = products
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
        
        let expectation = expectation(description: "Load products data")
        
        XCTAssertNotNil(sut.products)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testNumberOfProducts_ReturnItemsCount(){
        let expectation = expectation(description: "Get products count")
        
        let count = sut.numberOfProducts()
        
        XCTAssertEqual(count, 12)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetItem_ClickedToRow_ReturnProduct(){
        let expectation = expectation(description: "Get product at IndexPath")
        
        let product = sut.getItem(at: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(product.name, "Bananas")
        XCTAssertEqual(product.productId, "3")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetImageUrls_GivenIndexPaths_ReturnUrls(){
        let expectation = expectation(description: "Get product at IndexPath")
        
        let urls = sut.getImageUrls(with: [IndexPath(row: 3, section: 0)])
        
        XCTAssertEqual(urls[0], "https://s3-eu-west-1.amazonaws.com/developer-application-test/images/4.jpg")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2.0)
    }
}
