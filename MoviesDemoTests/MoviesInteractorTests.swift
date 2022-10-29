//
//  MoviesInteractorTests.swift
//  MoviesDemoTests
//
//  Created by Anis Rehman on 25/10/2022.
//  Copyright © 2022 Anis ur Rehman. All rights reserved.
//

import XCTest

final class MoviesInteractorTests: XCTestCase {
    var interactor: MoviesInteractor!
    override func setUp() async throws {
        DependencyContainer.shared.register(type: MovieStoring.self, value: MockMoviesRepository(), overwrite: true)
        interactor = MoviesInteractor()
    }

    func testFetchMoviesSearchAndClearSearch() throws {
        //Fetch Movies
        let expectation = self.expectation(description: "Movies Fetched")
        var result: [Movie]?
        interactor.fetchMovies(.topRated) { movies, error in
            result = movies
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        let allMovies =  try XCTUnwrap(result)
        XCTAssertGreaterThan(allMovies.count, 0, "No movie found")

        //Search
        var searchResult: [Movie]?
        let searchExpectation = self.expectation(description: "Movies Search")
        interactor.searchMovies(text: "Godfather", category: .topRated) { movies in
            searchResult = movies
            searchExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        let searchMovies =  try XCTUnwrap(searchResult)
        XCTAssertGreaterThan(searchMovies.count, 0, "No movie searched")

        //Clear search
        var clearSearchResult: [Movie]?
        interactor.clearSearch(category: .topRated) { movies in
            clearSearchResult = movies
        }
        let clearSearchMovies =  try XCTUnwrap(clearSearchResult)
        XCTAssertEqual(allMovies.count, clearSearchMovies.count)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
