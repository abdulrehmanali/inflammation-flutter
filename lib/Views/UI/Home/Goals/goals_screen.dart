// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../Utils/colors.dart';
// import '../../../../Utils/text_styles.dart';
// import '../../Bottom_NavigationBar/bottomNav.dart';
//
// class GoalsScreen extends StatelessWidget {
//   const GoalsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         elevation: 0,
//         title: Text(
//           'InflamEase',
//           style: AppTextStyles.heading.copyWith(
//             fontSize: screenWidth * 0.06,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings, color: AppColors.primaryColor),
//             onPressed: () {},
//           ),
//         ],
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // User Info Section
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 25,
//                     backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//                     child: const Icon(Icons.person,
//                         color: AppColors.primaryColor, size: 30),
//                   ),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'How is it going?',
//                         style: AppTextStyles.normalText
//                             .copyWith(color: Colors.grey),
//                       ),
//                       Text(
//                         'User Full Name',
//                         style: AppTextStyles.subheading
//                             .copyWith(color: AppColors.primaryColor),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.03),
//
//               // Goals Section
//               Text(
//                 'Your Goals',
//                 style: AppTextStyles.heading
//                     .copyWith(color: AppColors.accentColor),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildGoalCard('Calorie Limit', '3450 a day',
//                       Icons.local_fire_department, AppColors.accentColor),
//                   _buildGoalCard('Drink Water', '13 L a day', Icons.local_drink,
//                       AppColors.accentColor),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.08,
//                       vertical: screenHeight * 0.02),
//                 ),
//                 child: Text('Set New Goal',
//                     style:
//                         AppTextStyles.buttonText.copyWith(color: Colors.white)),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//
//               // Points Overview Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildPointsCard('Food Points', '25', 'Daily'),
//                   _buildPointsCard('All Points', '500', 'Weekly'),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.03),
//
//               // Current Progress Section
//               Text(
//                 'Current Progress',
//                 style: AppTextStyles.subheading
//                     .copyWith(color: AppColors.primaryColor),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               _buildCurrentProgress(),
//               SizedBox(height: screenHeight * 0.03),
//
//               // Additional Goals or Tasks
//               _buildAdditionalGoalCard(
//                   'Homemade Meals',
//                   'You cooked 2 meals so far!',
//                   '50%',
//                   Icons.restaurant,
//                   AppColors.primaryColor),
//               _buildAdditionalGoalCard(
//                   'Drink Water',
//                   'You drank 7 liters so far!',
//                   '50%',
//                   Icons.local_drink,
//                   AppColors.primaryColor),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 1, // Set the initial index based on the current page
//         onTap: (index) {
//           // Handle the tab change
//           if (index == 0) {
//             Get.toNamed('/home'); // Navigate to Home
//           } else if (index == 1) {
//             Get.toNamed('/goals'); // Navigate to Goals
//           } else if (index == 2) {
//             Get.toNamed('/settings'); // Navigate to Settings
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildGoalCard(
//       String title, String subtitle, IconData icon, Color iconColor) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//           border: Border.all(color: AppColors.primaryColor, width: 1),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: iconColor, size: 30),
//             const SizedBox(height: 8),
//             Text(title,
//                 style: AppTextStyles.subheading
//                     .copyWith(color: AppColors.primaryColor)),
//             Text(subtitle,
//                 style: AppTextStyles.normalText.copyWith(color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPointsCard(String title, String points, String period) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           // gradient: LinearGradient(
//           //   colors: [AppColors.primaryColor.withOpacity(0.1), Colors.white],
//           //   begin: Alignment.topLeft,
//           //   end: Alignment.bottomRight,
//           // ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//           border: Border.all(color: AppColors.primaryColor, width: 1),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(points,
//                 style: AppTextStyles.heading
//                     .copyWith(color: AppColors.accentColor)),
//             const SizedBox(height: 4),
//             Text(title,
//                 style: AppTextStyles.subheading
//                     .copyWith(color: AppColors.primaryColor)),
//             Text(period,
//                 style: AppTextStyles.normalText.copyWith(color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCurrentProgress() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//         border: Border.all(color: AppColors.primaryColor, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             '720',
//             style:
//                 AppTextStyles.heading.copyWith(color: AppColors.primaryColor),
//           ),
//           Text(
//             'KCAL So far',
//             style: AppTextStyles.normalText.copyWith(color: Colors.grey),
//           ),
//           const SizedBox(height: 8),
//           _buildNutrientProgress('Carbs', '0 g', Colors.orange),
//           _buildNutrientProgress('Fat', '0 g', Colors.red),
//           _buildNutrientProgress('Protein', '0 g', Colors.green),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNutrientProgress(String title, String value, Color color) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(title, style: AppTextStyles.normalText),
//             Text(value, style: AppTextStyles.normalText),
//           ],
//         ),
//         const SizedBox(height: 4),
//         LinearProgressIndicator(
//           value: 0.0,
//           backgroundColor: Colors.grey[300],
//           valueColor: AlwaysStoppedAnimation<Color>(color),
//         ),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
//
//   Widget _buildAdditionalGoalCard(String title, String description,
//       String progress, IconData icon, Color iconColor) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColors.primaryColor, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: iconColor),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: AppTextStyles.subheading
//                         .copyWith(color: AppColors.primaryColor)),
//                 Text(description, style: AppTextStyles.normalText),
//               ],
//             ),
//           ),
//           const Spacer(),
//           Text(
//             progress,
//             style: AppTextStyles.heading.copyWith(color: AppColors.accentColor),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:anti_inflammatory_app/Controllers/authVm.dart';
import 'package:anti_inflammatory_app/Controllers/homevm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/colors.dart';
import '../../../../Utils/text_styles.dart';
import '../../Bottom_NavigationBar/bottomNav.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  void syncFirstF() async {
    await Provider.of<HomeVm>(context, listen: false).getAchiveGoalsF(context);
    await Provider.of<HomeVm>(context, listen: false).getMealsF(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<AuthVm>(builder: (context, p, c) {
      return Consumer<HomeVm>(builder: (context, p2, c) {
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
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: AppColors.primaryColor),
                onPressed: () {},
              ),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.1),
                        child: const Icon(Icons.person,
                            color: AppColors.primaryColor, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How is it going?',
                            style: AppTextStyles.normalText
                                .copyWith(color: Colors.grey),
                          ),
                          Text(
                            '${p.user?.name}',
                            style: AppTextStyles.subheading
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Goals',
                    style: AppTextStyles.heading
                        .copyWith(color: AppColors.accentColor),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildGoalCard('Calorie Limit', '3450 a day',
                          Icons.local_fire_department, AppColors.accentColor),
                      _buildGoalCard('Drink Water', '13 L a day',
                          Icons.local_drink, AppColors.accentColor),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      _showSetGoalDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08,
                          vertical: screenHeight * 0.02),
                    ),
                    child: Text('Set New Goal',
                        style: AppTextStyles.buttonText
                            .copyWith(color: Colors.white)),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPointsCard(
                          'Food Points', '${p2.level?.points}', 'Daily'),
                      _buildPointsCard(
                          'All Points',
                          '${int.parse(p2.level!.points.toString()) + 100}',
                          'Weekly'),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Progress',
                        style: AppTextStyles.subheading
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      Row(children: [
                        TextButton(
                            onPressed: () async {
                              await p2.getMealsF(context, weekly: false);
                            },
                            child: Text(
                              "Daily",
                              style: TextStyle(
                                  color:
                                      p2.isWeekly ? Colors.grey : Colors.red),
                            )),
                        TextButton(
                            onPressed: () async {
                              await p2.getMealsF(context, weekly: true);
                            },
                            child: Text(
                              "Weekly",
                              style: TextStyle(
                                  color:
                                      p2.isWeekly ? Colors.red : Colors.grey),
                            )),
                      ])
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildCurrentProgress(p2),
                  SizedBox(height: screenHeight * 0.03),
                  const Row(
                    children: [
                      Text(
                        "Achive Goals",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  p2.achiveGoals.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(11),
                          child: Text(
                            "No Goals Found",
                            style: TextStyle(fontSize: 20),
                          ),
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          physics: const BouncingScrollPhysics(),
                          itemCount: p2.achiveGoals.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = p2.achiveGoals[index];
                            return _buildAdditionalGoalCard(
                                data.goal.name,
                                data.goal.objective,
                                '${data.goal.points}%',
                                Icons.restaurant,
                                AppColors.primaryColor);
                          },
                        ),

                  // _buildAdditionalGoalCard(
                  //     'Drink Water',
                  //     'You drank 7 liters so far!',
                  //     '50%',
                  //     Icons.local_drink,
                  //     AppColors.primaryColor),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) {
                Get.toNamed('/home');
              } else if (index == 1) {
                Get.toNamed('/goals');
              } else if (index == 2) {
                Get.toNamed('/settings');
              }
            },
          ),
        );
      });
    });
  }

  // Popup dialog when "Set New Goal" button is clicked
  void _showSetGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Set New Goal',
                          style: AppTextStyles.heading.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Pick Pre-set Goals',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name Goal',
                        labelStyle: AppTextStyles.subheading
                            .copyWith(color: Colors.grey[600], fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Select Icon', style: AppTextStyles.subheading),
                    const SizedBox(height: 8),
                    _buildIconSelectionRow(),
                    const SizedBox(height: 16),
                    const Text('Objective', style: AppTextStyles.subheading),
                    const SizedBox(height: 8),
                    _buildObjectiveInputs(),
                    const SizedBox(height: 16),
                    const Text('Control', style: AppTextStyles.subheading),
                    const SizedBox(height: 8),
                    _buildControlButtons(),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('SAVE',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGoalCard(
      String title, String subtitle, IconData icon, Color iconColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
          border: Border.all(color: AppColors.primaryColor, width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(height: 8),
            Text(title,
                style: AppTextStyles.subheading
                    .copyWith(color: AppColors.primaryColor)),
            Text(subtitle,
                style: AppTextStyles.normalText.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelectionRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.local_drink, size: 40),
        Icon(Icons.photo_camera, size: 40),
        Icon(Icons.local_hospital, size: 40),
        Icon(Icons.alarm, size: 40),
        Icon(Icons.airplanemode_active, size: 40),
      ],
    );
  }

  Widget _buildObjectiveInputs() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Main Goal',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Times per week/day',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildControlButton('Percentage', Icons.pie_chart),
        _buildControlButton('Daily', Icons.calendar_today),
        _buildControlButton('Weekly', Icons.calendar_view_week),
      ],
    );
  }

  Widget _buildControlButton(String title, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 40, color: AppColors.primaryColor),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppTextStyles.subheading
              .copyWith(color: AppColors.primaryColor, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPointsCard(String title, String points, String period) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // gradient: LinearGradient(
          //   colors: [AppColors.primaryColor.withOpacity(0.1), Colors.white],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: AppColors.primaryColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(points,
                style: AppTextStyles.heading
                    .copyWith(color: AppColors.accentColor)),
            const SizedBox(height: 4),
            Text(title,
                style: AppTextStyles.subheading
                    .copyWith(color: AppColors.primaryColor)),
            Text(period,
                style: AppTextStyles.normalText.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalGoalCard(String title, String description,
      String progress, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.subheading
                        .copyWith(color: AppColors.primaryColor)),
                Text(description, style: AppTextStyles.normalText),
              ],
            ),
          ),
          const Spacer(),
          Text(
            progress,
            style: AppTextStyles.heading.copyWith(color: AppColors.accentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentProgress(HomeVm p2) {
    // var totalCalories = p2.getMealsList.fold(0, (total, meal) {
    //   return total +
    //       meal.meal!.recipe!.ingredients!.fold(0, (mealTotal, ingredient) {
    //         final kcal = int.parse(ingredient.ingredient!.kcal.toString());
    //         final carbs = ingredient.ingredient!.carbs;
    //         final fats = ingredient.ingredient!.fats;
    //         final protein = ingredient
    //             .ingredient!.protein; // Assuming protein is also a field
    //         return int.parse(mealTotal.toString()) +
    //             int.parse(kcal.toString()) +
    //             int.parse(carbs.toString()) +
    //             int.parse(fats.toString()) +
    //             int.parse(protein.toString());
    //       });
    // });
    var totalCalories = p2.getMealsList.fold(0, (total, meal) {
      return total +
          meal.meal!.recipe!.ingredients!.fold(0, (mealTotal, ingredient) {
            return int.parse(mealTotal.toString()) +
                int.parse(ingredient.ingredient!.kcal.toString());
          });
    });
    var totalCarbons = p2.getMealsList.fold(0, (total, meal) {
      return total +
          meal.meal!.recipe!.ingredients!.fold(0, (mealTotal, ingredient) {
            return int.parse(mealTotal.toString()) +
                int.parse(ingredient.ingredient!.carbs.toString());
          });
    });
    var totalFats = p2.getMealsList.fold(0, (total, meal) {
      return total +
          meal.meal!.recipe!.ingredients!.fold(0, (mealTotal, ingredient) {
            return int.parse(mealTotal.toString()) +
                int.parse(ingredient.ingredient!.fats.toString());
          });
    });
    var totalProteins = p2.getMealsList.fold(0, (total, meal) {
      return total +
          meal.meal!.recipe!.ingredients!.fold(0, (mealTotal, ingredient) {
            return int.parse(mealTotal.toString()) +
                int.parse(ingredient.ingredient!.protein.toString());
          });
    });
    return Container(
      padding: const EdgeInsets.all(16),
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
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '7$totalCalories',
            style:
                AppTextStyles.heading.copyWith(color: AppColors.primaryColor),
          ),
          Text(
            'KCAL So far',
            style: AppTextStyles.normalText.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          _buildNutrientProgress('Carbs', '$totalCarbons g', Colors.orange),
          _buildNutrientProgress('Fat', '$totalFats g', Colors.red),
          _buildNutrientProgress('Protein', '$totalProteins g', Colors.green),
        ],
      ),
    );
  }

  Widget _buildNutrientProgress(String title, String value, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.normalText),
            Text(value, style: AppTextStyles.normalText),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: 0.0,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
