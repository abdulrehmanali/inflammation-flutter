import 'dart:math';

import 'package:anti_inflammatory_app/Utils/toast.dart';
import 'package:anti_inflammatory_app/Views/UI/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../Model/achivegoalmodel.dart';
import '../Model/countpointsmodel.dart';
import '../Model/flaresmodel.dart';
import '../Model/homelevel.dart';
import '../Model/mealsmodel.dart';
import '../Model/recipeModel.dart';
import '../Model/suplementsModel.dart';
import '../constant/api.dart';
import 'authVm.dart';

class HomeVm with ChangeNotifier {
  bool showAllIngradientsInPopUp = false;

  setShowAllIngradientsInPopUpF() {
    showAllIngradientsInPopUp = !showAllIngradientsInPopUp;
    notifyListeners();
  }

  bool showAllPurchadedRecipes = false;

  setShowAllPurchadedRecipesF() {
    showAllPurchadedRecipes = !showAllPurchadedRecipes;
    notifyListeners();
  }

//////////
  HomeLevelModel? _levels = HomeLevelModel();
  HomeLevelModel? get level => _levels;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoadingF(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isBtnLoading = false;
  bool get isBtnLoading => _isBtnLoading;
  set isBtnLoadingF(bool value) {
    _isBtnLoading = value;
    notifyListeners();
  }

  Future levels(context) async {
    isLoadingF = true;
    try {
      final response = await http.get(Uri.parse(ApiUrls.levels));
      final responseData = json.decode(response.body);
      snackBarColorF("${responseData['message']}", context);
      if (responseData['success'] == false) {
        return;
      }

      final resultsData = responseData['results'];
      _levels = HomeLevelModel.fromJson(resultsData);
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  ///////////////////////////////////////////////////////////////////

  List<SupplementsModel> _suplements = [];
  List<SupplementsModel> get suplements => _suplements;
  Future getSuplements(context) async {
    isLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.get(Uri.parse(ApiUrls.supl.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          });

      print("Response status: ${response.statusCode}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        return;
      }

      var resultsData = responseData['results'] as List;
      _suplements = resultsData
          .map<SupplementsModel>((data) => SupplementsModel.fromJson(data))
          .toList();
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  List<SupplementsModel> tempSupl = [];
  Future getSuplementsBySearch(context, {String searchText = ""}) async {
    isLoadingF = true;
    try {
      if (tempSupl.isEmpty) {
        tempSupl = _suplements;
      }
      if (searchText.isEmpty) {
        _suplements = tempSupl;
        isLoadingF = false;
      } else {
        _suplements = _suplements
            .where((e) =>
                e.title.toLowerCase().contains(searchText.toLowerCase()) ||
                e.subTitle.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
      isLoadingF = false;
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  /////////////////////////////// Flares //////////////////////////////////
  String emojiNameIs = "";
  chooseEmojiF({emojiName = ""}) {
    emojiNameIs = emojiName;
    notifyListeners();
  }

  //save date ffrom calender
  DateTime selectedDateForFlares = DateTime.now();
  saveSelectedDateForFlares(DateTime dateIs) {
    selectedDateForFlares = dateIs;
    notifyListeners();
  }

  List<FlareModel> _flares = [];
  List<FlareModel> get flares => _flares;
  List<FlareModel> _flaresByDate = [];
  List<FlareModel> get flaresByDate => _flaresByDate;

  Future getFlaresF(context,
      {bool isLoad = true, String searchDate = ""}) async {
    if (isLoad) {
      isLoadingF = true;
    }
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    // Uri.parse(
    //     "${ApiUrls.allFlare}?date=${DateTime.now().subtract(const Duration(days: 7)).toIso8601String().substring(0, 23)}Z"),

    Uri urlIs = Uri.parse(ApiUrls.allFlare);
    if (searchDate.isEmpty) {
      urlIs = Uri.parse(ApiUrls.allFlare);
    } else {
      urlIs = Uri.parse("${ApiUrls.allFlare}?date=$searchDate");
    }
    try {
      final response = await http.get(urlIs, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user!.token}'
      });

      debugPrint("Response status: ${response.body}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      var resultsData = responseData['results'] as List;
      if (searchDate.isEmpty) {
        _flares = resultsData
            .map<FlareModel>((data) => FlareModel.fromJson(data))
            .toList();
      } else {
        _flaresByDate = resultsData
            .map<FlareModel>((data) => FlareModel.fromJson(data))
            .toList();
      }
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  Future setFlaresF(context, {notes = ""}) async {
    if (emojiNameIs.isEmpty) {
      snackBarColorF("Please choose an Symptom", context);
      return;
    }
    isBtnLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.post(Uri.parse(ApiUrls.setFlare.toString()),
          body: json.encode({
            // "date": DateTime.now().toIso8601String(),
            "date": "${DateTime.now().toIso8601String().substring(0, 23)}Z",
            "sovereignty":
                emojiNameIs.toLowerCase(), // Mild // Moderate // Severe
            "notes": "$notes"
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          });

      debugPrint("Response status: ${response.statusCode}");
      final responseData = json.decode(response.body);
      snackBarColorF("${responseData['message']}", context);
      if (responseData['success'] == false) {
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      await getFlaresF(context);
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isBtnLoadingF = false;
    }
  }
  /////////////////////////////// Recipes //////////////////////////////////

  List<RecipeModel> _recipes = [];
  List<RecipeModel> get recipes => _recipes;
  Future getRecipesF(context) async {
    isLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.get(Uri.parse(ApiUrls.getAllRecipes),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user!.token}'
          });

      debugPrint("Response status: ${response.body}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      var resultsData = responseData['results'] as List;
      _recipes = resultsData
          .map<RecipeModel>((data) => RecipeModel.fromJson(data))
          .toList();
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  List<RecipeModel> _purchasedRecipes = [];
  List<RecipeModel> get purchasedRecipes => _purchasedRecipes;
  Future getPurchasedRecipesF(context) async {
    isLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.get(Uri.parse(ApiUrls.purchasedRecipes),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user!.token}'
          });

      debugPrint("Response status: ${response.body}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      var resultsData = responseData['results'] as List;
      _purchasedRecipes = resultsData
          .map<RecipeModel>((data) => RecipeModel.fromJson(data))
          .toList();
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  ///////////////////////////// countPoints //////////////////////////////////////

  CountPointsModel _countPonits = CountPointsModel();
  CountPointsModel get countPonits => _countPonits;
  Future getCountPointsF(context) async {
    isLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.get(Uri.parse(ApiUrls.countPoints), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user!.token}'
      });

      debugPrint("Response status: ${response.body}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      _countPonits = CountPointsModel.fromJson(responseData['results']);

      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////// Add Meals Popup  //////////////////////////////////////
  ///
  ///

  var ingradientsList = ["Apple"];
  addIngradientsListF(value) {
    ingradientsList.add(value);
    notifyListeners();
  }

  removeIngradientsListF(value) {
    ingradientsList.remove(value);
    notifyListeners();
  }

/////
  var preprationList = [
    {
      "title": "Breakfast",
      "points": ["2 pts", "3 pts"],
    }
  ];
  List preprationPointsList = [
    "2 pts",
    "3 pts",
  ];
  addPreprationF(title) {
    preprationList.add({"title": title, "points": preprationPointsList});
    notifyListeners();
  }

  removePreprationF(value) {
    preprationList.remove(value);
    notifyListeners();
  }

  addPreprationPointsF(point) {
    preprationPointsList.add(point);
    notifyListeners();
  }

  removePreprationPointsF(point) {
    preprationPointsList.remove(point);
    notifyListeners();
  }

  var recipeIdIsForAddMeal = "";
  selectRecipeIdIsForAddMealF(RecipeModel data) {
    recipeIdIsForAddMeal = data.id.toString();
    ingradientsList.clear();
    for (var e in data.ingredients) {
      ingradientsList.add(e.ingredient.name);
    }
    preprationList.clear();
    for (var e2 in data.preparationSteps) {
      preprationList.add({
        "title": e2.title,
        "points": e2.points.map((e3) => e3.toString()).toList()
      });
    }
    notifyListeners();
  }

  Future addMealF(context, {date = "", type = ""}) async {
    isBtnLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.post(
          Uri.parse(ApiUrls.createMeals.toString()),
          body: json.encode({
            "date": "$date",
            "meal": {
              "type": type.toString().toLowerCase(),
              "recipe": recipeIdIsForAddMeal
            }
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user!.token}'
          });

      debugPrint("Response status: ${response.statusCode}");
      final responseData = json.decode(response.body);
      snackBarColorF("${responseData['message']}", context);
      if (responseData['success'] == false) {
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isBtnLoadingF = false;
    }
  }
  /////
  /////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////// Achive Goals  //////////////////////////////////////

  List<AchieveGoalModel> _achiveGoals = [];
  List<AchieveGoalModel> get achiveGoals => _achiveGoals;
  Future getAchiveGoalsF(context) async {
    isLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    try {
      final response = await http.get(Uri.parse(ApiUrls.acheiveGoal), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user!.token}'
      });

      debugPrint("Response status: ${response.body}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      var resultsData = responseData['results'] as List;
      _achiveGoals = resultsData
          .map<AchieveGoalModel>((data) => AchieveGoalModel.fromJson(data))
          .toList();
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  ///////////////////////////// Achive Goals  //////////////////////////////////////
  List<MealsModel> _getMealsList = [];
  List<MealsModel> get getMealsList => _getMealsList;
  bool isWeekly = false;
  Future getMealsF(context, {bool weekly = false}) async {
    isLoadingF = true;
    final user =
        await Provider.of<AuthVm>(context, listen: false).getUserData();
    // debugPrint("👉 ${user!.token.toString()}");
    try {
      Uri urlIs = Uri.parse(ApiUrls.allFlare);
      if (weekly) {
        isWeekly = true;
        urlIs = Uri.parse(
            "${ApiUrls.allMeals}${DateTime.now().subtract(const Duration(days: 7)).year}-${DateTime.now().subtract(const Duration(days: 7)).month}-${DateTime.now().subtract(const Duration(days: 7)).day}");
        snackBarColorF("Changed To Weekly", context);
      } else {
        isWeekly = false;
        urlIs = Uri.parse(
            "${ApiUrls.allMeals}${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
        snackBarColorF("Changed To Today", context);
      }

      final response = await http.get(urlIs, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user!.token}'
      });

      debugPrint("Response status: ${response.body}");
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        snackBarColorF("${responseData['message']}", context);
        if (responseData['message'].toString() == "Token expired") {
          Get.offAll(() => const LoginScreen());
        }
        return;
      }

      var resultsData = responseData['results'] as List;
      _getMealsList = resultsData
          .map<MealsModel>((data) => MealsModel.fromJson(data))
          .toList();
      notifyListeners();
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }
}
