//
//  ImageViewController.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 01/09/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
    super.viewDidLoad()
        view.backgroundColor = .white
        let backBarButton = UIBarButtonItem(title: "",
                                            style: .plain,
                                            target: self,
                                            action: #selector(backButtonTapped))
        backBarButton.image = UIImage(named: "arrow")
        navigationItem.leftBarButtonItem = backBarButton
    }

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    //https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json
}
