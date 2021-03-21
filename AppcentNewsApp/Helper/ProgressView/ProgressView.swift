//
//  ProgressView.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 16.03.2021.
//

import Foundation
import UIKit
import MBProgressHUD

class ProgressView: MBProgressHUD {

    private static var sharedView: ProgressView!

    @discardableResult
    func mode(mode: MBProgressHUDMode) -> ProgressView {
        self.mode = mode
        return self
    }

    @discardableResult
    func animationType(animationType: MBProgressHUDAnimation) -> ProgressView {
        self.animationType = animationType
        return self
    }

    @discardableResult
    func backgroundViewStyle(style: MBProgressHUDBackgroundStyle) -> ProgressView {
        self.backgroundView.style = style
        return self
    }
    
    @discardableResult
    class func present(animated: Bool) -> ProgressView {
        if sharedView != nil {
            sharedView.hide(animated: false)
        }
        if let view = UIApplication.shared.keyWindow {
            sharedView = ProgressView.showAdded(to: view, animated: true)
        }
        return sharedView
    }

    class func dismiss(animated: Bool) {
        if sharedView != nil {
            sharedView.hide(animated: true)
        }
    }
}
