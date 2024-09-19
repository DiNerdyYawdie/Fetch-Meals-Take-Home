//
//  MealRowViewModel.swift
//  Fetch Meals Take Home
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import UIKit
import Foundation

@MainActor
class RowViewModel: ObservableObject {
    
    @Published var uiImage: UIImage?
    
    let meal: Meal
    let cacheService: ImageCacheService
    
    init(meal: Meal, cacheService: ImageCacheService) {
        self.meal = meal
        self.cacheService = cacheService
    }
    
    func loadImage() async {
        uiImage = await cacheService.loadImage(url: meal.strMealThumb)
    }
}

