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
    
    // Update the uiimage if we already have one stored in our dictionary cache
    //  Or download the data and create a uiimage and assign it
    @Published var uiImage: UIImage?
    
    let meal: Meal
    let cacheService: ImageCacheService
    
    init(meal: Meal, cacheService: ImageCacheService) {
        self.meal = meal
        self.cacheService = cacheService
    }
    
    // Get image data from cache or download it if needed
    func loadImage() async {
        uiImage = await cacheService.loadImage(url: meal.strMealThumb)
    }
}

