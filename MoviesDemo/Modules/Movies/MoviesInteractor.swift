//
//  MoviesInteractor.swift
//  MoviesDemo
//
//  Created Anis Rehman on 11/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import UIKit

class MoviesInteractor: MoviesInteractable {
    var moviesService = MoviesService()

    init() {
        DependencyContainer.shared.register(type: MovieStoring.self, value: MovieRepository(), overwrite: false)
    }

    func fetchMovies(_ category: Category, completion: @escaping ([Movie]?, Error?) -> Void) {
        moviesService.fetchMovies(category) { [weak self] movies, error in
            guard let weakSelf = self else { return }
            let movieRepository = DependencyContainer.shared.get(MovieStoring.self)
            if let movies {
                movieRepository?.resetMovies(movies, category: category)
                completion(movies, error)
            } else if error != nil {
                let movies = weakSelf.moviesFromDB(category: category)
                completion(movies, error)
            }
        }
    }
    
    func searchMovies(text: String, category: Category, completion: ([Movie]) -> Void) {
        let movieRepository = DependencyContainer.shared.get(MovieStoring.self)
        let movies = movieRepository?.searchMovies(text: text, category: category) ?? []
        completion(movies)
    }
    
    func clearSearch(category: Category, completion: ([Movie]) -> Void) {
        let movies = moviesFromDB(category: category)
        completion(movies)
    }
    
    private func moviesFromDB(category: Category) -> [Movie] {
        let movieRepository = DependencyContainer.shared.get(MovieStoring.self)
        let movies = movieRepository?.allMovies(category: category) ?? []
        return movies
    }
}
