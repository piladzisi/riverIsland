//
//  IUButton+Extensions.swift
//  MvtxKit
//
//  Created by Anna Sibirtseva on 29/02/2020.
//  Copyright © 2020 Roche. All rights reserved.
//

import UIKit

extension UIButton {
    func roundCorners() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
