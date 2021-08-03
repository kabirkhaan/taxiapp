//
//  NetworkRequestConvertible.swift
//  TaxiApp
//
//  Created by Kabir Khan on 03.12.20.
//

import Foundation
import Alamofire

protocol NetworkRequestConvertible: URLRequestConvertible {
    
    typealias RequestParameters = [String: String]
    
    var method: RequestHTTPMethod { get }
    var url: URL { get }
    var parameters: RequestParameters { get }
    
}

extension URLRequestConvertible where Self: NetworkRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        guard  method == .get else {
           return try JSONParameterEncoder().encode(parameters, into: request)
        }
        
        return try URLEncodedFormParameterEncoder().encode(parameters, into: request)
    }
    
}
