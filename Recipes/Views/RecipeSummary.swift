//
//  RecipeSummary.swift
//  Recipes
//

import SwiftUI

/// Shows a brief summary of a Recipe.
struct RecipeSummary: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            ZStack {
                Color.gray
                if let icon = recipe.icon {
                    CachedImage(url: icon)
                }
            }
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
            .frame(width: 100, height: 100)

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)

                if !recipe.cuisine.isEmpty {
                    Text("in \(recipe.cuisine) Cuisine")
                        .foregroundStyle(Color.secondary)
                        .italic()
                        .font(.footnote)
                }
                Spacer()
            }
            .padding(.vertical, 6)
        }
    }
}
