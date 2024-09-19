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
            self.meals = try await services.fetchMeals()
            dump(self.meals)
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
}
