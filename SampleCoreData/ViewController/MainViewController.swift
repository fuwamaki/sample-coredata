//
//  MainViewController.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerForCell(MainTableCell.self)
        }
    }

    private var list: [String] = ["Fruit", "CoreData2"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableCell.defaultReuseIdentifier,
            for: indexPath
        ) as! MainTableCell
        cell.render(list[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard(name: "FruitListViewController", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "FruitListViewController")
            navigationController?.pushViewController(viewController, animated: true)
        default:
            let storyBoard = UIStoryboard(name: "ShapeListViewController", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "ShapeListViewController")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
