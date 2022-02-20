//
//  FruitListViewController.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit

final class FruitListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerForCell(FruitListTableCell.self)
        }
    }

    private var list: [FruitEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        list = CoreDataRepository().array(String(describing: FruitEntity.self)) as! [FruitEntity]
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension FruitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FruitListTableCell.defaultReuseIdentifier,
            for: indexPath
        ) as! FruitListTableCell
        cell.render(list[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension FruitListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
