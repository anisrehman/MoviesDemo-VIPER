//
//  MockMoviesRepository.swift
//  MoviesDemoTests
//
//  Created by Anis Rehman on 27/10/2022.
//  Copyright © 2022 Anis ur Rehman. All rights reserved.
//

import Foundation

class MockMoviesRepository: MovieStoring {
    var movies: [Movie] = []
    func resetMovies(_ movies: [Movie], category: Category) {
        self.movies.removeAll()
        self.movies.append(contentsOf: movies)
    }

    func addMovie(_ movie: Movie, in category: Category) {
        self.movies.append(movie)
    }

    func allMovies(category: Category) -> [Movie] {
        movies
    }

    func searchMovies(text: String, category: Category) -> [Movie] {
        let movies = movies.filter { $0.title.contains(text) }
        return movies
    }

    func deleteAllMovies(category: Category) {
        self.movies.removeAll()
    }
}
