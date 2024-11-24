//
//  RecipeTests.swift
//  Recipes
//

import XCTest
@testable import Recipes

final class RecipeTests: XCTestCase {
    func testDecoding() throws  {
        let json = """
         {
             "cuisine": "British",
             "name": "Bakewell Tart",
             "photo_url_large": "https://some.url/large.jpg",
             "photo_url_small": "https://some.url/small.jpg",
             "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
             "source_url": "https://some.url/index.html",
             "youtube_url": "https://www.youtube.com/watch?v=some.id"
         }
        """

        let data = json.data(using: .utf8)
        XCTAssertNotNil(data)

        let recipe = try JSONDecoder().decode(Recipe.self, from: data ?? Data())
        XCTAssertEqual(recipe.id.uuidString, "eed6005f-f8c8-451f-98d0-4088e2b40eb6".uppercased())
        XCTAssertEqual(recipe.name, "Bakewell Tart")
        XCTAssertEqual(recipe.cuisine, "British")
        XCTAssertEqual(recipe.photo?.absoluteString, "https://some.url/large.jpg")
        XCTAssertEqual(recipe.icon?.absoluteString, "https://some.url/small.jpg")
        XCTAssertEqual(recipe.source?.absoluteString, "https://some.url/index.html")
        XCTAssertEqual(recipe.video?.absoluteString, "https://www.youtube.com/watch?v=some.id")
    }
}
