//
//  NetworkManager.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation


typealias ResultCallback<T> = (Result<T, NetworkError>) -> Void


final class NetworkManager {
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    fileprivate let parser: Parser =  Parser()
    
    func request<T: Codable>(_ endpoint: Endpoint,decodeToType type: T.Type,completionHandler: @escaping (Result<T,NetworkError>) -> ()) {
        guard let request = endpoint.request else {
            completionHandler(.failure(NetworkError.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { [unowned self] (data, response, error) in
            if let error = error {
                completionHandler(.failure(.responseError(error: error)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(NetworkError.dataMissing))
                return
            }
            self.parser.json(data: data, completition: completionHandler)
        }
        task.resume()
    }
}
