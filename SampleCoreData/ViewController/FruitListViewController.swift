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
            tableView.registerForCell(PlusTableCell.self)
        }
    }

    private var list: [FruitEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    private func reload() {
        list = CoreDataRepository.array(String(describing: FruitEntity.self)) as! [FruitEntity]
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension FruitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case list.count:
            return tableView.dequeueReusableCell(
                withIdentifier: PlusTableCell.defaultReuseIdentifier,
                for: indexPath
            ) as! PlusTableCell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FruitListTableCell.defaultReuseIdentifier,
                for: indexPath
            ) as! FruitListTableCell
            cell.render(list[indexPath.row])
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension FruitListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case list.count:
            let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.delegate = self
            }
            alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
                if let text = alert.textFields?.first?.text, !text.isEmpty {
                    let newItem = CoreDataRepository.create(fruitName: text)
                    CoreDataRepository.add(newItem)
                    self.reload()
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        default:
            let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.delegate = self
                textField.text = self.list[indexPath.row].name
            }
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
                if let text = alert.textFields?.first?.text, !text.isEmpty {
                    CoreDataRepository.update(entity: self.list[indexPath.row], newName: text)
                    self.reload()
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataRepository.delete(list[indexPath.row])
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: UITextFieldDelegate
extension FruitListViewController: UITextFieldDelegate {}
