//
//  ProductModel.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 04/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation
import UIKit

class ProductModel {
    var name: String
    var price: String
    var image: UIImage

    init(name: String, price: String, image: UIImage) {
        self.name = name
        self.price = price
        self.image = image
    }
}


