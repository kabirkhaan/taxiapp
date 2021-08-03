//
//  AppFactory.swift
//  TaxiApp
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation
import UIKit

struct AppFactory {
    
    let networkService: NetworkService
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        networkService = NetworkServiceImpl(queue: DispatchQueue(label: Constants.dispatchQueueLabel),
                                            session: .default,
                                            decoder: decoder)
    }
    
    func makeCoordinator(window: UIWindow) -> Coordinator {
        return AppCoordinator(window: window,
                              taxisFactory: makeTaxisFactory(),
                              mapTaxiFactory: makeMapTaxisFactory())
    }
    
}

private extension AppFactory {
    
    enum Constants {
        static let dispatchQueueLabel = "queue.network.parser"
    }
    
    func makeTaxisFactory() -> TaxisFactory {
        return .init(networkService: networkService)
    }
    
    func makeMapTaxisFactory() -> MapTaxisFactory {
        return .init(networkService: networkService)
    }
}
