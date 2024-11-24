//
//  ImageCache.swift
//  Recipes
//

import Foundation
import SwiftUI

/// Image cache that caches images both in-memory and on-device.
class ImageCache {
    let memoryCache = MemoryCache<UIImage>()
    let deviceCache = DeviceCache()
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Returns the image from the cache, downloading it if necessary.
    /// - If the image is in-memory, then it is returned immediately.
    /// - If the  image is on-device, it will be read and then cached in memory.
    /// - If the image must be downloaded, it will then be cachec both on the device and in memory.
    /// - If the image could not be downloaded or the data is invalid, nil is returned
    func callAsFunction(_ url: URL) async -> Image? {
        if let image = memoryCache[url] {
            return Image(uiImage: image)
        } else if let data = deviceCache?[url], let image = UIImage(data: data) {
            memoryCache[url] = image
            return Image(uiImage: image)
        } else if let (data, _) = try? await urlSession.data(from: url), let uiImage = UIImage(data: data) {
            // to improve memory usage, re-size the image
            let size = CGSize(width: 100, height: 100)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            uiImage.draw(in: CGRect(origin: .zero, size: size))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext() ?? uiImage
            UIGraphicsEndImageContext()

            memoryCache[url] = resizedImage
            deviceCache?[url] = resizedImage.pngData() ?? data
            return Image(uiImage: resizedImage)
        } else {
            return nil
        }
    }
}

extension EnvironmentValues {
    @Entry var imageCache = ImageCache()
}
