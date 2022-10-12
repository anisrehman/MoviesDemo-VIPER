//
//  DependencyContainer.swift
//  MoviesDemo
//
//  Created by Anis Rehman on 09/10/2022.
//  Copyright © 2022 Anis ur Rehman. All rights reserved.
//

import Foundation

protocol DependencyContaining {
    func register<T>(type: T.Type, value: T, overwrite: Bool)
    func get<T>(_ type: T.Type) -> T?
}

class DependencyContainer: DependencyContaining {
    private static var dependencyContainer  = DependencyContainer();
    var container: [String: Any]

    static var shared: DependencyContainer {
        get {
            return dependencyContainer
        }
    }

    private init() {
        container = [:]
    }

    func register<T>(type: T.Type, value: T, overwrite: Bool) {
        let key = "\(type)"
        if container[key] == nil {
            container[key] = value
        } else if overwrite {
            container[key] = value
        }
    }

    func get<T>(_ type: T.Type) -> T? {
        let key = "\(T.self)"
        return container[key] as? T
    }
}
