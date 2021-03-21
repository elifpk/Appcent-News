//
//  UIBarButtonItem+Extension.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 16.03.2021.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    static func backBarButtonItem(withTintColor tint: UIColor, target: Any?, action: Selector?) -> UIBarButtonItem {
        let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "customBackButton"), style: .plain, target: target, action: action)
        menuItem.tintColor = tint
        return menuItem
    }
}
