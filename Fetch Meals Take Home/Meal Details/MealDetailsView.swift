//
//  MealDetailsView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct MealDetailsView: View {
    
    @ObservedObject var viewModel: MealDetailsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if let mealDetails = viewModel.mealDetails {
                    
                    Text(mealDetails.strMeal)
                    
                    Text(mealDetails.strInstructions)
                    
                    List(mealDetails.ingredientsAndMeasurements, id: \.ingredient) { mealMeasurements in
                        Text(mealMeasurements.ingredient)
                        
                        Text(mealMeasurements.measurement)
                    }
                    
                } else {
                    ContentUnavailableView("Unable to fetch details for this meal", systemImage: "carrot.fill")
                }
            }
            .task {
                await viewModel.fetchMealDetails()
            }
        }
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(services: MealsServiceImpl(), mealID: "1234"))
}
