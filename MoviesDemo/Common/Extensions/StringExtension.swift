//
//  StringExtension.swift
//  MoviesDemo
//
//  Created by Anis ur Rehman on 2/12/20.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation

extension String {
    //Converts the string to URL
    public func asURL() -> URL? {
        guard let url = URL(string: self) else { return  nil  }

        return url
    }
}
