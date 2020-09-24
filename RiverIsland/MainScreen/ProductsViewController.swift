//
//  MainViewController.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 31/08/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController{

    private static let cellNib = ProductCell.identifier
    private static let cellReuseIdentifier = "productCellReuseIdentifier"
    var products = [ProductDTO]()
    var productModels = [Product]()
    var buttonDescending = false

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortingLabel: UILabel!
    @IBOutlet weak var sortingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        setNavigationBar()
        fetchData()
    }

    private func fetchData() {
        let productsUrl = "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json"
        NetworkManager.shared.fetchGenericJSONData(urlString: productsUrl) { (result: ProductsDTO?, error) in

            if let error = error {
                fatalError("Failed to load data: \(error)")
            }

            self.products = result?.Products ?? []
            DispatchQueue.main.async {
                self.createProductModels()
                self.tableView.reloadData()
            }
        }
    }

    func setupUI() {
        sortingButton.setBackgroundImage(UIImage(systemName: "arrow.up"), for: .normal)
        sortingLabel.text = "Sort by price:"
        sortingButton.titleLabel?.tintColor = .black
    }

    private func createProductModels() {
        productModels = ProductModelCreator.createProductModels(products: products)
    }

    private func setNavigationBar() {
        navigationItem.title = Constants.Strings.products
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16.0),
        ]
        let backBarButton = UIBarButtonItem(title: "",
                                            style: .plain,
                                            target: self,
                                            action: #selector(backButtonTapped))
        backBarButton.image = UIImage(named: "arrow")
        navigationItem.leftBarButtonItem = backBarButton
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: Self.cellNib, bundle: .main),
                           forCellReuseIdentifier: Self.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }

    @IBAction func sortButtonClicked(_ sender: UIButton) {

        if buttonDescending {
            sender.setBackgroundImage(UIImage(systemName: "arrow.down"), for: .normal)
            productModels.sort {
                $0.price > $1.price
            }
            products.sort {
                $0.cost > $1.cost
            }
            tableView.reloadData()
        } else {
            sender.setBackgroundImage(UIImage(systemName: "arrow.up"), for: .normal)
            productModels.sort {
                $0.price < $1.price
            }
            products.sort {
                $0.cost < $1.cost
            }
            tableView.reloadData()
        }
        buttonDescending = !buttonDescending
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UITableViewDataSource

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.cellReuseIdentifier) as? ProductCell else {
                return UITableViewCell()
        }

        let productCellModel = productModels[indexPath.row]

        cell.displayInfo(of: productCellModel, prodid: products[indexPath.row].prodid)
        cell.checkIfTrending(product: productCellModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(
            at: indexPath) as? ProductCell else { return }
        if let image = cell.cellImageView.image {
            let destinationViewController = ImageViewController(image: image)
            navigationController?.pushViewController(destinationViewController, animated: true)
        } else {
            let destinationViewController = ImageViewController(image: UIImage(named: "logo")!)
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
}

