//
//  ManagedObjectConvertible.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//

import CoreData
import Foundation

/// Protocol to provide functionality for CoreData managed object conversion.
protocol ManagedObjectConvertible {
    associatedtype ManagedObject

    /// Converts a conforming instance to a managed object instance.
    ///
    /// - Parameter context: The managed object context to use.
    /// - Returns: The converted managed object instance.
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}
