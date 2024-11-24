//
//  DeviceCache.swift
//  Recipes
//

import Foundation
import OSLog

/// Caches data on the device.
class DeviceCache {
    private let directory: URL
    private let logger = Logger()

    /// Creates an on-device cache. Returns nil if the directory to write the data to cannot be found.
    init?() {
        guard let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(component: "dataCache") else {
            logger.warning("User caches directory not found")
            return nil
        }
        self.directory = directory
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false)
    }

    subscript(url: URL) -> Data? {
        get {
            let fileName = url.absoluteString.replacingOccurrences(of: "://", with: "_").replacingOccurrences(of: "/", with: "_")
            return try? Data(contentsOf: directory.appending(component: fileName))
        }
        set {
            do {
                let fileName = url.absoluteString.replacingOccurrences(of: "://", with: "_").replacingOccurrences(of: "/", with: "_")
                try newValue?.write(to: directory.appending(component: fileName))
            } catch {
                logger.error("Unable to cache image: \(error)")
            }
        }
    }

    /// Removes all data cached on the device.
    func remove() throws {
        try FileManager.default.removeItem(at: directory)
    }
}
