//
//  RecipesUITests.swift
//  RecipesUITests
//

import XCTest

final class RecipesUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    @MainActor
    func testNavigateToDetail() throws {
        let app = XCUIApplication()
        app.launch()

        let firstRowExists = app.staticTexts["Apam Balik"].waitForExistence(timeout: 10)
        XCTAssert(firstRowExists)

        app.staticTexts["Apam Balik"].tap()

        let detailPresented = app.webViews.staticTexts["Print"].waitForExistence(timeout: 20)
        XCTAssert(detailPresented)
    }

    @MainActor
    func testFilter() throws {
        let app = XCUIApplication()
        app.launch()

        let apamBalikExists = app.staticTexts["Apam Balik"].waitForExistence(timeout: 10)
        XCTAssert(apamBalikExists)
        let appleFrangipanTartExists = app.staticTexts["Apple Frangipan Tart"].exists
        XCTAssert(appleFrangipanTartExists)

        let filter = app.searchFields.firstMatch
        filter.tap()
        filter.typeText("frangipan")
        XCTAssertFalse(app.staticTexts["Apam Balik"].exists)
        XCTAssert(app.staticTexts["Apple Frangipan Tart"].exists)
    }
}
