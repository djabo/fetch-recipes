//
//  RecipeDetail.swift
//  Recipes
//

import SwiftUI

/// Shows detailed information for a Recipe.
struct RecipeDetail: View {
    let recipe: Recipe
    @Environment(\.dismiss) var dismiss

    var body: some View {
        if let url = recipe.source ?? recipe.video {
            SFSafariView(url: url)
        } else {
            VStack(spacing: 0) {
                HStack {
                    Text(recipe.name)
                        .font(.headline)
                    Spacer()
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "x.circle")
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal)

                if let image = recipe.photo ?? recipe.icon {
                    CachedImage(url: image)
                        .ignoresSafeArea()
                }
            }
            .presentationDetents([.medium])
        }
    }
}
