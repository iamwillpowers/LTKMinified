//
//  UIView+NSLayoutConstraint.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit

extension UIView {
    func constrainWidthAndHeight(_ width: CGFloat, _ height: CGFloat) {
        addConstraints([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
