//
//  APIClient.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case customError(message: String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError(let message):
            return NSLocalizedString(message, comment: "Error")
        }
    }
}

// This class is used to handle API call to server.
class APIClient {
    // Sends API call. If there is error from server, it parses it.
    static func sendRequest<T: Decodable>(router: APIRouter, type: T.Type,  completion: @escaping (T?, Error?) -> Void) {
        // Get urlRequest object from APIRouter
        guard let urlRequest = router.asURLRequest() else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in

            if let error = error {
                //Send error in completion block
                completion(nil, error)
            } else {
                let response = urlResponse as! HTTPURLResponse
                // Print on console in debug mode
                if let data = data {
                    debugPrint(String(decoding: data, as: UTF8.self))
                }
                switch response.statusCode {
                case 200:  //OK response from server
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data!) as T
                        //Send data in completion block
                        completion(result, error)
                    } catch {
                        
                    }
                default: // Error in response
                    if let data = data {
                        // Parse the data custom error message from server
                        do {
                            let result = try JSONDecoder().decode(ErrorResponse.self, from: data) as ErrorResponse
                            completion(nil, APIError.customError(message: result.status_message))
                        } catch {
                            // Send error in completion block (parsing failded)
                            completion(nil, APIError.customError(message: "Parsing failed."))
                        }
                    } else {
                        completion(nil, APIError.customError(message: "No data from server."))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
