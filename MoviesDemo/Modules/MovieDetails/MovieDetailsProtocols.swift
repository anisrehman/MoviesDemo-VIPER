//
//  MovieDetailsProtocols.swift
//  MoviesDemo
//
//  Created Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol MovieDetailsRoutable: AnyObject {

}
//MARK: Presenter -
protocol MovieDetailsPresentable: AnyObject {

    var interactor: MovieDetailsInteractable? { get set }
    var movie: Movie { get set }
    
    func showMovieDetails()
}

//MARK: Interactor -
protocol MovieDetailsInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
}

protocol MovieDetailsInteractable: AnyObject {

    var presenter: MovieDetailsInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol MovieDetailsViewable: AnyObject {

    var presenter: MovieDetailsPresentable?  { get set }

    /* Presenter -> ViewController */
    func showMovieDetails(movie: Movie)

}
