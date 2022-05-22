//
//  CGSize+Aspect.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import CoreGraphics

extension CGSize {
    func aspect() -> CGFloat {
        // prevent division by zero
        guard height != 0.0 else { return 0.0 }
        return width / height
    }
}
