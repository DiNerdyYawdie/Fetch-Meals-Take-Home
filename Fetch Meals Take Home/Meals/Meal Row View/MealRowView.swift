//
//  MealRowView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import SwiftUI

struct MealRowView: View {
    
    let meal: Meal
    
    var body: some View {
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

#Preview {
    MealRowView(meal: Meal(strMeal: "Baked salmon with fennel & tomatoes", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/1548772327.jpg")!, idMeal: "52959"))
}
