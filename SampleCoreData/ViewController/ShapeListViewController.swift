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
                .sink(receiveValue: tableView.items { [unowned self] tableView, indexPath, item in
                    switch indexPath.row {
                    case self.listSubject.value.count-1:
                        return tableView.dequeueReusableCell(
                            withIdentifier: PlusTableCell.defaultReuseIdentifier,
                            for: indexPath
                        ) as! PlusTableCell
                    default:
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: ShapeListTableCell.defaultReuseIdentifier,
                            for: indexPath
                        ) as! ShapeListTableCell
                        cell.render(item)
                        return cell
                    }
                })
                .store(in: &subscriptions)

            tableView.didSelectRowPublisher
                .sink { [unowned self] indexPath in
                    tableView.deselectRow(at: indexPath, animated: true)
                    switch indexPath.row {
                    case self.listSubject.value.count-1:
                        present(UIAlertController.textFieldAlert(
                            title: "Add",
                            actionText: "Create"
                        ) { text in
                            if let text = text, !text.isEmpty {
                                CoreDataRepository.add(ShapeEntity.new(shapeName: text))
                            }
                        }, animated: true)
                    default:
                        present(UIAlertController.textFieldAlert(
                            title: "Edit",
                            actionText: "Update",
                            textFieldText: self.listSubject.value[indexPath.row].name
                        ) { text in
                            if let text = text, !text.isEmpty {
                                self.listSubject.value[indexPath.row].update(newName: text)
                            }
                        }, animated: true)
                    }
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
        let publisher: CoreDataPublisher<ShapeEntity> = CoreDataRepository.coreDataPublisher()
        publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] entities in
                self?.listSubject.send(entities + [ShapeEntity.empty])
            })
            .store(in: &subscriptions)
    }
}
