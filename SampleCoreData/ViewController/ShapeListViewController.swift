//
//  ShapeListViewController.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//

import UIKit
import Combine
import CoreData

final class ShapeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.registerForCell(FruitListTableCell.self)
            tableView.registerForCell(PlusTableCell.self)
        }
    }

    private(set) var listSubject = CurrentValueSubject<[ShapeEntity], Never>([])
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataRepository.coreDataPublisher()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] entities in
                self?.listSubject.send(entities)
            })
            .store(in: &subscriptions)
    }
}

extension ShapeListViewController: UITableViewDelegate {}
