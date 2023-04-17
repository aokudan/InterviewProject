//
//  ProductEntity+CoreDataProperties.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Int16
    @NSManaged public var productId: String?
    @NSManaged public var image: String?
    @NSManaged public var detail: ProductDetailEntity?

}

extension ProductEntity : Identifiable {

}

extension ProductEntity: ModelConvertible {
    /// The managed entity name.
    static var entityName = "ProductEntity"

    // MARK: - ModelConvertible
    /// Converts a ProductEntity instance to a ProductModel instance.
    ///
    /// - Returns: The converted Product instance.
    func toModel() -> ProductModel? {
        return ProductModel(productId: productId, name: name, price: Int(price), image: image)
    }
}
