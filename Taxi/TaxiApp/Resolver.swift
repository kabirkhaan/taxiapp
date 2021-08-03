//
//  Resolver.swift
//  TaxiApp
//
//  Created by Kabir Khan on 04.12.20.
//

import Foundation
import UIKit

protocol AppResolver {
    func appCoordinator(window: UIWindow) -> Coordinator
}
final class Resolver {
    
    func appCoordinator(window: UIWindow) -> Coordinator {
        return AppCoordinator(window: window)
    }
    
    func taxiCood
}
