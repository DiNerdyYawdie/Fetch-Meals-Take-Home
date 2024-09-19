//
//  MealsDetailViewModelTests.swift
//  Fetch Meals Take HomeTests
//
//  Created by Chad-Michael Muirhead on 9/19/24.
//

import XCTest
@testable import Fetch_Meals_Take_Home

final class MealsDetailViewModelTests: XCTestCase {

    var viewModel: MealDetailsViewModel!
    var mockService: MockServiceImpl!
    
    var mockMeal = MealDetail(strMeal: "Chicken", strInstructions: "Cook it", strIngredient1: "Sugar", strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "1 cup", strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil)

    override func setUp() {
        super.setUp()
        mockService = MockServiceImpl()
        viewModel = MealDetailsViewModel(services: mockService, mealID: "123")
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testAPISuccess() async {
        
        // Given
        mockService.mealDetailsResult = .success([mockMeal])
        
        // When
        await viewModel.fetchMealDetails()
        XCTAssertNotNil(viewModel.mealDetails)
        guard let mealDetail = viewModel.mealDetails else {
            XCTFail("Meal Details should not be nil")
            return
        }
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(mealDetail.strMeal, "Chicken")
        XCTAssertEqual(mealDetail.strIngredient1, "Sugar")
        XCTAssertEqual(mealDetail.strMeasure1, "1 cup")
    }
    
    func testAPIHTTPFailure() async {
        
        // Given
        mockService.mealDetailsResult = .failure(MealServiceError.httpError(statusCode: "500"))
        
        // When
        await viewModel.fetchMealDetails()
        
        XCTAssertNil(viewModel.mealDetails)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.httpError(statusCode: "500").errorMessage)
    }
    
    func testAPIDecodeFailure() async {
        
        // Given
        mockService.mealDetailsResult = .failure(MealServiceError.decodeError)
        
        // When
        await viewModel.fetchMealDetails()
        
        XCTAssertNil(viewModel.mealDetails)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.decodeError.errorMessage)
    }
    
    func testAPIURLFailure() async {
        
        // Given
        mockService.mealDetailsResult = .failure(MealServiceError.urlError)
        
        // When
        await viewModel.fetchMealDetails()
        
        XCTAssertNil(viewModel.mealDetails)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.urlError.errorMessage)
    }
    
    func testAPIUnknownFailure() async {
        
        // Given
        mockService.mealDetailsResult = .failure(MealServiceError.unknown(description: "unknown"))
        
        // When
        await viewModel.fetchMealDetails()
        
        XCTAssertNil(viewModel.mealDetails)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, MealServiceError.unknown(description: "unknown").errorMessage)
    }
}
