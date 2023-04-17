//
//  Coordinator.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 9.03.2022.
//

import Foundation

protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    func start()
}

extension Coordinator {

    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
