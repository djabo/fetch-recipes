//
//  Recipe.swift
//  Recipes
//

import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    /// The unique identifier for the receipe. Represented as a UUID.
    let id: UUID
    /// The name of the recipe.
    let name: String
    /// The cuisine of the recipe.
    let cuisine: String
    /// The URL of the recipes’s full-size photo.
    let photo: URL?
    /// The URL of the recipes’s small photo. Useful for list view.
    let icon: URL?
    /// The URL of the recipe's original website.
    let source: URL?
    /// The URL of the recipe's YouTube video.
    let video: URL?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photo = "photo_url_large"
        case icon = "photo_url_small"
        case source = "source_url"
        case video = "youtube_url"
    }
}
