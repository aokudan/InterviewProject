//
//  DetailModel.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 10.03.2022.
//

import Foundation
import CoreData

struct DetailModel: Codable {
    let productId: String?
    let name: String?
    let price: Int?
    let image: String?
    let descriptionProduct: String?
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name
        case price
        case image
        case descriptionProduct = "description"
    }
}

extension DetailModel: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> ProductDetailEntity? {
        let entityName = ProductDetailEntity.entityName
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            NSLog("Can't create entity \(entityName)")
            return nil
        }
        let object = ProductDetailEntity.init(entity: entityDescription, insertInto: context)
        object.productId = productId
        object.name = name
        object.price = Int16(price ?? 0)
        object.image = image
        object.productDescription = descriptionProduct
        return object
    }
}
