//
//  MealsView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct MealsView: View {
    
    @ObservedObject var viewModel: MealsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.meals) { meal in
                    NavigationLink {
                        MealDetailsView(viewModel: MealDetailsViewModel(services: viewModel.services, mealID: meal.idMeal))
                    } label: {
                        MealRowView(viewModel: RowViewModel(meal: meal, cacheService: ImageCacheServiceImpl()))
                    }

                }
            }
            .listStyle(.plain)
            .navigationTitle("Meals")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchMeals()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView(LocalizedStringKey("Loading Meals..."))
                }
            }
            .alert(isPresented: $viewModel.showErrorAlert, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
        }
    }
}

#Preview {
    MealsView(viewModel: MealsViewModel(services: MealsServiceImpl()))
}
