//
//  Fetch_Meals_Take_HomeTests.swift
//  Fetch Meals Take HomeTests
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import XCTest
@testable import Fetch_Meals_Take_Home

final class Fetch_Meals_Take_HomeTests: XCTestCase {

    var viewModel: MealsViewModel!
    var mockService: MockServiceImpl!

    override func setUp() {
        super.setUp()
        mockService = MockServiceImpl()
        viewModel = MealsViewModel(services: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testAPISuccess() async {
        var mockMeal1 = Meal(strMeal: "Chicken", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!, idMeal: "123")
        var mockMeal2 = Meal(strMeal: "Fish", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!, idMeal: "124")
        // Given
        mockService.mealResult = .success([mockMeal1, mockMeal2])
        
        // When
        await viewModel.fetchMeals()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.meals.count, 2)
        XCTAssertEqual(viewModel.meals[0].strMeal, "Chicken")
    }
    
    func testAPIHTTPFailure() async {
        
        // Given
        mockService.mealResult = .failure(MealServiceError.httpError(statusCode: "500"))
        
        // When
        await viewModel.fetchMeals()
        
        // Then
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.meals.count, 0)
        
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.httpError(statusCode: "500").errorMessage)
    }
    
    func testAPIDecodeFailure() async {
        
        // Given
        mockService.mealResult = .failure(MealServiceError.decodeError)
        
        // When
        await viewModel.fetchMeals()
        
        // Then
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.meals.count, 0)
        
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.decodeError.errorMessage)
    }
    
    func testAPIURLFailure() async {
        
        // Given
        mockService.mealResult = .failure(MealServiceError.urlError)
        
        // When
        await viewModel.fetchMeals()
        
        // Then
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.meals.count, 0)
        
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.urlError.errorMessage)
    }
    
    func testAPIUnknownFailure() async {
        
        // Given
        mockService.mealResult = .failure(MealServiceError.unknown(description: "unknown"))
        
        // When
        await viewModel.fetchMeals()
        
        // Then
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.meals.count, 0)
        
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.unknown(description: "unknown").errorMessage)
    }
    
    func testMealsAlphabetized() async {
        var mockMeal1 = Meal(strMeal: "Seafood", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!, idMeal: "123")
        var mockMeal2 = Meal(strMeal: "Vegetarian", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!, idMeal: "124")
        var mockMeal3 = Meal(strMeal: "Lamb", strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!, idMeal: "124")
        // Given
        mockService.mealResult = .success([mockMeal1, mockMeal2, mockMeal3])
        
        // When
        await viewModel.fetchMeals()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.meals.count, 3)
        XCTAssertEqual(viewModel.meals[0].strMeal, "Lamb")
        XCTAssertEqual(viewModel.meals[1].strMeal, "Seafood")
        XCTAssertEqual(viewModel.meals[2].strMeal, "Vegetarian")
    }
}
