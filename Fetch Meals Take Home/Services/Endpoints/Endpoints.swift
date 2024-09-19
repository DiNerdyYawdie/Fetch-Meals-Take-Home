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
    case mealsList
    case mealDetail
    
    var endpoint: String {
        switch self {
        case .mealsList:
            return "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case .mealDetail:
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL"
        }
    }
}
