//
//  MealsService.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import Foundation

protocol MealsService {
    func fetchMeals() async throws -> [Meal]
}

enum MealServiceError: Error {
    case urlError
    case httpError
    case decodeError
    case unknown
    
    /// Readable text to show based on error
    var errorMessage: String {
        switch self {
        case .urlError:
            return "URL error"
        case .httpError:
            return "HTTP error"
        case .decodeError:
            return "Decode error"
        case .unknown:
            return "Unknown error"
        }
    }
}

class MealsServiceImpl: MealsService {
    
    func fetchMeals() async throws -> [Meal] {
        return []
    }
}
