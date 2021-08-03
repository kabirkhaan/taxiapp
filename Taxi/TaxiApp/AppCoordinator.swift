//
//  AppCoordinator.swift
//  TaxiApp
//
//  Created by Kabir Khan on 04.12.20.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let taxisFactory: TaxisFactory
    private let mapTaxiFactory: MapTaxisFactory
    private var coordinator: Coordinator!
    
    init(window: UIWindow, taxisFactory: TaxisFactory, mapTaxiFactory: MapTaxisFactory) {
        self.window = window
        self.taxisFactory = taxisFactory
        self.mapTaxiFactory = mapTaxiFactory
    }
    
    func start() {
        let tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        
        let taxiNavigationViewController = UINavigationController()
        taxiNavigationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let taxiCoordinator = taxisFactory.makeCoordinator(navigationController: taxiNavigationViewController)
        
        let taxiMapNavigationViewController = UINavigationController()
        taxiMapNavigationViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        let taxiMapCoordinator = mapTaxiFactory.makeCoordinator(navigationController: taxiMapNavigationViewController)
        
        tabBarController.viewControllers = [taxiNavigationViewController,
                                            taxiMapNavigationViewController]

        taxiCoordinator.start()
        taxiMapCoordinator.start()
        
        window.makeKeyAndVisible()
    }
    
}
