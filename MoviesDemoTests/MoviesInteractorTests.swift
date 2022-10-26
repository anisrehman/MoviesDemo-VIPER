//
//  MoviesInteractorTests.swift
//  MoviesDemoTests
//
//  Created by Anis Rehman on 25/10/2022.
//  Copyright © 2022 Anis ur Rehman. All rights reserved.
//

import XCTest

final class MoviesInteractorTests: XCTestCase {
    let interactor = MoviesInteractor()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFetchMovies() throws {
        let expectation = self.expectation(description: "Movies Fetched")

        var result: [Movie]?
        interactor.fetchMovies(.topRated) { movies, error in
            result = movies
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result)
        if let result {
            XCTAssertGreaterThan(result.count, 0)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
