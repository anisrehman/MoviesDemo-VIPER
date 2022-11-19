# MoviesDemo-VIPER
This demo app uses TMDB API to show Popular, Top Rated and Upcoming movies.

## Architecture
It follows VIPER architecture with SOLID design principals.

* **APIRouter** - It routes to different API calls.
* **APIClient** - It calls the API and parses the response.
* **MoviesService** - It fetches the movies in different categories.
* **MovieRepository** - It saves the movies in local database and loads from database when requested.

## Test Cases
It includes some test cases testing different app features.

* **MoviesServiceTests** - It includes tests for MoviesService class.
* **MoviesInteractorTests** - It tests MoviesInteractor load and search movies.

## Demo App Features 
1. Show movies in different categories.
2. Movies data is stored locally.
3. If internet is not working, it shows data from local storage.
4. User can search movies from local storage.


