//
//  NetworkManager.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 04/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json"

    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func fetchProducts(completion: @escaping ([ProductDTO]?, Error?) -> ()) {
        fetchGenericJSONData(urlString: baseURL, completion: completion)
    }

    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
