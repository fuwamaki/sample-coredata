//
//  ShapeListViewController.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//

import UIKit
import Combine
import CoreData
import CombineCocoa

final class ShapeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerForCell(ShapeListTableCell.self)
            tableView.registerForCell(PlusTableCell.self)

            listSubject
                .sink(receiveValue: tableView.items({ tableView, indexPath, item in
                    let cell = tableView.dequeueCellForIndexPath(indexPath) as ShapeListTableCell
                    cell.render(item)
                    return cell
                }))
                .store(in: &subscriptions)

            tableView.didSelectRowPublisher
                .sink { [unowned self] indexPath in
                    tableView.deselectRow(at: indexPath, animated: true)
                    let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
                    alert.addTextField { textField in
                        textField.text = self.listSubject.value[indexPath.row].name
                    }
                    alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
                        if let text = alert.textFields?.first?.text, !text.isEmpty {
                            self.listSubject.value[indexPath.row].update(newName: text)
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    self.present(alert, animated: true)
                }
                .store(in: &subscriptions)
        }
    }

    private(set) var listSubject = CurrentValueSubject<[ShapeEntity], Never>([])
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        CoreDataRepository.coreDataPublisher()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] entities in
                self?.listSubject.send(entities)
            })
            .store(in: &subscriptions)
    }
}
