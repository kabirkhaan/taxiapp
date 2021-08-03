//
//  NetworkRouter.swift
//  TaxiApp
//
//  Created by Kabir Khan on 03.12.20.
//

import Foundation
import Alamofire

protocol NetworkRequst: URLRequestConvertible {
    
    typealias RequestParameters = [String: String]
    
    var method: HTTPMethod { get }
    var url: URL { get }
    var parameters: RequestParameters { get }
    
}

extension URLRequestConvertible where Self: NetworkRequst {
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        guard  method == .get else {
           return try JSONParameterEncoder().encode(parameters, into: request)
        }
        
        return try URLEncodedFormParameterEncoder().encode(parameters, into: request)
    }
    
}
