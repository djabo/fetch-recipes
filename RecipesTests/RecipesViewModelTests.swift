//
//  RecipesViewModelTests.swift
//  Recipes
//

import XCTest
@testable import Recipes

@MainActor
final class RecipeViewModelTests: XCTestCase {
    var source: MockRecipeDataSource!
    var viewModel: RecipesViewModel!

    override func setUp() {
        super.setUp()

        source =  MockRecipeDataSource()
        viewModel = RecipesViewModel(source: source)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        source = nil
    }

    func testFilter() async throws {
        let recipes = [
            Recipe(id: UUID(), name: "Test 1", cuisine: "American", photo: nil, icon: nil, source: nil, video: nil),
            Recipe(id: UUID(), name: "Test 2", cuisine: "American", photo: nil, icon: nil, source: nil, video: nil),
        ]
        source.result = .success(recipes)
        try await viewModel.refresh()

        XCTAssertEqual(recipes, viewModel.recipes())
        XCTAssertEqual(recipes, viewModel.recipes(filter: "tes"))
        XCTAssertEqual(Array(recipes.prefix(1)), viewModel.recipes(filter: "1"))
        XCTAssertEqual(Array(recipes.suffix(1)), viewModel.recipes(filter: "2"))
    }

    func testRefresh() async throws {
        do {
            source.result = .failure(NSError())
            try await viewModel.refresh()
            XCTFail("expected error to be thrown")
        } catch {
            XCTAssert(viewModel.recipes().isEmpty)
        }

        source.result = .success([Recipe(id: UUID(), name: "Test 1", cuisine: "American", photo: nil, icon: nil, source: nil, video: nil)])
        try await viewModel.refresh()
        XCTAssertFalse(viewModel.recipes().isEmpty)
    }
}
