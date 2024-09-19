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
            Form {
                if let mealDetails = viewModel.mealDetails {
                    
                    Section {
                        Text(mealDetails.strInstructions)
                    } header: {
                        Text("Directions")
                    }

                    
                    Section {
                        List(mealDetails.ingredientsAndMeasurements, id: \.ingredient) { mealMeasurements in
                            
                            HStack {
                                Text(mealMeasurements.ingredient.capitalized)
                                
                                Spacer()
                                
                                Text(mealMeasurements.measurement)
                            }
                            
                        }
                    } header: {
                        Text("Measurements/Instructions")
                    }

                    
                    
                } else {
                    ContentUnavailableView(label: {
                        Label("Unable to fetch meal details", systemImage: "carrot.fill")
                    }, actions:  {
                        Button(action: {
                            Task {
                                await viewModel.fetchMealDetails()
                            }
                        }, label: {
                            Text("Retry")
                        })
                    })
                    
                }
            }
            .navigationTitle(viewModel.mealDetails?.strMeal ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchMealDetails()
            }
        }
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(services: MealsServiceImpl(), mealID: "52772"))
}
