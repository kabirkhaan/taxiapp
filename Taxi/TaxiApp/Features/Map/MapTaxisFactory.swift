//
//  MapTaxisFactory.swift
//  TaxiApp
//
//  Created by Kabir Khan on 05.12.20.
//

import Foundation
import UIKit

struct MapTaxisFactory {
    
    let networkService: NetworkService
    
    func makeCoordinator(navigationController: UINavigationController) -> Coordinator {
        return MapTaxisCoordinator(navigationController: navigationController,
                                  factory: self)
    }

    func makeViewController() -> UIViewController {
        return MapTaxisViewController(with: makeViewModel())
    }
    
}

private extension MapTaxisFactory {
    
    func makeViewModel() -> MapTaxisViewModel {
        return MapTaxisViewModelImpl(useCase: makeFetchUseCase())
    }
    
    func makeFetchUseCase() -> MapTaxisFetchUseCase {
        return MapTaxisFetchUseCaseImpl(mapper: makeMapper(), repository: makeRepository())
    }
    
    func makeRepository() -> TaxisRepository {
        let remoteRepository: TaxisRemoteRepository = TaxisRemoteRepositoryImpl(service: networkService)
        return TaxisRepositoryImpl(remoteRepository: remoteRepository)
    }
    
    func makeMapper() -> MapTaxisMapper {
        return MapTaxisMapperImpl()
    }

}
