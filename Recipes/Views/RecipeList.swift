//
//  RecipeList.swift
//  Recipes
//

import SwiftUI

/// Shows a list of Recipes.
struct RecipeList: View {
    @StateObject var viewModel = RecipesViewModel()
    @State var filter: String = ""
    @State var selectedRecipe: Recipe?
    @State var isLoading = true
    @State var error: Error?

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.recipes().isEmpty {
                    if isLoading {
                        LoadingView()
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                if let error {
                                    Text(error.localizedDescription)
                                        .foregroundStyle(Color.red)
                                } else {
                                    Text("No recipes found.")
                                }

                                Button("Refresh", action: refresh)
                            }
                            .padding()
                        }
                    }
                } else {
                    List(viewModel.recipes(filter: filter.isEmpty ? nil : filter), id: \.self, selection: $selectedRecipe) {
                        RecipeSummary(recipe: $0)
                    }
                    .searchable(text: $filter, prompt: "Recipe Name or Cuisine")
                    .refreshable {
                        refresh()
                    }
                    .sheet(item: $selectedRecipe) {
                        RecipeDetail(recipe: $0)
                    }
                }
            }
            .navigationTitle(Text("Recipes"))
            .listStyle(.plain)
        }
        .onAppear(perform: refresh)
    }

    func refresh() {
        Task {
            do {
                defer { isLoading = false }
                selectedRecipe = nil
                try await viewModel.refresh()
            } catch {
                self.error = error
            }
        }
    }
}

#Preview {
    RecipeList()
}

#Preview {
    RecipeList(viewModel: RecipesViewModel(
        source: RecipeAPIDataSource(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!)
    ))
}

#Preview {
    RecipeList(viewModel: RecipesViewModel(
        source: RecipeAPIDataSource(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!)
    ))
}
