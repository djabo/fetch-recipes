//
//  RecipeDataSourceTests.swift
//  Recipes
//

import XCTest
@testable import Recipes

final class RecipeDataSourceTests: XCTestCase {
    private struct RecipeContainer: Encodable {
        let recipes: [Recipe]
    }

    var source: RecipeAPIDataSource!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockAPI.self]
        source = RecipeAPIDataSource(url: URL(string: "https://dne")!, session: URLSession(configuration: config))
    }

    override func tearDown() {
        super.tearDown()

        source = nil
        MockAPI.result = .failure(NSError(domain: "test", code: 0))
    }

    func testSuccessResponse() async throws {
        let recipes = [
            Recipe(id: UUID(), name: "Test 1", cuisine: "American", photo: nil, icon: nil, source: nil, video: nil),
            Recipe(id: UUID(), name: "Test 2", cuisine: "American", photo: nil, icon: nil, source: nil, video: nil),
            Recipe(id: UUID(), name: "Test 3", cuisine: "American", photo: nil, icon: nil, source: nil, video: nil),
            Recipe(id: UUID(), name: "Test 4", cuisine: "British", photo: nil, icon: nil, source: nil, video: nil),
        ]
        MockAPI.result = .success(try JSONEncoder().encode(RecipeContainer(recipes: recipes)))

        let response = try await source.fetch()
        XCTAssertEqual(recipes, response)
    }

    func testErrorResponse() async {
        let badServerResponse = URLError(.badServerResponse)
        do {
            MockAPI.result = .failure(badServerResponse)
            _ = try await source.fetch()
            XCTFail("expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "NSURLErrorDomain")
        }
    }
}
