//
//  Extension + UINavigationController.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 15.02.2022.
//

import UIKit

extension UINavigationController {
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: {
            $0.isKind(of: controller.self)
        }){
            viewController.removeFromParent()
        }
    }
    
    func removeViewControllers(exception: UIViewController) {
        viewControllers.removeAll(where: {
            $0 != exception
        })
    }
    
}
