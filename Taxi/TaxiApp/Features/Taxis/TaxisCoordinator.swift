//
//  TaxisCoordinator.swift
//  TaxiApp
//
//  Created by Kabir Khan on 04.12.20.
//

import Foundation
import UIKit

final class TaxisCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let factory: TaxisFactory
    
    init(navigationController: UINavigationController, factory: TaxisFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewController = factory.makeViewController()
        navigationController.viewControllers = [viewController]
    }
    
}
