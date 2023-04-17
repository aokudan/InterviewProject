//
//  DAOType.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//

import Foundation
import CoreData

enum StoreTypeDAO: String {
    case NSInMemoryStoreType, NSSQLiteStoreType, NSBinaryStoreType
}

protocol ProtocolDAO {
    
    var persistentContainer: NSPersistentContainer { get set }
    var coreDataWrapper: CoreDataWrapper { get set }
    
    associatedtype CodableModel
    associatedtype ManagedObject
    
    var entityName: String { get }
    var storeType: StoreTypeDAO { get }
    var storeUrl: URL? { get }
    var persistentStoreDescription: NSPersistentStoreDescription { get }
    
    var sortDescriptors: [NSSortDescriptor]? { get }
    
    var entityItems: [ManagedObject]? { get set }
    
    /**/
    typealias DataFetcherCompletion = (Result<[ManagedObject]?, Error>) -> Void
    typealias FetchItemsCompletionBlock = (Result<[CodableModel]?, Error>) -> Void

    func saveToStorage(models: [CodableModel])
    func saveItemToStorage(model: CodableModel)
    func fetchFromStorage(with itemId: String?, completion: @escaping DataFetcherCompletion)
    func fetchItems(with itemId: String?, completion: @escaping FetchItemsCompletionBlock)
    func clearStorage()
    /**/

    init(persistentContainer: NSPersistentContainer, coreDataWrapper: CoreDataWrapper)
    
    //func initalizeStack(completion: @escaping () -> Void)
}
