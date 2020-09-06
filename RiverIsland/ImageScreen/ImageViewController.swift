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

    let selectedImage: UIImage
 
    private let imageView: UIImageView =  {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let backBarButton = UIBarButtonItem(title: "",
                                            style: .plain,
                                            target: self,
                                            action: #selector(backButtonTapped))
        backBarButton.image = UIImage(named: "arrow")
        navigationItem.leftBarButtonItem = backBarButton
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.image = selectedImage
    }

    init(image: UIImage) {
        self.selectedImage = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillDisappear(_ animated: Bool) {
        imageView.fadeOut(0.2)
    }

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
