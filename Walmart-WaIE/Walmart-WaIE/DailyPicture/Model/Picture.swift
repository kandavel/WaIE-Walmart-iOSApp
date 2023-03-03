//
//  Picture.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
struct Picture: Codable {
    var date, explanation: String?
        var hdurl: String?
        var mediaType, serviceVersion, title: String?
        var url: String?

        enum CodingKeys: String, CodingKey {
            case date, explanation, hdurl
            case mediaType = "media_type"
            case serviceVersion = "service_version"
            case title, url
        }
}
