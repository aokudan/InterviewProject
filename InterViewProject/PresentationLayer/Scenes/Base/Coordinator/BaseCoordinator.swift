//
//  BaseCoordinator.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 9.03.2022.
//

import Foundation

class BaseCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }
    
    func start(coordinator: BaseCoordinator) {
        self.store(coordinator: coordinator)
        coordinator.isCompleted = { [weak self, weak coordinator] in
            self?.free(coordinator: coordinator)
        }
        coordinator.start()
    }
}
