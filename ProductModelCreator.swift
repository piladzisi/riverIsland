//
//  ProductModelCreator.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 05/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation
import UIKit

class ProductModelCreator {

    static func createProductModels(products: [ProductDTO]) -> [Product] {
        var productModels = [Product]()
        let products = products
        for product in products {
            let model = Product(name: product.name,
                                     price: product.cost,
                                     isNewArrival: product.isNewArrival,
                                     isTrending: product.isTrending,
                                     category: product.category)
            productModels.append(model)
        }

        return productModels
    }
}
