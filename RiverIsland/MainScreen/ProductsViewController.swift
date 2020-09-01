//
//  MainViewController.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 31/08/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    private static let cellNib = ProductCell.identifier
    private static let cellReuseIdentifier = "productCellReuseIdentifier"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupTableView()
    }

    private func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: Self.cellNib, bundle: .main),
                           forCellReuseIdentifier: Self.cellReuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: UITableViewDataSource

extension ProductsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.cellReuseIdentifier) as? ProductCell else {
                return UITableViewCell()
        }

        //        let reviewCellModel = sections[indexPath.section][indexPath.row]
        //        cell.displayInfo(of: reviewCellModel)
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

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // UIView with darkGray background for section-separators as Section Footer

        let grayLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        grayLineView.backgroundColor = .black
        return grayLineView
    }
}

