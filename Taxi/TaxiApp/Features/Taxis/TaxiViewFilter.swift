//
//  TaxisFilter.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation

enum TaxiViewFilter: Int, CaseIterable {
    case all
    case active
    case inactive
    
}

extension TaxiViewFilter {
    
    var localizeValue: String {
        switch self {
        case .all:
           return NSLocalizedString("All", comment: "")
        case .active:
            return NSLocalizedString("Active", comment: "")
        case .inactive:
            return NSLocalizedString("Inactive", comment: "")
        }
    }
}
