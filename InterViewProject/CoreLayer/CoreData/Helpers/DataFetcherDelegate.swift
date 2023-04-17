//
//  DataFetcherDelegate.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//

import Foundation

protocol DataFetcherDelegate: AnyObject {
    associatedtype CodableModel
    associatedtype ManagedObject

    typealias DataFetcherCompletion = (Result<[ManagedObject]?, Error>) -> Void
    
    var entityName: String { get }

    func saveToStorage(models: [CodableModel])
    func fetchFromStorage(completion: @escaping DataFetcherCompletion)
}
