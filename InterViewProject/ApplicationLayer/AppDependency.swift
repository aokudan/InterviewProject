//
//  AppDependency.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 9.03.2022.
//

import Foundation
import CoreData

protocol HasClient {
    var client: APIClient { get }
}

protocol HasSampleService {
    var sampleService: SampleServiceType { get }
}

protocol HasDataService {
    var imageService: DataServiceType { get }
}

protocol HasProductDAO {
    var productDAO: ProductDAO { get }
}

protocol HasImageLoader {
    var imageLoader: ImageLoaderType { get }
}

struct AppDependency: HasClient, HasSampleService, HasProductDAO, HasImageLoader {
    let client: APIClient
    let sampleService: SampleServiceType
    let imageService: DataServiceType
    let productDAO: ProductDAO
    let imageLoader: ImageLoaderType

    init() {
        
        let persistentContainer = NSPersistentContainer(name: "TurkcellAssignment")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("could not load store \(error.localizedDescription)")
                return
            }
            print("store loaded")
        }
        let coreDataWrapper: CoreDataWrapper = CoreDataWrapper(persistentContainer: persistentContainer)
        
        self.client = APIClient()
        self.sampleService = SampleService(client: client)
        self.imageService = DataService(client: client)
        self.productDAO = ProductDAO(persistentContainer: persistentContainer, coreDataWrapper: coreDataWrapper)
        self.imageLoader = ImageLoader()
    }

}
