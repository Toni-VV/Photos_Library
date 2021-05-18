//
//  SearchResponse.swift
//  PhotosLibrary
//
//  Created by Антон on 18.05.2021.
//

import Foundation

struct SearchResponse: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
    
}


struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue: String]
}

enum URLKing: String {
    case raw, full, regular, small, thumb
}
