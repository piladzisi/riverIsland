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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }


    func displayInfo(of model: ProductModel) {
        self.cellImageView.image = model.image
        self.nameLabel.text = model.name
        if let currency = getSymbol(forCurrencyCode: "GBP") {
            self.priceLabel.text = "\(currency)\(model.price)"
        } else {
            self.priceLabel.text = model.price
        }

        self.trendingLabel.text = "trending".uppercased()
    }
    
}
