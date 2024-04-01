//
//  StrapiPictures.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 01/04/2024.
//

import Foundation

struct StrapiPictures: Identifiable, Decodable, Equatable, Hashable {
    struct Format: Decodable, Equatable, Hashable {
        let name: String
        let hash: String?
        let ext: String?
        let mime: String?
        let path: String?
        let width: Int
        let height: Int
        let size: Float
        let sizeInBytes: Int
        let url: String

        static func == (lhs: Format, rhs: Format) -> Bool {
            return lhs.name == rhs.name &&
                lhs.hash == rhs.hash &&
                lhs.ext == rhs.ext &&
                lhs.mime == rhs.mime &&
                lhs.path == rhs.path &&
                lhs.width == rhs.width &&
                lhs.height == rhs.height &&
                lhs.size == rhs.size &&
                lhs.sizeInBytes == rhs.sizeInBytes &&
                lhs.url == rhs.url
        }
    }

    struct Formats: Decodable, Equatable, Hashable {
        let thumbnail: Format?
        let small: Format?
        let medium: Format?
        let large: Format?

        enum CodingKeys: String, CodingKey {
            case thumbnail
            case small
            case medium
            case large
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            thumbnail = try container.decodeIfPresent(Format.self, forKey: .thumbnail)
            small = try container.decodeIfPresent(Format.self, forKey: .small)
            medium = try container.decodeIfPresent(Format.self, forKey: .medium)
            large = try container.decodeIfPresent(Format.self, forKey: .large)
        }

        static func == (lhs: Formats, rhs: Formats) -> Bool {
            return lhs.thumbnail == rhs.thumbnail &&
                lhs.small == rhs.small &&
                lhs.medium == rhs.medium &&
                lhs.large == rhs.large
        }
    }

    let id: Int
    let name: String
    let alternativeText: String?
    let caption: String?
    let width: Int
    let height: Int
    let formats: Formats
    let hash: String?
    let ext: String?
    let mime: String?
    let size: Float
    let url: String
    let previewUrl: String?
    let provider: String?
    let provider_metadata: String?
    let folderPath: String
    let createdAt: String
    let updatedAt: String

    static func == (lhs: StrapiPictures, rhs: StrapiPictures) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.alternativeText == rhs.alternativeText &&
            lhs.caption == rhs.caption &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.formats == rhs.formats &&
            lhs.hash == rhs.hash &&
            lhs.ext == rhs.ext &&
            lhs.mime == rhs.mime &&
            lhs.size == rhs.size &&
            lhs.url == rhs.url &&
            lhs.previewUrl == rhs.previewUrl &&
            lhs.provider == rhs.provider &&
            lhs.provider_metadata == rhs.provider_metadata &&
            lhs.folderPath == rhs.folderPath &&
            lhs.createdAt == rhs.createdAt &&
            lhs.updatedAt == rhs.updatedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(alternativeText)
        hasher.combine(caption)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(formats)
        hasher.combine(hash)
        hasher.combine(ext)
        hasher.combine(mime)
        hasher.combine(size)
        hasher.combine(url)
        hasher.combine(previewUrl)
        hasher.combine(provider)
        hasher.combine(provider_metadata)
        hasher.combine(folderPath)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
    }
}
