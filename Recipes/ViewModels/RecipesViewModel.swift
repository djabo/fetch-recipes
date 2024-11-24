//
//  RecipesViewModel.swift
//  Recipes
//

import Combine
import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published private var recipes: [Recipe] = []
    let source: RecipeDataSource

    init(source: RecipeDataSource = RecipeAPIDataSource(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!)) {
        self.source = source
    }

    func recipes(filter: String? = nil) -> [Recipe] {
        if let filter, !filter.isEmpty {
            return recipes.filter {
                $0.name.uppercased().contains(filter.uppercased()) || $0.cuisine.uppercased().contains(filter.uppercased())
            }
        } else {
            return recipes
        }
    }

    func refresh() async throws {
        recipes = try await source.fetch()
    }
}
