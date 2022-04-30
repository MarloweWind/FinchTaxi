//
//  Extension + UiViewController.swift
//  FINCHTAXI
//
//  Created by Marlowe Wind on 10.03.2022.
//

import UIKit

extension UIViewController {

    func presentAlert(title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)

        self.present(alertController, animated: true)
    }

}
