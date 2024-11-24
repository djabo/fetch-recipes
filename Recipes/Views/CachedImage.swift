//
//  CachedImage.swift
//  Recipes
//

import SwiftUI

/// Displays an image from the cache. If the image has not already been cached it will be downloaded.
struct CachedImage: View {
    let url: URL
    @State var image = Image(uiImage: UIImage())
    @Environment(\.imageCache) var imageCache

    var body: some View {
        image
            .resizable()
            .task {
                if let image = await imageCache(url), !Task.isCancelled {
                    self.image = image
                }
            }
    }
}
