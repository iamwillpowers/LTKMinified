//
//  LtksModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import IGListKit

final class LtkModel: ListDiffable {
    let heroImage: String
    let heroImageSize: CGSize
    let id: String
    let profileId: String
    let profileUserId: String
    let videoMediaId: String?
    let status: String
    let caption: String
    let shareUrl: String
    let productIds: [String]
    let title: String?

    init(from ltk: Ltk) {
        heroImage = ltk.heroImage
        heroImageSize = CGSize(width: ltk.heroImageWidth, height: ltk.heroImageHeight)
        id = ltk.id
        profileId = ltk.profileId
        profileUserId = ltk.profileUserId
        videoMediaId = ltk.videoMediaId
        status = ltk.status
        caption = ltk.caption
        shareUrl = ltk.shareUrl
        productIds = ltk.productIds
        title = ltk.title
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let ltk = object as? LtkModel else { return true }
        return heroImage == ltk.heroImage && caption == ltk.caption && title == ltk.title
    }
}
