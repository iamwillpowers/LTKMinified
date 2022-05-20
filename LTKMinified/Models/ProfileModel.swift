//
//  ProfileModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import IGListKit

final class ProfileModel: ListDiffable {
    let id: String
    let avatarUrl: String
    let displayName: String
    let instagramName: String

    init(from profile: Profile) {
        self.id = profile.id
        self.avatarUrl = profile.avatarUrl
        self.displayName = profile.displayName
        self.instagramName = profile.instagramName
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let profile = object as? ProfileModel else { return true }
        return avatarUrl == profile.avatarUrl && displayName == profile.displayName && instagramName == profile.instagramName
    }
}
