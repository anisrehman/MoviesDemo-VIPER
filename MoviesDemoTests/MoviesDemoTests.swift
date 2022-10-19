//
//  MoviesDemoTests.swift
//  MoviesDemoTests
//
//  Created by Anis ur Rehman on 2/11/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class MoviesDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMovies() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
