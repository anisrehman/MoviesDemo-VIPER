//
//  APIConfiguration.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

// An http call may need method, path and parameters. APIConfiguration helps use to define all these under one entity
protocol APIConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: String]? { get }
    
    func asURLRequest() -> URLRequest?
}


enum APIRouter: APIConfiguration {
    //All APIs with parameters
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    //Endpont for each API call
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        case .upcoming:
            return "/upcoming"
        }
    }
    
    // Parameters for each API call
    var parameters: [String : String]? {
        switch self {
        case .popular(let page):
            return [Constants.APIParameter.apiKey: Constants.apiKey,
                    Constants.APIParameter.language: Constants.apiLanguage,
                    Constants.APIParameter.page: "\(page)"]
        case .topRated(let page):
            return [Constants.APIParameter.apiKey: Constants.apiKey,
                    Constants.APIParameter.language: Constants.apiLanguage,
                    Constants.APIParameter.page: "\(page)"]
        case .upcoming(let page):
            return [Constants.APIParameter.apiKey: Constants.apiKey,
                    Constants.APIParameter.language: Constants.apiLanguage,
                    Constants.APIParameter.page: "\(page)"]
        }
    }
    
    //Genrate URLReqeust object from path, method and paramters
    func asURLRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: Constants.apiBaseURL) else {
            return nil
        }
        // End point
        urlComponent.path.append(self.path)
        
        // Parameters
        let parameters = self.parameters ?? [:]
        switch self.method {
        case .get:
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            urlComponent.queryItems = queryItems
            guard let url = urlComponent.url else {
                return nil
            }
            
            debugPrint(url)
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            urlRequest.httpMethod = method.rawValue
            return urlRequest
        case .post:
            fatalError("Not implemented for POST")
        }
    }
}
