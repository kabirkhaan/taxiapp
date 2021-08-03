//
//  MapTaxisCoordinator.swift
//  TaxiApp
//
//  Created by Kabir Khan on 04.12.20.
//

import Foundation
import UIKit

final class MapTaxisCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let factory: MapTaxisFactory
    
    init(navigationController: UINavigationController, factory: MapTaxisFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let viewController = factory.makeViewController()
        navigationController.viewControllers = [viewController]
    }
    
}
