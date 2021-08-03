//
//  TaxisFactory.swift
//  TaxiApp
//
//  Created by Kabir Khan on 04.12.20.
//

import Foundation
import UIKit

struct TaxisFactory {
    
    let networkService: NetworkService
    
    func makeCoordinator(navigationController: UINavigationController) -> Coordinator {
        return TaxisCoordinator(navigationController: navigationController, factory: self)
    }

    func makeViewController() -> UIViewController {
        return TaxisViewController(with: makeViewModel())
    }
    
}

private extension TaxisFactory {
    
    func makeViewModel() -> TaxisViewModel {
        return TaxisViewModelImpl(fetchTaxisUseCase: makeFetchUseCase(),
                                  filterTaxisUseCase: makeFilterUseCase())
    }
    
    func makeFetchUseCase() -> TaxisFetchUseCase {
        return TaxisFetchUseCaseImpl(mapper: makeMapper(), repository: makeRepository())
    }
    
    func makeFilterUseCase() -> TaxisFilterUseCase {
        return TaxisFilterUseCaseImpl(mapper: makeMapper())
    }
    
    func makeRepository() -> TaxisRepository {
        let remoteRepository: TaxisRemoteRepository = TaxisRemoteRepositoryImpl(service: networkService)
        return TaxisRepositoryImpl(remoteRepository: remoteRepository)
    }
    
    func makeMapper() -> TaxisMapper {
        return TaxisMapperImpl()
    }
    
}
