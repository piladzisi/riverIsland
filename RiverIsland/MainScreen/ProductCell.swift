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
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var cellBanner: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }

    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }

    func configure() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 5, bottom: 20, right: 0))
    }

    func displayInfo(of model: ProductModel, prodid: String) {
        let modelUrl = "\(model.url)\(prodid)_main"
        cellImageView.downloadImage(from: modelUrl)
        nameLabel.text = model.name
        
        if let currency = getSymbol(forCurrencyCode: "GBP") {
            priceLabel.text = "\(currency)\(model.price)"
        } else {
           priceLabel.text = model.price
        }

        checkIfTrending()
    }

    func checkIfTrending() {
        let randomInt = Int.random(in: 1..<5)
        if randomInt == 4 {
            trendingLabel.text = "sale".uppercased()
            trendingLabel.backgroundColor = .white
            trendingLabel.textColor = .red
            trendingLabel.textAlignment = .left
        } else if  randomInt % 2 == 0 {
            trendingLabel.isHidden = true
            cellBanner.isHidden = true
        } else {
            trendingLabel.text = "trending".uppercased()
            trendingLabel.backgroundColor = .black
            trendingLabel.textColor = .white
            trendingLabel.textAlignment = .center
        }
    }
}


