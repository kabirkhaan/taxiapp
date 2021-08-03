//
//  NetworkService.swift
//  TaxiApp
//
//  Created by Kabir Khan on 03.12.20.
//

import Foundation
import Alamofire

protocol NetworkService {
    
    func perform<Model: Decodable>(request: NetworkRequestConvertible,
                                   completion: @escaping (Result<Model, Error>) -> Void)
    
}

final class NetworkServiceImpl: NetworkService {
    
    private let queue: DispatchQueue
    private let session: Session
    private let decoder: JSONDecoder
    
    init(queue: DispatchQueue, session: Session, decoder: JSONDecoder) {
        self.queue = queue
        self.session = session
        self.decoder = decoder
    }
    
    func perform<Model: Decodable>(request: NetworkRequestConvertible,
                                   completion: @escaping (Result<Model, Error>) -> Void) {
        session.request(try! request.asURLRequest())
            .validate(statusCode: 200..<300)
            .responseData { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let data):
                    do {
                        let model = try self.decoder.decode(Model.self, from: data)
                        completion(.success(model))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }.resume()
    }
    
}
