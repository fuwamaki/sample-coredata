//
//  FruitListTableCell.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/20.
//

import UIKit

final class FruitListTableCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal func render(_ entity: FruitEntity) {
        titleLabel.text = entity.name
    }
}

// MARK: NibLoadable
extension FruitListTableCell: NibLoadable {}
