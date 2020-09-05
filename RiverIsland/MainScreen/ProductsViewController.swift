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
    var products = [Product]()
    var productModels = [ProductModel]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setNavigationBar()
        fetchData()
    }


    private func fetchData() {
        let productsUrl = "https://static-ri.ristack-3.nn4maws.net/v1/plp/en_gb/2506/products.json"

        NetworkManager.shared.fetchGenericJSONData(urlString: productsUrl) { (result: ProductsData?, error) in
            if let error = error {
                print("Failed to load data:", error)
                return
            }
            self.products = result?.Products ?? []
            DispatchQueue.main.async {
                self.createProductModels()
                self.tableView.reloadData()
            }
        }
    }

    private func createProductModels() {
       productModels = ProductModelCreator.createProductModels(products: products)
    }

    private func setNavigationBar() {
        navigationItem.title = Constants.Strings.products
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "HelveticaNeue", size: 16),
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

    var isPaginating = false
    var isDonePaginating = false

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.cellReuseIdentifier) as? ProductCell else {
                return UITableViewCell()
        }
        if indexPath.row == 0 {
            DispatchQueue.main.async {
            cell.removeSectionSeparators()
            }
        }

        let productCellModel = productModels[indexPath.row]
        cell.displayInfo(of: productCellModel)

        // initiate pagination
        if indexPath.item == productModels.count - 1 && !isPaginating {
            print("fetch more data")

            isPaginating = true
//
//            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
//            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: ProductsData?, err) in
//
//                if let err = err {
//                    print("Failed to paginate data:", err)
//                    return
//                }
//
//                if searchResult?.results.count == 0 {
//                    self.isDonePaginating = true
//                }
//
//                sleep(2)
//
//                self.results += searchResult?.results ?? []
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                self.isPaginating = false
           // }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.cellReuseIdentifier) as? ProductCell else { return }
        let destinationViewController = ImageViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
    }

    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        //if such cell exists and destination controller (the one to show) exists too..
    //        if let subjectCell = tableView.cellForRowAtIndexPath(indexPath as IndexPath),
    //            let destinationViewController = ImageViewController()
    //            if let text = subjectCell.textLabel?.text {
    //                destinationViewController.textToShow = text
    //            } else {
    //                destinationViewController.textToShow = "Tapped Cell's textLabel is empty"
    //            }
    //            //Then just push the controller into the view hierarchy
    //            navigationController?.pushViewController(destinationViewController, animated: true)
    //        }
    //    }
}

