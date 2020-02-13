//
//  ErrorResponse.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation

// We use this model if error is returned from server
struct ErrorResponse : Decodable {
    let status_code: Int
    let status_message: String
    let success: Bool
}
