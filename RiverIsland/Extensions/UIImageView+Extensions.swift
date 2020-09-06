//
//  UIImageView+Extensions.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 06/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
