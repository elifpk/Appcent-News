//
//  View+Extension.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 16.03.2021.
//

import Foundation
import UIKit

extension UIView {

    func shadowPath(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.4
        }

    func createGradientLayer() {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [UIColor(red: 0 / 255.0, green: 128 / 255.0, blue: 198 / 255.0, alpha: 1.0).cgColor, UIColor(red: 0 / 255.0, green: 84 / 255.0, blue: 147 / 255.0, alpha: 1.0).cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
