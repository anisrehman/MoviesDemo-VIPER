//
//  MoviesServiceTests.swift
//  MoviesDemoTests2
//
//  Created by Anis Rehman on 19/10/2022.
//  Copyright © 2022 Anis ur Rehman. All rights reserved.
//

import XCTest

final class MoviesServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTopRatedMovies() throws {
        var result: [Movie]?
        let expectation = self.expectation(description: "Movies Fetched")

        let moviesService = MoviesService()
        moviesService.fetchMovies(.topRated) { movies, error in
            result = movies
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result)
        if let result {
            XCTAssertGreaterThan(result.count, 0)
        }
    }

    func testFetchPopularMovies() throws {
        var result: [Movie]?
        let expectation = self.expectation(description: "Movies Fetched")

        let moviesService = MoviesService()
        moviesService.fetchMovies(.popular) { movies, error in
            result = movies
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result)
        if let result {
            XCTAssertGreaterThan(result.count, 0)
        }
    }

    func testFetchUpcomingMovies() throws {
        var result: [Movie]?
        let expectation = self.expectation(description: "Movies Fetched")

        let moviesService = MoviesService()
        moviesService.fetchMovies(.upcoming) { movies, error in
            result = movies
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result)
        if let result {
            XCTAssertGreaterThan(result.count, 0)
        }
    }

    func testSearchMovies() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
