//
//  NetworkServiceMock.swift
//  TaxiAppTests
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation
@testable import TaxiApp

final class NetworkServiceMock<Model: Decodable>: NetworkService {
    
    var latestRequest: NetworkRequestConvertible?
    var requestCallCount: Int = 0
    var mockResult: Result<Model, Error>?
    
    func perform<Model: Decodable>(request: NetworkRequestConvertible,
                                   completion: @escaping (Result<Model, Error>) -> Void) {
        latestRequest = request
        requestCallCount += 1
        
        if let mockResult = mockResult as? Result<Model, Error> {
            completion(mockResult)
        }

    }
}

