//
//  MealRowView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct MealRowView: View {
    
    @ObservedObject var viewModel: RowViewModel
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                
                if let postImage = viewModel.uiImage {
                   Image(uiImage: postImage)
                        .resizable()
                        .cornerRadius(4)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                } else {
                    ProgressView()
                }
                
                Text(viewModel.meal.strMeal)
                    .font(.title3)
                    .fontWeight(.medium)

            }
            .task {
                await viewModel.loadImage()
            }
        }
    }
}

#Preview {
    MealRowView(viewModel: RowViewModel(meal: Meal(strMeal: "Baked salmon with fennel & tomatoes", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/1548772327.jpg")!, idMeal: "52959"), cacheService: ImageCacheServiceImpl()))
}
