class ApiUrls {
  static const String imgUrl = 'http://localhost:5173/';
  static const String baseUrl = 'http://localhost:5173/api';
  // static const String imgUrl = 'http://localhost:5173/';
  // static const String baseUrl =
  //     'http://localhost:5173/api';
  static const String login = '$baseUrl/user/signin'; // post
  static const String signup = '$baseUrl/user/signup'; // post
  static const String forgotPassword = '$baseUrl/forgot-password'; // post
  static const String updateUser = '$baseUrl/user/'; // put

  // flare
  static const String allFlare =
      '$baseUrl/flare'; // get 2023-02-20T14:30:00.000Z
  static const String setFlare = '$baseUrl/flare'; // post
  static const String singleFlare =
      '$baseUrl/flare/s/'; // get  670d7a660ef55491d4b1d86d
  static const String updateFlare =
      '$baseUrl/flare/s/'; // put 670d7a660ef55491d4b1d86d
  static const String paginateFlare = '$baseUrl/flare/paginate'; // get
  static const String deleteFlare =
      '$baseUrl/flare/s/'; // delete 670d7beef9356b0bb86ca996

  // Recipe
  static const String purchasedRecipes = '$baseUrl/user/recipes/'; // get
  static const String createRecipe = '$baseUrl/user/recipes/'; // post
  static const String singleRecipe =
      '$baseUrl/user/recipes/s/670e443ee8346d6978636cb0'; // get
  static const String updateRecipe =
      '$baseUrl/user/recipes/s/670e443ee8346d6978636cb0'; // put
  static const String deleteRecipe =
      '$baseUrl/user/recipes/s/670e45d1c7e4ee8a57268e9a'; // delete
  static const String paginateRecipe = '$baseUrl/user/recipes/paginate'; // get

  // Meals
  static const String allMeals = '$baseUrl/meal?date='; // get
  static const String createMeals = '$baseUrl/meal/'; // post
  static const String singleMeals =
      '$baseUrl/meal?date=2024-03-22T20:09:10.422Z'; // get
  // Goal
  static const String acheiveGoal = '$baseUrl/acheiveGoal'; // get
  static const String search = '$baseUrl/search?search=/'; // get
  static const String searchByCatgId =
      '$baseUrl/search/ingredients/?id=6706d37f082cc25537a8ff75'; // get

  // points
  static const String levels = '$baseUrl/points/'; // get
  static const String countPoints = '$baseUrl/points/date?from='; // get
  ///////////////// From Admin //////////////////
  static const String supl = '$baseUrl/supplements'; // get
  static const String getAllRecipes = '$baseUrl/recipes'; // get
}
