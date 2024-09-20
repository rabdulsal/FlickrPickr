//
//  FlickrPicItem.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/20/24.
//

import Foundation

struct FlickrPicData: Codable {
    let items: [FlickrPicItem]
}

struct FlickrPicItem: Codable {
    
    struct FPMediaValue: Codable {
        let m: String
    }
    
    let link: String // Use for \.self in View display
    let title: String
    let media: FPMediaValue// TODO: Use CodingKey for media: "m" -> link
    let author: String
    let description: String // TODO: Will need to decode HTML to properly parse description
    let published: String
//    let height: String TODO: Will need to parse these from description
//    let width: String
}
