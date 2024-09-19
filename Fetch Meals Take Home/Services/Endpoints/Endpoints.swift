//
//  Endpoints.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/18/24.
//

import Foundation

//https://themealdb.com/api/json/v1/1/filter.php?c=Dessert for fetching the list of meals in the Dessert category.
//https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL
//_
//ID for fetching the meal details by its ID.

enum Endpoints {
    case mealsList(mealCategory: String)
    case mealDetail(mealID: String)
    
    var endpoint: String {
        switch self {
        case .mealsList(let mealCategory):
            return "https://themealdb.com/api/json/v1/1/filter.php?c=\(mealCategory)"
        case .mealDetail(let mealID):
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        }
    }
}
