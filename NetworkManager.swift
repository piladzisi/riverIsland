//
//  NetworkManager.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 04/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
    func didFetchData(products: ProductsData)
}

struct NetworkManager {
    let mainURL = "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json"

    var delegate: NetworkManagerDelegate?

    func fetchProducts() {
        let urlString = mainURL
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                if let safeData = data {
                    if let products = self.parseJSON(products: safeData) {
                        self.delegate?.didFetchData(products: products)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(products: Data) -> ProductsData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductsData.self, from: products)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
