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
    
    @Published var errorMessage: String = ""
    @Published var showErrorAlert: Bool = false
    
    let services: MealsService
    
    init(services: MealsService) {
        self.services = services
    }
    
    @MainActor
    func fetchMeals() async {
        do {
            isLoading = true
            /// Food Category can be changed, by changing the `mealCategory`
            /// Default value for `mealCategory` is `dessert`
            let meals = try await services.fetchMeals(mealCategory: .dessert)
            
            self.meals = meals.sorted { $0.strMeal < $1.strMeal }
            isLoading = false
        } catch let error as MealServiceError {
            isLoading = false
            errorMessage = error.errorMessage
            showErrorAlert.toggle()
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert.toggle()
        }
    }
}
