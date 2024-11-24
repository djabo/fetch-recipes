//
//  RecipeDataSource.swift
//  Fetch Recipes
//

import Foundation

protocol RecipeDataSource {
    func fetch() async throws -> [Recipe]
}

/// Recipe source that retrieves the recipes from an API
class RecipeAPIDataSource: RecipeDataSource {
    /// Container for Recipes. Used to decode the message from the server.
    private struct RecipeContainer: Decodable {
        let recipes: [Recipe]
    }

    let url: URL
    let session: URLSession

    init(url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    func fetch() async throws -> [Recipe] {
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(RecipeContainer.self, from: data).recipes
    }
}
