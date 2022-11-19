//
//  MoviesService.swift
//  MoviesDemo
//
//  Created by Anis Rehman on 06/10/2022.
//  Copyright © 2022 Anis ur Rehman. All rights reserved.
//

import Foundation

protocol MoviesFetching {
    func fetchMovies(_ category: Category, completion: @escaping (([Movie]?, Error?) -> Void))
}

class MoviesService: MoviesFetching {
    func fetchMovies(_ category: Category, completion: @escaping (([Movie]?, Error?) -> Void)) {
        // Decide which API to be called based on category
        var apiRouter = APIRouter.popular(page: 1)
        switch category {
        case .popular:
            apiRouter = .popular(page: 1)
        case .topRated:
            apiRouter = .topRated(page: 1)
        case .upcoming:
            apiRouter = .upcoming(page: 1)
        }
        
        guard let request = apiRouter.asURLRequest() else { return }

        APIClient.sendRequest(request, type: MoviesResponse.self){ (response, error) in
            if let response = response {
                let movies = response.results.map { movieResponse in
                    Movie(id: movieResponse.id, popularity: movieResponse.popularity, voteCount: movieResponse.voteCount, video: movieResponse.video, posterPath: movieResponse.posterPath, adult: movieResponse.adult, backdropPath: movieResponse.backdropPath, originalLanguage: movieResponse.originalLanguage, originalTitle: movieResponse.originalTitle, title: movieResponse.title, voteAverage: movieResponse.voteAverage, overview: movieResponse.overview, releaseDate: movieResponse.releaseDate)
                }

                completion(movies, nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
}
