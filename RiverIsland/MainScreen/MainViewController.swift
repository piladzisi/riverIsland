//
//  MainViewController.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 31/08/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private static let cellNib = MainViewCell.identifier
    private static let cellReuseIdentifier = "mainViewCellReuseIdentifier"

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

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.cellReuseIdentifier) as? MainViewCell else {
                return UITableViewCell()
        }

        //        let reviewCellModel = sections[indexPath.section][indexPath.row]
        //        cell.displayInfo(of: reviewCellModel)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }

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

