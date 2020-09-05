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

//    var products: [Product]
//
//    init(products: [Product]) {
//        self.products = products
//    }

    static func createProductModels(products: [Product]) -> [ProductModel] {
        var productModels = [ProductModel]()
        let products = products
        for product in products {
//            let imageUrl = "https://riverisland.scene7.com/is/image/RiverIsland/\(product.prodid)_main"
//            var productImage = UIImage()
//            if let url = URL(string: imageUrl) {
//                guard let data = try? Data(contentsOf: url) else { continue }
//                productImage = UIImage(data: data) ?? UIImage(named: "woman") as! UIImage
//            } else {
//                print("image URL is not available")
//            }
            let productImage = UIImage(named: "woman")!
            let model = ProductModel(name: product.name, price: product.cost, image: productImage)
            productModels.append(model)
        }

        return productModels
    }
}
