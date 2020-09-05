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

    func fetchProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        fetchGenericJSONData(urlString: baseURL, completion: completion)
    }

//    func fetchImages(prodid: String, completion: @escaping ([UIImage]?, Error?) -> ()) {
//        let imageUrl = "https://riverisland.scene7.com/is/image/RiverIsland/\(prodid)_main"
//        var productImage = UIImage()
//        if let url = URL(string: imageUrl) {
//            guard let data = try? Data(contentsOf: url) else { return }
//            productImage = UIImage(data: data) ?? UIImage(named: "woman")!
//        } else {
//            print("image URL is not available")
//        }
//    }

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

//
//struct NetworkManager {
//    let mainURL = "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json"
//
//    static let shared = NetworkManager()
//
//
//    func fetchProducts(completion: @escaping (ProductsData?, Error?) -> ()) {
//            fetchGenericJSONData(urlString: mainURL, completion: completion)
//    }
//
//    func performRequest(urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    if let products = self.parseJSON(products: safeData) {
//                        self.delegate?.didFetchData(productsData: products)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
//
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, resp, err) in
//            if let err = err {
//                completion(nil, err)
//                return
//            }
//            do {
//                let objects = try JSONDecoder().decode(T.self, from: data!)
//                // success
//                completion(objects, nil)
//            } catch {
//                completion(nil, error)
//            }
//        }.resume()
//    }
//
//
//    func parseJSON(products: Data) -> ProductsData? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(ProductsData.self, from: products)
//            return decodedData
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
