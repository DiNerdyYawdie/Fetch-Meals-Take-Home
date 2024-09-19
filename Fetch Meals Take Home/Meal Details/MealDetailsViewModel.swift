//
//  MealDetailsViewModel.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import Foundation

class MealDetailsViewModel: ObservableObject {
    
    @Published var mealDetails: MealDetail?
    
    @Published var isLoading: Bool = false
    
    let services: MealsService
    let mealID: String
    
    init(services: MealsService, mealID: String) {
        self.services = services
        self.mealID = mealID
        
    }
    
    @MainActor
    func fetchMealDetails() async {
        do {
            isLoading = true
            
            let meals = try await services.fetchMealDetails(mealID: mealID)
            
            self.mealDetails = meals.first
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
}
