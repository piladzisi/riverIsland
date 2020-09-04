//
//  ProductsData.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 04/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation

struct ProductsData: Decodable {
    let Products: [Product]
}

struct Product: Decodable {
    let name: String
    let cost: String
    let altImage: String
}
