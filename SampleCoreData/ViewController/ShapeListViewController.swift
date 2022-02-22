//
//  ShapeListViewController.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//

import UIKit

final class ShapeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.registerForCell(FruitListTableCell.self)
            tableView.registerForCell(PlusTableCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ShapeListViewController: UITableViewDelegate {}
