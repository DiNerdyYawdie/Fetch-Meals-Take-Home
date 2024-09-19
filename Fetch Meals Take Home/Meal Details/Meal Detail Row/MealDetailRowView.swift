//
//  MealDetailRowView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import SwiftUI

struct MealDetailRowView: View {
    
    let mealMesurements: IngredientMeasurement
    
    var body: some View {
        HStack {
            Text(mealMesurements.ingredient.capitalized)
            
            Spacer()
            
            Text(mealMesurements.measurement)
        }
        
    }
}

#Preview {
    MealDetailRowView(mealMesurements: IngredientMeasurement(ingredient: "Sugar", measurement: "1/4 cup"))
}
