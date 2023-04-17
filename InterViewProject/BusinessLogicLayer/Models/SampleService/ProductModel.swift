//
//  ProductModel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation
import CoreData

struct ProductModel: Codable {
    let productId: String?
    let name: String?
    let price: Int?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name
        case price
        case image
    }
}

extension ProductModel {
    func imageUrl() -> URL? {
        guard let i = image else { return nil }
        return URL(string: i)
    }
}

extension ProductModel: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> ProductEntity? {
        let entityName = ProductEntity.entityName
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            NSLog("Can't create entity \(entityName)")
            return nil
        }
        let object = ProductEntity.init(entity: entityDescription, insertInto: context)
        object.productId = productId
        object.name = name
        object.price = Int16(price ?? 0)
        object.image = image
        return object
    }
}
