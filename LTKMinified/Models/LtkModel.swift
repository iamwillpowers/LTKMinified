//
//  LtksModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import IGListKit

/// This is the primary data model for the app, used on both the main screen and the details view.
/// Everything pertaining to the initial hero image on the main feed, including relevant products and
/// user profile are woven together in this class.
final class LtkModel: ListDiffable {
    let heroImageUrl: String
    let heroImageSize: CGSize
    let id: String
    let profileId: String
    let caption: String
    let products: [ProductModel]
    let avatarUrl: String
    let displayName: String
    var heroImage: UIImage?
    var avatar: UIImage?

    init(from ltk: Ltk, profile: Profile, products: [Product]) {
        self.heroImageUrl = ltk.heroImage
        self.heroImageSize = CGSize(width: ltk.heroImageWidth, height: ltk.heroImageHeight)
        self.id = ltk.id
        self.profileId = ltk.profileId
        self.caption = ltk.caption
        self.products = products.map { ProductModel(with: $0) }
        self.avatarUrl = profile.avatarUrl
        self.displayName = profile.displayName
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let ltk = object as? LtkModel else { return true }
        return heroImageUrl == ltk.heroImageUrl && caption == ltk.caption
    }
}
