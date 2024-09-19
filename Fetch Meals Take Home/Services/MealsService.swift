//
//  MealsService.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import Foundation

protocol MealsService {
    func fetchMeals(mealCategory: MealCategories) async throws -> [Meal]
}

enum MealServiceError: Error {
    case urlError
    case httpError(statusCode: String)
    case decodeError
    case urlResponseError
    case unknown(description: String)
    
    /// Readable text to show based on error
    var errorMessage: String {
        switch self {
        case .urlError:
            return "URL error"
        case .httpError(let statusCode):
            return "HTTP error, status code: \(statusCode)"
        case .decodeError:
            return "Decode error"
        case .urlResponseError:
            return "URL Response Error"
        case .unknown(let description):
            return "Unknown error: \(description)"
        }
    }
}

class MealsServiceImpl: MealsService {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMeals(mealCategory: MealCategories = .dessert) async throws -> [Meal] {
        guard let url = URL(string: Endpoints.mealsList(mealCategory: mealCategory.rawValue).endpoint) else {
            throw MealServiceError.urlError
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                throw MealServiceError.urlResponseError
            }
            
            guard (200...299).contains(httpURLResponse.statusCode) else {
                throw MealServiceError.httpError(statusCode: String(httpURLResponse.statusCode))
            }
            
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            return mealResponse.meals
        } catch let decodingError as DecodingError {
            throw MealServiceError.decodeError
        } catch is URLError {
            throw MealServiceError.urlError
        } catch {
            throw MealServiceError.unknown(description: error.localizedDescription)
        }
    }
}
