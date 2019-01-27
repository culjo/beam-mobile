//
//  UIViewControllerExt.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, positiveBtn: String = "OK", negativeBtn: String = "Cancel", onPositiveClick: @escaping ()->Void, onNegativeClick: (()->Void)? = nil ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: positiveBtn, style: .default, handler: {(action) in
            onPositiveClick()
        })
        alertController.addAction(action)
        
        if let onNegClick = onNegativeClick {
            let negativeAction = UIAlertAction(title: negativeBtn, style: .cancel) { (action) in
                onNegClick()
            }
            alertController.addAction(negativeAction)
        }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        //UINotificationFeedbackGenerator().notificationOccurred(.warning)
        present(alertController, animated: true, completion: nil)
        
    }
}

extension UIViewController {
    // let hud = JGProgressHUD(style: .dark)
    
    func showLoading(hud: JGProgressHUD) {
        hud.show(in: self.view)
    }
    
    func dismissLoading(hud: JGProgressHUD) {
        hud.dismiss(animated: true)
    }
    
    
    func hapticError() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    func hapticSuccess() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    
    
}
