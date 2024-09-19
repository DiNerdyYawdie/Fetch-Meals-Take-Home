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
                        MealRowView(meal: meal)
                    }

                }
            }
            .listStyle(.plain)
            .navigationTitle("Meals")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealsView(viewModel: MealsViewModel(services: MealsServiceImpl()))
}
