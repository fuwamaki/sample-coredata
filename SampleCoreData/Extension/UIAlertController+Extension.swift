//
//  UIAlertController+Extension.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/22.
//

import UIKit

extension UIAlertController {
    class func textFieldAlert(
        title: String,
        actionText: String,
        textFieldText: String? = nil,
        completion: ((String?) -> Void)? = nil
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = textFieldText
        }
        alert.addAction(UIAlertAction(title: actionText, style: .default, handler: { _ in
            if let completion = completion {
                completion(alert.textFields?.first?.text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }
}
