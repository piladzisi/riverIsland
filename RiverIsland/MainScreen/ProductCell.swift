//
//  MainViewCell.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 31/08/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    static let identifier = "ProductCell"
    let cache = NetworkManager.shared.cache
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var cellBanner: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }

    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }

    func configure() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 20, right: 0))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trendingLabel.isHidden = false
        cellBanner.isHidden = false
    }

    func displayInfo(of model: ProductModel, prodid: String) {
        let modelUrl = "\(model.url)\(prodid)_main"
        let cacheKey = NSString(string: modelUrl)
        
        if let image = cache.object(forKey: cacheKey) {
            cellImageView.image = image
        } else {
            downloadImage(from: modelUrl, cacheKey: cacheKey)
        }

        nameLabel.text = model.name
        
        if let currency = getSymbol(forCurrencyCode: "GBP") {
            priceLabel.text = "\(currency)\(model.price)"
        } else {
            priceLabel.text = model.price
        }
    }

    func downloadImage(from urlString: String, cacheKey: NSString) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if error != nil { return }

            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async {
                self.cellImageView.image = image
            }
        }
        task.resume()
    }

    func checkIfTrending(product: ProductModel) {

        if product.isTrending {
            trendingLabel.text = "trending".uppercased()
            trendingLabel.backgroundColor = .black
            trendingLabel.textColor = .white
            trendingLabel.textAlignment = .center
        } else if product.category == "Tops" {
            trendingLabel.text = "sale".uppercased()
            trendingLabel.backgroundColor = .white
            trendingLabel.textColor = .red
            trendingLabel.textAlignment = .left
        } else {
            trendingLabel.isHidden = true
            cellBanner.isHidden = true
        }
    }
}


