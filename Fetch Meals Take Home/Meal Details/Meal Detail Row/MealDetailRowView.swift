//
//  MealDetailRowView.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import SwiftUI

struct MealDetailRowView: View {
    
    let mealMesurements: (ingredient: String, measurement: String)
    
    var body: some View {
        HStack {
            Text(mealMesurements.ingredient.capitalized)
            
            Spacer()
            
            Text(mealMesurements.measurement)
        }
        
    }
}

#Preview {
    MealDetailRowView(mealMesurements: (ingredient: "Sugar", measurement: "1/4 cup"))
}
