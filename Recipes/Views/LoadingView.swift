//
//  LoadingView.swift
//  Recipes
//

import SwiftUI

/// View that contains an empty list that cannot be interacted with, used to indicate that data is loading.
struct LoadingView: View {
    @State var isAnimating = false
    let emptyData = (0..<50).map { _ in
        Recipe(id: UUID(), name: "············", cuisine: "", photo: nil, icon: nil, source: nil, video: nil)
    }

    var body: some View {
        List(emptyData) {
            RecipeSummary(recipe: $0)
        }
        .opacity(isAnimating ? 0.1 : 0.4)
        .allowsHitTesting(false)
        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}
