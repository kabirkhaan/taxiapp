//
//  TaxisViewModel.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation

protocol TaxisViewModel: class {
   
    var onStateChange: ((TaxisViewState) -> Void)? { get set }
    var filter: TaxiViewFilter { get }
    
    func refresh()

    func filtersViewData() -> (filters: [String], selectedIndex: Int)
    func apply(filter: Int)
    
    func count() -> Int
    func object(at indexPath: IndexPath) -> TaxiViewData?

}

final class TaxisViewModelImpl: TaxisViewModel {
    
    private let fetchTaxisUseCase: TaxisFetchUseCase
    private let filterTaxisUseCase: TaxisFilterUseCase
    
    var onStateChange: ((TaxisViewState) -> Void)?
    var filter: TaxiViewFilter
    
    private var list: [TaxiViewData]
    private var taxis: [Vehicle]
    
    init(fetchTaxisUseCase: TaxisFetchUseCase, filterTaxisUseCase: TaxisFilterUseCase) {
        self.fetchTaxisUseCase = fetchTaxisUseCase
        self.filterTaxisUseCase = filterTaxisUseCase
        list = []
        taxis = []
        filter = .all
        registerUseCaseEvents()
    }
    
    func refresh() {
        filter = .all
        update(state: .changeFilter(filter.rawValue))
        update(state: .loading)
        
        let start = Coordinate(latitude: 53.694865, longitude: 9.757589)
        let destination = Coordinate(latitude: 53.394655, longitude: 10.099891)
        fetchTaxisUseCase.execute(start: start, destination: destination)
    }
    
    // MARK: Filter

    func filtersViewData() -> (filters: [String], selectedIndex: Int) {
        let filters = TaxiViewFilter.allCases.map { $0.localizeValue }
        
        return (filters, filter.rawValue)
    }
    
    func apply(filter: Int) {
        self.filter = TaxiViewFilter(rawValue: filter) ?? .all
        list = filterTaxisUseCase.execute(list: taxis, filter: self.filter)
        update(state: .updated)
    }
    
    // MARK: Data Source
    // IMPORTANT: Remove Datasource from view model, make view model state less.
    
    func count() -> Int {
        return list.count
    }
    
    func object(at indexPath: IndexPath) -> TaxiViewData? {
        guard list.count > indexPath.row else {
            return nil
        }
        
       return list[indexPath.row]
    }
  

}

private extension TaxisViewModelImpl {
    
    func registerUseCaseEvents() {
        fetchTaxisUseCase.onExecuted = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success((let taxis, let viewDataList)):
                self.taxis = taxis
                self.list = viewDataList
                self.update(state: .updated)
            case .failure(let error):
                self.update(state: .error(message: error.localizedDescription))
            }
        }
    }
    
    func update(state: TaxisViewState) {
        DispatchQueue.main.async {
            self.onStateChange?(state)
        }
    }
    
}
