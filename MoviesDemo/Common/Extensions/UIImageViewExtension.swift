//
//  UIImageViewExtension.swift
//  MoviesDemo
//
//  Created by Anis Rehman on 13/02/2020.
//  Copyright © 2020 Anis ur Rehman. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    // ImageView lazy loading
    func setImage(from urlString: String) {
        let url = URL(string: urlString)
        guard let imageURL = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
