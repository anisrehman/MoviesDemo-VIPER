//
//  MoviesResponse.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation

// This model is used to parse API response of movies list
struct MoviesResponse : Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        total_results = try values.decode(Int.self, forKey: .totalResults)
        total_pages = try values.decode(Int.self, forKey: .totalPages)
        results = try values.decode([Movie].self, forKey: .results)
    }
}
