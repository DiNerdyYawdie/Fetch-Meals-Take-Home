//
//  MealsViewModel.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import Foundation

class MealsViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    
    @Published var isLoading: Bool = false
    
    let services: MealsService
    
    init(services: MealsService) {
        self.services = services
    }
    
    @MainActor
    func fetchMeals() async {
        do {
            isLoading = true
            let meals = try await services.fetchMeals()
            
            self.meals = meals.sorted { $0.strMeal < $1.strMeal }
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
}
