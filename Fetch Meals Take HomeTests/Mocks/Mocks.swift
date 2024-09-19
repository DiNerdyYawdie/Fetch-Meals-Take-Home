//
//  Mocks.swift
//  Fetch Meals Take HomeTests
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import Foundation
@testable import Fetch_Meals_Take_Home

class MockServiceImpl: MealsService {
    
    var mealResult: Result<[Meal], MealServiceError>?
    var mealDetailsResult: Result<[MealDetail], MealServiceError>?
    
    func fetchMeals(mealCategory: MealCategories) async throws -> [Meal] {
        switch mealResult {
        case .success(let posts):
            return posts
        case .failure(let error):
            throw error
        case nil:
            throw MealServiceError.unknown(description: "unknown")
        }
    }
    
    func fetchMealDetails(mealID: String) async throws -> [MealDetail] {
        switch mealDetailsResult {
        case .success(let mealDetail):
            return mealDetail
        case .failure(let error):
            throw error
        case nil:
            throw MealServiceError.unknown(description: "unknown")
        }
    }
}
