//
//  UIColor+Convenience.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
