//
//  DailyPicServiceEndPOint.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
import Foundation

enum DailyPicServiceEndPoint{
    case getDailyPicture(name: String)
}

extension DailyPicServiceEndPoint: Endpoint{
    
    var request: URLRequest? { request(forEndpoint: "/planetary/apod") }
    var httpMethod: HTTPMethod { .get }
    var httpHeaders: [String : String]? { nil }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getDailyPicture(let name):
            return [
                URLQueryItem(name: "api_key", value: "NTpCwgxv9NQibUWAfSt5fOAz9ddqmEBYE7dCeo0z")
            ]
        }
    }
    var scheme: String { "https" }
    var host: String { "api.nasa.gov" }
}
