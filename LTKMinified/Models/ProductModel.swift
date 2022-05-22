//
//  ProductModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit

struct ProductModel: Hashable {
    let id: String
    let ltkId: String
    let hyperlink: String
    let imageUrl: String
    var image: UIImage?

    init(with product: Product) {
        self.id = product.id
        self.ltkId = product.ltkId
        self.hyperlink = product.hyperlink
        self.imageUrl = product.imageUrl
    }
}
