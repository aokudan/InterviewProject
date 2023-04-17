//
//  ProductDetailEntity+CoreDataProperties.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//
//

import Foundation
import CoreData


extension ProductDetailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductDetailEntity> {
        return NSFetchRequest<ProductDetailEntity>(entityName: "ProductDetailEntity")
    }

    @NSManaged public var productDescription: String?
    @NSManaged public var productId: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int16
    @NSManaged public var image: String?
    @NSManaged public var product: ProductEntity?

}

extension ProductDetailEntity : Identifiable {

}

extension ProductDetailEntity: ModelConvertible {
    /// The managed entity name.
    static var entityName = "ProductDetailEntity"

    // MARK: - ModelConvertible
    /// Converts a ProductDetailEntity instance to a DetailModel instance.
    ///
    /// - Returns: The converted Product instance.
    func toModel() -> DetailModel? {
        return DetailModel(productId: productId, name: name, price: Int(price), image: image, descriptionProduct: productDescription)
    }
}
