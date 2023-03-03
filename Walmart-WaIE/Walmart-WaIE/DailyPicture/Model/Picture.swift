//
//  Picture.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
struct Picture: Codable {
    var title : String
    var description : String
    var url : URL
    var mediaType : String
    var copyright : String?
    
    enum CodingKeys : String, CodingKey
    {
        case title
        case description = "explanation"
        case url
        case mediaType = "media_type"
        case copyright
    }
}
