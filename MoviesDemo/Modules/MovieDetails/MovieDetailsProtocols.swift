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
protocol MovieDetailsWireframeProtocol: AnyObject {

}
//MARK: Presenter -
protocol MovieDetailsPresenterProtocol: AnyObject {

    var interactor: MovieDetailsInteractorInputProtocol? { get set }
    var movie: Movie { get set }
    
    func showMovieDetails()
}

//MARK: Interactor -
protocol MovieDetailsInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
}

protocol MovieDetailsInteractorInputProtocol: AnyObject {

    var presenter: MovieDetailsInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol MovieDetailsViewProtocol: AnyObject {

    var presenter: MovieDetailsPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func movieToShowDetails(movie: Movie)

}
