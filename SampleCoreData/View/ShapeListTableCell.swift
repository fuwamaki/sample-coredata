//
//  ShapeListTableCell.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//

import UIKit

final class ShapeListTableCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal func render(_ entity: ShapeEntity) {
        titleLabel.text = entity.name
    }
}

// MARK: NibLoadable
extension ShapeListTableCell: NibLoadable {}
