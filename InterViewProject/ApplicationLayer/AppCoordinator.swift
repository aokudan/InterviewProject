//
//  AppCoordinator.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 9.03.2022.
//

import Foundation
import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow
    private let dependencies: AppDependency

    init(window: UIWindow, appDelegate: AppDelegate) {
        self.window = window
        self.dependencies = AppDependency()
        super.init()
    }

    override func start() {
        // preparing root view
        
        let nav = UINavigationController()
        nav.navigationBar.barTintColor = UIColor.black
        
        let router = Wireframe(navigationController: nav)
        let myCoordinator = ProductsCoordinator(router: router, dependencies: dependencies)

        // store child coordinator
        self.start(coordinator: myCoordinator)

        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}
