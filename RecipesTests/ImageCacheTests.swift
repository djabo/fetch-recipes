//
//  ImageCacheTests.swift
//  Recipes
//

import XCTest
@testable import Recipes

final class ImageCacheTests: XCTestCase {
    var cache: ImageCache!
    var testImage: UIImage {
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)

        let context = UIGraphicsGetCurrentContext()
        UIColor.blue.setFill()
        context?.fill([frame])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockAPI.self]
        cache = ImageCache(urlSession: URLSession(configuration: config))
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        try cache.deviceCache?.remove()
        cache = nil
        MockAPI.result = .failure(NSError(domain: "test", code: 0))
    }

    func testCaching() async {
        let url = URL(string: "https://image.com/image?name=a.png")!
        MockAPI.result = .success(testImage.pngData()!)

        XCTAssertNil(cache.memoryCache[url])
        XCTAssertNil(cache.deviceCache?[url])

        let image = await cache(url)
        XCTAssertNotNil(image)
        XCTAssertNotNil(cache.memoryCache[url])
        XCTAssertNotNil(cache.deviceCache?[url])
    }

    func testDownloadError() async {
        let url = URL(string: "https://image.com/image.png")!
        let image = await cache(url)
        XCTAssertNil(image)
    }

    func testCaching_alreadyCachedOnDevice() async {
        let url = URL(string: "https://image.com/image.png")!
        cache.deviceCache?[url] = testImage.pngData()!

        XCTAssertNil(cache.memoryCache[url])

        let image = await cache(url)
        XCTAssertNotNil(image)
        XCTAssertNotNil(cache.memoryCache[url])
    }

    func testCaching_alreadyCachedInMemory() async {
        let url = URL(string: "https://image.com/image.png")!
        cache.memoryCache[url] = testImage

        let image = await cache(url)
        XCTAssertNotNil(image)
        XCTAssertNotNil(cache.memoryCache[url])
    }
}
