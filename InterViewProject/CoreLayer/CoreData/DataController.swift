//
//  DataController.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//
/*
import Foundation
import CoreData

protocol DataControllerType {
    associatedtype CodableModel
    associatedtype ManagedObject
    
    func fetchItems<T>() throws -> [T]
}

class DataController {
    let persistentContainer = NSPersistentContainer(name: "TurkcellAssignment")
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var fetchController: NSFetchedResultsController<ProductEntity>?
    
    init(storeType: String? = nil){
        self.initalizeStack(storeType: storeType) {
            _ = try? self.fetchProducts()
            let request = ProductEntity.fetchRequest() as NSFetchRequest<ProductEntity>
            request.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
            
            let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                             managedObjectContext: self.context,
                                                             sectionNameKeyPath: nil, cacheName: nil)

            self.fetchController = fetchController
            try? fetchController.performFetch()
        }
    }
    
    func fetchProducts() throws -> [ProductModel?] {
        let users = try self.context.fetch(ProductEntity.fetchRequest() as NSFetchRequest<ProductEntity>)
        return users.map { entity in
            return entity.toModel()
        }
        //return users
    }
    
    func insertProducts(products: [ProductModel]) throws{
        products.forEach { product in
            if let managedProduct = product.toManagedObject(in: self.context){
                try? self.insert(product: managedProduct)
            }
        }
    }
    
    func deleteProducts() throws {
        let fetchRequest = ProductEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        //fetchRequest.predicate = NSPredicate(format: "firstName == %@", name)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
    
    private func initalizeStack(storeType: String?, completion: @escaping () -> Void) {
        self.setStore(type: storeType)
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("could not load store \(error.localizedDescription)")
                return
            }
            print("store loaded")
            completion()
        }
    }
    
    private func setStore(type: String?) {
        guard let storeType = type else { return }
        let description = NSPersistentStoreDescription()
        description.type = storeType // types: NSInMemoryStoreType, NSSQLiteStoreType, NSBinaryStoreType
        
        if storeType == NSSQLiteStoreType || storeType == NSBinaryStoreType {
            description.url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?.appendingPathComponent("database")
        }
        
        self.persistentContainer.persistentStoreDescriptions = [description]
    }
    
    private func insert(product: ProductEntity) throws {
        
        self.context.insert(product)
        try self.context.save()
    }
}
*/
