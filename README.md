## Fetch Meals Take Home Project
For this project i was tasked with providing a list of meals based on the API and also alowing the user to get further detail about the meal by using the details API.


## Architecture
For the project i used the MVVM architecture to allow for great separation of the business logic from the views and models.

 - Models: 
        1. For the `Meals` presented in the list, i used the `MealResponse` & `Meal` models, to decode the data retrieved to represent each meal.
        2. For the `Meals Details` presented after the user taps a meal, I used `MealDetailResponse` & `MealDetail` to represent these
        3. Also I added an additional computer property called `MealDetail.ingredientsAndMeasurements` to allow for ease of use when handling the multiple different ingredients and measurements for the meal.
        4. Also created a struct for modeling the Ingredients & Measurements data called `IngredientMeasurement`
 
- ViewModels:
    ### MealsViewModel
        1. Created the `MealsViewModel` to handle the business logic and dependecies(`MealServices`) for the `MealsView`
        2. From here we used the service dependency to fetch data and pass it to the view
        3. Also hanlded the sorting by alphabetical order
            ### MealRowViewModel
            1. Used within the row of each view in the `MealsView`
            2. Uses the `ImageCacheService` to check if an image was already downloaded and saved locally to the `cachedImageDictionary`, if not we download the image and then save it
            
            
    ### MealDetailsViewModel
        1. Created to fetch the details for the selected meal, by using the `mealID`

### Views:
    1. `MealsView` - shows the list of all the meals provided by the API
    2. `MealRowView` - view that represents each meal inside the List in `MealsView`
    
    3. `MealDetailsView` - shows the details for a specific meal allow with its ingredients, directions and measurements
    4. `MealDetailRowView` - used to show the Ingredeint & measurements for the meal in the detail screen
    

## Services

    1. `MealsService` - used to fetch the list of meals provided by the API and also the details for a specific meal
    2. Provides custom errors `MealServiceError`, allow with a readable error message using `errorMessage` property it has
    
## Meal Categories

    1. `MealCategories` - An enum used to represent the various types of categories that can be passed in the request for the API

## Endpoints
1. `Endpoints` - enum used to handle getting the specific endpoints needed for:
    Fetching all meals based on a category: "https://themealdb.com/api/json/v1/1/filter.php?c=\(mealCategory)"
    Fetching details about a specifc meal by using an ID: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"

