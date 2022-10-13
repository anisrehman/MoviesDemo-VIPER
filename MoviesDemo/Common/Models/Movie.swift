//
//  MovieResponse.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation


// This model is using for parsing the movie object in API response.
struct Movie {
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
}
