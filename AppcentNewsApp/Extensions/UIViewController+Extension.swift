//
//  UIViewController+Extension.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 16.03.2021.
//

import Foundation
import UIKit

extension UIViewController : UIGestureRecognizerDelegate {

    func setCustomBackButton(withNav nav: UINavigationItem,
                             withImage imageName: String,
                             actionSelector: Selector?,
                             buttonWidth: CGFloat,
                             buttonHeight: CGFloat) {
        let barbuttonItem = UIBarButtonItem.backBarButtonItem(withTintColor: UIColor.black, target: self, action: actionSelector ?? #selector(self.popVC))
        nav.leftBarButtonItem = barbuttonItem
    }

    @objc func popVC() {
        if self.isModal(){
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        self.navigationController?.popViewController(animated: true)
    }

    func isModal() -> Bool{
        if (self.presentingViewController != nil){
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController{
            return true
        }
        if self.tabBarController?.presentingViewController is UITabBarController{
            return true
        }
        return false
    }

    @objc func backAction(_ sender: UIButton) {
        let notificationName = Notification.Name("backButtonTouched")
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        if self.isModal() {
            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        NotificationCenter.default.post(name: notificationName, object: nil)
    }

    func showAlertView(withTitle title: String?, andMessage message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertView.addAction(closeAction)
        present(alertView, animated: true, completion: nil)
    }
}
