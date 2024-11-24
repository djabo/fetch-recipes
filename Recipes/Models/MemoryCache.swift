//
//  MemoryCache.swift
//  Recipes
//

import Foundation

/// Cache an object in-memory. The cached objects may be cleared if the device is low on memory.
class MemoryCache<T: AnyObject> {
    private let cache = NSCache<NSURL, T>()

    subscript(url: URL) -> T? {
        get {
            cache.object(forKey: url as NSURL)
        }
        set {
            if let newValue {
                cache.setObject(newValue, forKey: url as NSURL)
            } else {
                cache.removeObject(forKey: url as NSURL)
            }
        }
    }
}
