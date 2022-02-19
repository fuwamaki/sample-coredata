//
//  MainTableCell.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit

final class MainTableCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal func render(_ text: String) {
        titleLabel.text = text
    }
}

// MARK: NibLoadable
extension MainTableCell: NibLoadable {}
