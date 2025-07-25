import 'package:anti_inflammatory_app/Utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../Controllers/homevm.dart';
import '../../../../../Utils/colors.dart'; // Assuming these are your defined color constants
import '../../../../../Utils/text_styles.dart';
import 'addmeal.dart'; // Assuming these are your defined text styles

class MealDiaryScreen extends StatefulWidget {
  const MealDiaryScreen({super.key});

  @override
  _MealDiaryScreenState createState() => _MealDiaryScreenState();
}

class _MealDiaryScreenState extends State<MealDiaryScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<HomeVm>(context, listen: false).getCountPointsF(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<HomeVm>(builder: (context, p, c) {
      return Scaffold(
        backgroundColor: Colors.white,
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
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Calendar
                _buildCalendar(),
                const SizedBox(height: 20),

                // Meal buttons (Edit Breakfast, Lunch, Snack, Dinner)
                Row(children: [
                  _buildMealButton(
                      onTap: () {
                        Get.to(() => AddMealPage(
                              selectedCal: "Breakfast",
                              selectedDate: "$_selectedDay",
                              isFromAddMeal: true,
                            ));
                      },
                      title: "Breakfast",
                      subTitle: "Edit",
                      calories: "300",
                      assetPath: "assets/breakfast.png"),
                  _buildMealButton(
                    onTap: () {
                      Get.to(() => AddMealPage(
                            selectedCal: "Lunch",
                            selectedDate: "$_selectedDay",
                            isFromAddMeal: true,
                          ));
                    },
                    title: "Lunch",
                    subTitle: "Edit",
                    calories: "435",
                    assetPath: "assets/lunch.png",
                  ),
                  _buildMealButton(
                    onTap: () {
                      Get.to(() => AddMealPage(
                            selectedCal: "Snack",
                            selectedDate: "$_selectedDay",
                            isFromAddMeal: true,
                          ));
                    },
                    title: "Snack",
                    subTitle: "Add",
                    calories: "000",
                    assetPath: "assets/supps1.png",
                  ),
                  _buildMealButton(
                    onTap: () {
                      Get.to(() => AddMealPage(
                            selectedCal: "Dinner",
                            selectedDate: "$_selectedDay",
                            isFromAddMeal: true,
                          ));
                    },
                    title: "Dinner",
                    subTitle: "Add",
                    calories: "000",
                    assetPath: "assets/dinner.png",
                  ),
                ]),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Daily Points Count",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Points and Calories Information
                _buildDailyPointsCard(p),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Calendar Widget
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        // snackBarColorF("$_selectedDay", context);
      },
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: AppTextStyles.heading.copyWith(
          fontSize: 16,
          color: AppColors.primaryColor,
        ),
        leftChevronIcon:
            const Icon(Icons.chevron_left, color: AppColors.primaryColor),
        rightChevronIcon:
            const Icon(Icons.chevron_right, color: AppColors.primaryColor),
      ),
      calendarStyle: const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.accentColor,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: AppTextStyles.normalText,
      ),
    );
  }

  // Meal Buttons Section
  Widget _buildMealButton({
    required String title,
    required String subTitle,
    required String calories,
    required String assetPath,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
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
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                children: [
                  SizedBox(
                      height: 40,
                      width: 62,
                      child: Image.asset(
                        assetPath,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "$calories kcal",
              style: AppTextStyles.normalText.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // // Individual Meal Button with Calorie Information
  // Widget buildMealButtons(String title, String calories, String assetPath) {
  //   return Expanded(
  //     child: Column(
  //       children: [
  //         ElevatedButton(
  //           onPressed: () {
  //             // Handle meal edit/add functionality here
  //           },
  //           style: ElevatedButton.styleFrom(
  //             padding: const EdgeInsets.symmetric(vertical: 12),
  //             backgroundColor: AppColors.primaryColor,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8)),
  //           ),
  //           child: Column(
  //             children: [
  //               Text(title,
  //                   style:
  //                       AppTextStyles.buttonText.copyWith(color: Colors.white)),
  //               Text(calories,
  //                   style:
  //                       AppTextStyles.normalText.copyWith(color: Colors.white)),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Daily Points Information Section
  Widget _buildDailyPointsCard(HomeVm p) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today Points',
                  style: AppTextStyles.subheading
                      .copyWith(color: AppColors.primaryColor)),
              Text(
                  '${int.parse(p.countPonits.goal) + int.parse(p.countPonits.meal)} pts.',
                  style: AppTextStyles.heading
                      .copyWith(color: AppColors.accentColor)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Food: ${p.countPonits.meal} pts.',
                  style: AppTextStyles.normalText),
              Text('Goals: ${p.countPonits.goal} pts.',
                  style: AppTextStyles.normalText),
            ],
          ),
        ],
      ),
    );
  }
}
