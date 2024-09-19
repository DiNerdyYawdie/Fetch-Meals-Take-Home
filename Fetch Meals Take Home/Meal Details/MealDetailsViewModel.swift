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
    
    @Published var errorMessage: String = ""
    @Published var showErrorAlert: Bool = false
    
    let services: MealsService
    let mealID: String
    
    init(services: MealsService, mealID: String) {
        self.services = services
        self.mealID = mealID
        
    }
    
    /// Fetch details for the meal based on `mealID`
    @MainActor
    func fetchMealDetails() async {
        do {
            isLoading = true
            
            let meals = try await services.fetchMealDetails(mealID: mealID)
            
            self.mealDetails = meals.first
            isLoading = false
        } catch let customError as MealServiceError {
            isLoading = false
            errorMessage = customError.errorMessage
            showErrorAlert.toggle()
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            showErrorAlert.toggle()
        }
    }
}
