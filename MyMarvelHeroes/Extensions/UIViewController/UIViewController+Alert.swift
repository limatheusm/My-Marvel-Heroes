//
//  UIViewController+Alert.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 27/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showInfo(withTitle: String = "Info", withMessage: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
                action?()
            }))
            self.present(ac, animated: true)
        }
    }
    
    func displayError(_ error: String) {
        showInfo(withTitle: "Ops!", withMessage: error)
    }
}
