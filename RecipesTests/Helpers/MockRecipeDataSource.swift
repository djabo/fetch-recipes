//
//  MockRecipeDataSource.swift
//  Recipes
//

@testable import Recipes

class MockRecipeDataSource: RecipeDataSource {
    var result: Result<[Recipe], Error> = .success([])
    var fetchWasCalled = false

    func fetch() async throws -> [Recipes.Recipe] {
        fetchWasCalled = true
        return try result.get()
    }
}
