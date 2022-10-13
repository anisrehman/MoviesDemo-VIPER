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

    struct Movie: Codable {
        let id: Int64
        let popularity: Double
        let voteCount: Int32
        let video: Bool
        let posterPath: String?
        let adult: Bool
        let backdropPath: String?
        let originalLanguage: String
        let originalTitle: String
        let title: String
        let voteAverage: Double
        let overview: String
        let releaseDate: String

        enum CodingKeys: String, CodingKey {
            case id
            case popularity
            case voteCount = "vote_count"
            case video
            case posterPath = "poster_path"
            case adult
            case backdropPath = "backdrop_path"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case title
            case voteAverage = "vote_average"
            case overview
            case releaseDate = "release_date"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int64.self, forKey: .id)
            popularity = try values.decode(Double.self, forKey: .popularity)
            voteCount = try values.decode(Int32.self, forKey: .voteCount)
            video = try values.decode(Bool.self, forKey: .video)
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
            adult = try values.decode(Bool.self, forKey: .adult)
            backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
            originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
            originalTitle = try values.decode(String.self, forKey: .originalTitle)
            title = try values.decode(String.self, forKey: .title)
            voteAverage = try values.decode(Double.self, forKey: .voteAverage)
            overview = try values.decode(String.self, forKey: .overview)
            releaseDate = try values.decode(String.self, forKey: .releaseDate)
        }

        init(movieEntity: MovieEntity) {
            id = movieEntity.id
            popularity = movieEntity.popularity
            voteCount = movieEntity.voteCount
            video = movieEntity.video
            posterPath = movieEntity.posterPath ?? ""
            adult = movieEntity.adult
            backdropPath = movieEntity.backdropPath ?? ""
            originalLanguage = movieEntity.originalLanguage ?? ""
            originalTitle = movieEntity.originalTitle ?? ""
            title = movieEntity.title ?? ""
            voteAverage = movieEntity.voteAverage
            overview = movieEntity.overview ?? ""
            releaseDate = movieEntity.releaseDate ?? ""
        }
    }
}
