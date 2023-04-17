//
//  ProductDetailDAO.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import Foundation
import CoreData


class ProductDetailDAO: ProtocolDAO {
    var persistentContainer: NSPersistentContainer
    var coreDataWrapper: CoreDataWrapper
    
    typealias CodableModel = DetailModel
    typealias ManagedObject = ProductDetailEntity
    
    var entityName: String {
        return "ProductDetailEntity"
    }
    
    var storeType: StoreTypeDAO {
        return .NSInMemoryStoreType
    }
    var storeUrl: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first?.appendingPathComponent("database")
    }
    
    var persistentStoreDescription: NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription()
        description.type = storeType.rawValue
        
        if storeType == .NSSQLiteStoreType || storeType == .NSBinaryStoreType {
            description.url = storeUrl
        }
        
        return description
    }
    
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "productId", ascending: true)]
    }
    
    var entityItems: [ManagedObject]?

    required init(persistentContainer: NSPersistentContainer, coreDataWrapper: CoreDataWrapper) {
        self.persistentContainer = persistentContainer
        self.coreDataWrapper = coreDataWrapper
    }
    
    func saveToStorage(models: [CodableModel]) {

    }
    
    func saveItemToStorage(model: CodableModel){
        fetchFromStorage(with: model.productId) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let products):
                    guard let ps = products else { return }

                    if ps.count == 0 {
                        self.coreDataWrapper.atomic { (context) in
                            _ = model.toManagedObject(in: context)
                        }
                    }
                case .failure( _):
                    break
            }
        }
    }
    
    func fetchFromStorage(with itemId: String? = nil, completion: @escaping DataFetcherCompletion) {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ManagedObject>(entityName: entityName)
        if let pId = itemId {
            fetchRequest.predicate = NSPredicate(format: "productId == %@", pId)
        }
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            self.entityItems = try managedObjectContext.fetch(fetchRequest)
            return completion(.success(self.entityItems))
        } catch let error {
            return completion(.failure(error))
        }
    }
    
    func fetchItems(with itemId: String?, completion: @escaping FetchItemsCompletionBlock) {
        fetchFromStorage { (result) in
            switch result {
                case .success(let products):
                    guard let p = products else { return completion(.success([]))}
                    completion(.success(p.map({$0.toModel()!})))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func clearStorage() {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let items = try managedObjectContext.fetch(fetchRequest)
                for item in items {
                    managedObjectContext.delete(item as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}

