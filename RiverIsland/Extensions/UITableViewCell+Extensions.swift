//
//  UITableViewCell+Extensions.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 05/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

extension UITableViewCell {

    func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
}
