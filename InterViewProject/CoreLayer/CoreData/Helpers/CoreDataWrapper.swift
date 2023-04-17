//
//  CoreDataWrapper.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//

import CoreData
import Foundation

class CoreDataWrapper {
    typealias ContextBlock = (NSManagedObjectContext) -> Void

    private let persistentContainer: NSPersistentContainer
    private let syncContext: NSManagedObjectContext

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        syncContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        syncContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        syncContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
    }

    func atomic(_ lambdaBlock: ContextBlock) {
        guard let context = writableContext() else {
            print("<CoreDataWrapper> - Cannot create writable managed object context")
            return
        }
        atomic(context: context, lambdaBlock: lambdaBlock)
    }

    func atomic(context: NSManagedObjectContext, lambdaBlock: ContextBlock) {
        context.performAndWait {
            lambdaBlock(context)
            save(context: context)
        }
    }

    private func writableContext() -> NSManagedObjectContext? {
        // `syncContext` is a child context that supports writing to CoreData
        // main context from a background thread.
        return syncContext
    }

    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
            print("<CoreDataWrapper> - Saved changes.")
        } catch {
            print("<CoreDataWrapper> - Could not save changes in context: \(error)")
        }
    }
}

