//
//  Utils.swift
//  RXTableView
//
//  Created by Sonic on 14/7/23.
//

import UIKit

class Utils {
    static func displaySimpleAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController.present(alert, animated: true)
    }
}
