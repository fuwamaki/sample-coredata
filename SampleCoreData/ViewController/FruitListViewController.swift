//
//  FruitListViewController.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit

final class FruitListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerForCell(FruitListTableCell.self)
            tableView.registerForCell(PlusTableCell.self)
        }
    }

    @IBAction private func clickRollbackButton(_ sender: UIBarButtonItem) {
        CoreDataRepository.rollback()
        reload()
    }

    @IBAction private func clickSaveButton(_ sender: UIBarButtonItem) {
        CoreDataRepository.save()
        reload()
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
            present(UIAlertController.textFieldAlert(
                title: "Add",
                actionText: "Create"
            ) { text in
                if let text = text, !text.isEmpty {
                    CoreDataRepository.add(FruitEntity.new(fruitName: text))
                    self.reload()
                }
            }, animated: true)
        default:
            present(UIAlertController.textFieldAlert(
                title: "Edit",
                actionText: "Update",
                textFieldText: self.list[indexPath.row].name
            ) { text in
                if let text = text, !text.isEmpty {
                    self.list[indexPath.row].update(newName: text)
                    self.reload()
                }
            }, animated: true)
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
