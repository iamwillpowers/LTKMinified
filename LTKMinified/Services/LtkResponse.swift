//
//  LtksModel.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import UIKit

// Decouple the response from the data model, using the repository pattern
// this allows us to quickly pivot in-app logic if a change occurs on the backend
struct LtkResponse: Decodable {
    let ltks: [Ltk]
    let profiles: [Profile]
    let meta: Meta
    let products: [Product]
    let mediaObjects: [MediaObject]

    init(from data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode(Self.self, from: data)
    }
}

// MARK: - Ltk
struct Ltk: Decodable {
    let heroImage: String
    let heroImageWidth: Int
    let heroImageHeight: Int
    let id: String
    let profileId: String
    let profileUserId: String
    let videoMediaId: String?
    let status: String
    let caption: String
    let shareUrl: String
    let dateCreated: Date
    let dateUpdated: Date
    let dateScheduled: Date?
    let datePublished: Date
    let productIds: [String]
    let hash: String
    let title: String?
}

// MARK: - MediaObject
struct MediaObject: Decodable {
    let id: String
    let type: String
    let state: String
    let createdAt: String
    let updatedAt: String
    let mediaCdnUrl: String
    let brandedMediaCdnUrl: String
    let passthroughMediaCdnUrl: String
    let typeProperties: TypeProperties
    let thumbnailIds: [String]?
}

// MARK: - TypeProperties
struct TypeProperties: Decodable {
    let mimeType: String
    let width: Int
    let height: Int
    let hasAudioChannel: Bool
}

// MARK: - Meta
struct Meta: Decodable {
    let lastId: String
    let numResults: Int
    let totalResults: Int
    let limit: Int
    let seed: String
    let nextUrl: String
}

// MARK: - Product
struct Product: Decodable {
    let id: String
    let ltkId: String
    let hyperlink: String
    let imageUrl: String
    let links: Links
    let matching: String
    let productDetailsId: String
}

// MARK: - Links
struct Links: Decodable {
    let androidConsumerApp: String
    let androidConsumerAppSs: String
    let iosConsumerApp: String
    let iosConsumerAppSs: String
    let ltkEmail: String
    let ltkWeb: String
    let ltkWidget: String
    let tailoredEmail: String
}

// MARK: - Profile
struct Profile: Decodable {
    let id: String
    let avatarUrl: String
    let avatarUploadUrl: String?
    let displayName: String
    let fullName: String
    let instagramName: String
    let blogName: String
    let blogUrl: String
    let bgImageUrl: String
    let bgUploadUrl: String?
    let bio: String
    let rsAccountId: Int
    let searchable: Bool
}
