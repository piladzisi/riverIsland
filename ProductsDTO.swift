//
//  ProductsData.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 04/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation

// Data Transfer Object

struct ProductsDTO: Decodable {
    let Products: [ProductDTO]
}

struct ProductDTO: Decodable {
    let name: String
    let cost: String
    let prodid: String
    let isNewArrival: Bool
    let isTrending: Bool
    let category: String
}
