//
//  MockEmptyResponse.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation

enum Mocker {
    
    struct EmptyResponse: Decodable {}
    
    enum StubError: Error {
        case fake
    }
}


