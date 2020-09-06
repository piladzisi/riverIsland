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
    var url = "https://riverisland.scene7.com/is/image/RiverIsland/"
    var isNewArrival: Bool
    var isTrending: Bool
    var category: String

    init(name: String, price: String, isNewArrival: Bool, isTrending: Bool, category: String) {
        self.name = name
        self.price = price
        self.isNewArrival = isNewArrival
        self.isTrending = isTrending
        self.category = category
    }
}


