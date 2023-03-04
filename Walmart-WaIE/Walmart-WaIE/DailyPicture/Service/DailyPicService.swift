//
//  DailyPicService.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
typealias PictureResult = Result<Picture, NetworkError>

protocol MoviesServiceProtocol : AnyObject {
    func fetchDailyPictures(_ endPoint : Endpoint,completionHandler: @escaping (PictureResult) -> ())
}

class DailyPicService: MoviesServiceProtocol {
    
    func fetchDailyPictures(_ endPoint : Endpoint,completionHandler: @escaping (PictureResult) -> ()) {
        if let reachabilityError = checkReachability().error {
            completionHandler(.failure(.reachabilityError(error: reachabilityError)))
            return
        }
        NetworkManager.shared.request(endPoint, decodeToType: Picture.self, completionHandler: completionHandler)
    }
}
extension DailyPicService : NetworkReachable {
    
}
