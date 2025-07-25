import 'package:anti_inflammatory_app/Utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paypal_payment/paypal_payment.dart';
import 'package:provider/provider.dart';
import '../../../../../Controllers/homevm.dart';
import '../../../../../Model/recipeModel.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/text_styles.dart';
import '../../../../../paypal.dart';
import '../../Purchase/recipes_purchase.dart';
import '../Flares/flares.dart';
import '../Supps/supplements.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<HomeVm>(context, listen: false).getRecipesF(context);
    await Provider.of<HomeVm>(context, listen: false)
        .getPurchasedRecipesF(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<HomeVm>(builder: (context, p, c) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Text(
            'InflamEase',
            style: AppTextStyles.heading.copyWith(
              fontSize: screenWidth * 0.06,
              color: AppColors.primaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person, color: AppColors.primaryColor),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopTabs(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildHeader(screenWidth, context), // Updated to pass context
                SizedBox(height: screenHeight * 0.02),
                _buildRecipesList(p, screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildIndividualRecipes(p, screenWidth, context),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Top Tabs: Recipes, Flares, Supps
  Widget _buildTopTabs(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _buildTabButton('Recipes', Icons.restaurant, true)),
        Flexible(
            child:
                _buildTabButton('Flares', Icons.local_fire_department, false)),
        Flexible(
            child: _buildTabButton('Supps', Icons.medical_services, false)),
      ],
    );
  }

  Widget _buildTabButton(String title, IconData icon, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        if (title == 'Recipes') {
          Get.to(() => const RecipesScreen());
        }
        if (title == 'Flares') {
          Get.to(() => const FlaresScreen());
        }
        if (title == 'Supps') {
          Get.to(() => const Supplements());
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.accentColor : Colors.white,
        side: const BorderSide(color: AppColors.accentColor, width: 1.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: isSelected ? Colors.white : AppColors.primaryColor,
              size: 16),
          const SizedBox(width: 4),
          Text(
            title,
            style: AppTextStyles.buttonText.copyWith(
                color: isSelected ? Colors.white : AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  // Header for "5 Day Recipes" section
  Widget _buildHeader(double screenWidth, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '5 Day Recipes',
          style: AppTextStyles.heading.copyWith(
            color: Colors.black,
            fontSize: screenWidth * 0.05,
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     _showGroceryListDialog(context); // Show grocery list dialog
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.primaryColor,
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   child: Text(
        //     'Grocery List',
        //     style: AppTextStyles.buttonText
        //         .copyWith(color: Colors.white, fontSize: 14),
        //   ),
        // ),
      ],
    );
  }

  // Horizontal Scroll List for Recipes
  Widget _buildRecipesList(HomeVm p, double screenWidth) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: p.recipes.length,
        shrinkWrap: true,
        controller: ScrollController(),
        itemBuilder: (context, index) {
          return _buildRecipeCard(
              p.recipes[index].name,
              p.recipes[index].name.toString(),
              // "Day ${index + 1}",
              p.recipes[index].image);
        },
      ),
    );
  }

//  _buildRecipeCard(
//               'Lunch', 'Grilled Chicken', 'DAY 3', 'assets/lunch.png'),
  // Recipe Card
  Widget _buildRecipeCard(
      String mealType, String recipeName, String imagePath) {
    return Container(
      width: 140,
      height: 230,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                //   decoration: BoxDecoration(
                //     color: AppColors.accentColor,
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: Text(
                //     day,
                //     style: AppTextStyles.normalText.copyWith(
                //       fontSize: 12,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 4),
                Text(
                  mealType.toString().length > 14
                      ? '${mealType.substring(0, 14)}...'
                      : mealType,
                  style: AppTextStyles.normalText
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  recipeName.toString().length > 14
                      ? '${recipeName.substring(0, 14)}...'
                      : recipeName,
                  style: AppTextStyles.normalText
                      .copyWith(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              onPressed: () async {
                // final PayPalService payPalService = PayPalService();
                // try {
                //   String? paymentId =
                //       await payPalService.createPayment(10.00); // Amount to pay
                //   print('Payment ID: $paymentId');
                //   // Handle the payment approval flow here
                // } catch (e) {
                //   print('Error: $e');
                // }

                const String url =
                    "http://localhost:63329/app/example"; // Change this to your server URL
                const String clientId =
                    "AXDyDrmWIZG2WBXdXw__ccVuYUxL7fahGUa-bdf1D5NW5Mb7WljRa7fcLup5CmBila3078Zts5xMdgHz"; // Sandbox Client ID
                const String secretKey =
                    "EJYieMwovw_8y_Q2E3zaI9RgW-Tg5VyHnU7PMEqX--_1bd7weo6zzHzdZDn8GNxoxJ4h9J8rtWiXY91x"; // Sandbox Secret Key
                const String currencyCode = "USD";
                const String amount = "100"; // Amount to be charged

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalOrderPayment(
                    sandboxMode: true,
                    returnURL: url, // Mandatory for web
                    cancelURL: url, // Mandatory for web
                    clientId: clientId,
                    secretKey: secretKey,
                    currencyCode: currencyCode,
                    amount: amount,
                    onSuccess: () {
                      snackBarColorF("Order Created", context);
                    },
                    onError: () {
                      snackBarColorF("Try Later", context);
                    },
                    onCancel: () {
                      snackBarColorF("Order Cancelled", context);
                    },
                  ),
                ));

                // Get.to(PaypalPaymentExample());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size.fromHeight(5),
              ),
              child:
                  const Text('Purchase', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Individual Recipes Section
  Widget _buildIndividualRecipes(
      HomeVm p, double screenWidth, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Purchased Recipes',
              style: AppTextStyles.heading.copyWith(
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Individual Recipes',
        //       style: AppTextStyles.heading.copyWith(
        //           color: Colors.black,
        //           fontSize: screenWidth * 0.05,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const PurchaseRecipesScreen(),
        //             ));
        //       },
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: AppColors.primaryColor,
        //         padding:
        //             const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //       ),
        //       child: Text(
        //         'Purchase',
        //         style: AppTextStyles.buttonText.copyWith(color: Colors.white),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(height: 8),
        ListView.builder(
          itemCount: p.showAllPurchadedRecipes
              ? p.purchasedRecipes.length
              : p.purchasedRecipes.length > 3
                  ? 3
                  : p.purchasedRecipes.length,
          shrinkWrap: true,
          controller: ScrollController(),
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var data = p.purchasedRecipes[index];

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Image.network(data.image, width: 50),
                title: Text(data.name),
                subtitle: Text(
                  'By: ${data.createdBy.name}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _showRecipeDialog(context, p, data); // Show popup dialog
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  child:
                      const Text('Read', style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton.icon(
            icon: p.showAllPurchadedRecipes
                ? const Icon(Icons.keyboard_arrow_down_rounded,
                    color: Colors.white)
                : const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            onPressed: () {
              p.setShowAllPurchadedRecipesF();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            label: Text('Show all',
                style: AppTextStyles.buttonText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // Grocery List Dialog Popup
  void _showGroceryListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and close button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grocery List',
                          style: AppTextStyles.heading.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close,
                              color: AppColors.accentColor),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300], thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                color: AppColors.primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Day 1',
                              style: AppTextStyles.subheading.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildGroceryGrid(day: 'Day 1'),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300], thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                color: AppColors.primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Day 2',
                              style: AppTextStyles.subheading.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildGroceryGrid(day: 'Day 2'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Grocery List Grid
  Widget _buildGroceryGrid({required String day}) {
    List<Map<String, String>> groceryItemsDay1 = [
      {'name': 'Berries', 'icon': 'assets/icons/berry.png'},
      {'name': 'Almond Milk', 'icon': 'assets/icons/milk.png'},
      {'name': 'Chia Seeds', 'icon': 'assets/icons/seeds.png'},
      {'name': 'Salmon', 'icon': 'assets/icons/salmon.png'},
      {'name': 'Broccoli', 'icon': 'assets/icons/barcoli.png'},
      {'name': 'Garlic', 'icon': 'assets/icons/garlic.png'},
      {'name': 'Lemon', 'icon': 'assets/icons/lemon.png'},
      {'name': 'Tomato', 'icon': 'assets/icons/tomato.png'},
      {'name': 'Pumpkin', 'icon': 'assets/icons/pumpkin.png'},
    ];

    List<Map<String, String>> groceryItemsDay2 = [
      {'name': 'Spinach', 'icon': 'assets/icons/spinach.png'},
      {'name': 'Olive Oil', 'icon': 'assets/icons/olive.png'},
      {'name': 'Chicken Breast', 'icon': 'assets/icons/chicken.png'},
      {'name': 'Avocado', 'icon': 'assets/icons/avocado.png'},
      {'name': 'Walnuts', 'icon': 'assets/icons/wallnuts.png'},
      {'name': 'Eggs', 'icon': 'assets/icons/egg.png'},
    ];

    List<Map<String, String>> items =
        day == 'Day 1' ? groceryItemsDay1 : groceryItemsDay2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              items[index]['icon']!,
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 8),
            Text(
              items[index]['name']!,
              style: AppTextStyles.normalText
                  .copyWith(fontSize: 14, color: AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  void _showRecipeDialog(BuildContext context, HomeVm p, RecipeModel data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<HomeVm>(builder: (context, p2, c) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.7, // Adjust width
              width: MediaQuery.of(context).size.width * 0.8, // Adjust width
              color: Colors.white, // White background for the popup
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and close button
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lentil and Vegetable Stew',
                            style: AppTextStyles.heading.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(color: Colors.grey[300], thickness: 1),
                    ),

                    // Image
                    // Image.asset(
                    //   'assets/breakfast.png',
                    //   height: 200,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover, // Ensures the image takes the full width
                    // ),

                    // Ingredients Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🧾 Ingredients',
                            style: AppTextStyles.subheading.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // _buildIngredientsGrid(),

                          SizedBox(
                              height: p2.showAllIngradientsInPopUp ? 100 : null,
                              child: Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: data.ingredients.map((e) {
                                    return Chip(
                                        label: Text(
                                          e.ingredient.name,
                                          style:
                                              AppTextStyles.subheading.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            side: const BorderSide(
                                                color:
                                                    AppColors.primaryColor)));
                                  }).toList())),
                          // Ingredients grid (same as before)
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton.icon(
                              icon: p2.showAllIngradientsInPopUp
                                  ? const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white)
                                  : const Icon(Icons.keyboard_arrow_up,
                                      color: Colors.white),
                              onPressed: () {
                                p2.setShowAllIngradientsInPopUpF();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              label: Text('Show all',
                                  style: AppTextStyles.buttonText
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Preparation Section
                          Text(
                            '📝 Preparation',
                            style: AppTextStyles.subheading.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 200,
                            child: Column(
                              children: data.preparationSteps
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var item = entry.value;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: AppTextStyles.normalText.copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    ...item.points.map((e) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "• $e",
                                          style: AppTextStyles.normalText,
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

// Widget for Ingredients Grid
  Widget _buildIngredientsGrid() {
    List<Map<String, String>> ingredients = [
      {'name': 'Lentils', 'quantity': '1 Cup Rinsed'},
      {'name': 'Onion', 'quantity': '1 Diced'},
      {'name': 'Carrots', 'quantity': '2 Sliced'},
      {'name': 'Celery', 'quantity': '2 Stalks Sliced'},
      {'name': 'Garlic', 'quantity': '2 Cloves Minced'},
      {'name': 'Zucchini', 'quantity': '1 Diced'},
    ];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ingredients.map((ingredient) {
        return Chip(
          label: Row(
            children: [
              Text(
                ingredient['name']!,
                style: AppTextStyles.subheading.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ingredient['quantity']!,
                style: AppTextStyles.normalText.copyWith(color: Colors.grey),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        );
      }).toList(),
    );
  }
}
