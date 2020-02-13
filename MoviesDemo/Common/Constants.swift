//
//  Constant.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation

// Applicaton constants
struct Constants {
    static let apiKey = "cc346b178afb5ea8c95940ae125f26a2"
//    static let apiKey = "cc346b178afb5ea8c95940ae1"
    static let apiLanguage = "en-US"
    static let apiBaseURL = "https://api.themoviedb.org/3/movie"
    static let smallImageBaseURL = "https://image.tmdb.org/t/p/w154"
    static let mediumImageBaseURL = "https://image.tmdb.org/t/p/w185"
    struct APIParameter {
        static let apiKey = "api_key"
        static let language = "language"
        static let page = "page"
    }
}
