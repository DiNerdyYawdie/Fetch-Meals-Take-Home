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
                    GroupBox {
                        VStack(alignment: .leading) {
                            
                            // TODO: switch to SDWebImageSwiftUI or implement local caching for images
                            AsyncImage(url: meal.strMealThumb) { image in
                                image
                                    .resizable()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(4)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text(meal.strMeal)
                                .font(.title3)
                                .fontWeight(.medium)

                        }
                    }
                }
            }
            .listStyle(.plain)
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealsView(viewModel: MealsViewModel(services: MealsServiceImpl()))
}
