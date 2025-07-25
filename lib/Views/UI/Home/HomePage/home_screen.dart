import 'package:anti_inflammatory_app/Controllers/authVm.dart';
import 'package:anti_inflammatory_app/storage/userstorage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../Controllers/homevm.dart';
import '../../../../Utils/colors.dart';
import '../../../../Utils/text_styles.dart';
import '../../Auth/profile.dart';
import '../../Bottom_NavigationBar/bottomNav.dart';
import '../aboutus.dart';
import 'Flares/flares.dart';
import 'Recipies/recipie.dart';
import 'Supps/supplements.dart';
import 'referrals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<HomeVm>(context).levels(context);
    await Provider.of<HomeVm>(context, listen: false).getAchiveGoalsF(context);
    // await Provider.of<HomeVm>(context, listen: false).getAchiveGoalsF(context);
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<HomeVm>(builder: (context, p, child) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Text(
            'InflamEase',
            style: AppTextStyles.heading.copyWith(
              fontSize: screenWidth * 0.06,
              color: AppColors.primaryColor, // Ensuring the title color matches
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: AppColors.primaryColor),
              // Menu icon
              onPressed: () {
                // Open the drawer when menu icon is tapped
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          centerTitle: true,
        ),
        // Drawer for Side Menu
        drawer: _buildSideMenu(),
        // Add the custom drawer here
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tabs Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: _buildTabButton(
                            'Recipes', Icons.restaurant, false)),
                    Flexible(
                        child: _buildTabButton(
                            'Flares', Icons.local_fire_department, false)),
                    Flexible(
                        child: _buildTabButton(
                            'Supps', Icons.medical_services, false)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                // Points Overview Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPointsCard(
                        'Food Points', '${p.level!.points}', 'Daily'),
                    const SizedBox(width: 12),
                    _buildPointsCard(
                        'All Points',
                        '${int.parse(p.level!.points.toString()) + int.parse(p.level!.goal.toString())}',
                        'Weekly'),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                // Level Progress Section
                Text(
                  'Level ${p.level!.level?.current}',
                  style: AppTextStyles.heading.copyWith(
                    fontSize: screenWidth * 0.05,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                _buildLevelProgress(p),
                SizedBox(height: screenHeight * 0.03),
                // Complete Goals Section
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.02),
                  ),
                  child: Text('Complete Goals',
                      style: AppTextStyles.buttonText
                          .copyWith(color: Colors.white)),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Go to your goals to earn more points!',
                  style: AppTextStyles.normalText
                      .copyWith(color: AppColors.primaryColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                // Health Goal Section
                // _buildHealthGoalCard(),
                p.achiveGoals.isEmpty
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
                        itemCount: p.achiveGoals.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = p.achiveGoals[index];
                          return _buildAdditionalGoalCard(
                              data.goal.name,
                              data.goal.objective,
                              '${data.goal.points}%',
                              Icons.restaurant,
                              AppColors.primaryColor);
                        },
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 0, // Set the initial index based on the current page
          onTap: (index) {
            // Handle the tab change
            if (index == 0) {
              Get.toNamed('/home'); // Navigate to Home
            } else if (index == 1) {
              Get.toNamed('/goals'); // Navigate to Goals
            } else if (index == 2) {
              Get.toNamed('/settings'); // Navigate to Settings
            }
          },
        ),
      );
    });
  }

  // Method to build the side menu
  Widget _buildSideMenu() {
    return Drawer(
      child: Consumer<AuthVm>(builder: (context, p, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryColor)
                  .copyWith(borderRadius: BorderRadius.circular(10))
                  .copyWith(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ], // BoxShadow
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.to(const ProfilePage());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          size: 30, color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Text(p.user!.name,
                        style: AppTextStyles.heading
                            .copyWith(color: Colors.white)),
                    Text(p.user!.email.toString(),
                        style: AppTextStyles.normalText
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
            // _buildDrawerItem(
            //     Icons.person, 'Profile', () => Get.to(const ProfilePage())),
            _buildDrawerItem(Icons.flag, 'Goals', () => Get.toNamed('/goals')),
            _buildDrawerItem(
                Icons.settings, 'Settings', () => Get.toNamed('/settings')),
            _buildDrawerItem(Icons.search, 'Food Search', () {}),
            _buildDrawerItem(Icons.shopping_bag, 'Referrals', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ReferralsPage();
              }));
            }),
            _buildDrawerItem(Icons.shopping_bag, 'Supplement Affiliates', () {
              Get.to(() => const Supplements());
            }),
            _buildDrawerItem(Icons.local_fire_department, 'Flare Recording',
                () => Get.to(() => const FlaresScreen())),
            _buildDrawerItem(Icons.restaurant, 'Recipes',
                () => Get.to(() => const RecipesScreen())),
            _buildDrawerItem(
                Icons.book, 'Meal Diary', () => Get.toNamed('/meal')),
            _buildDrawerItem(Icons.home, 'Home', () => Get.toNamed('/home')),
            _buildDrawerItem(Icons.info, 'About Us', () {
              Get.to(const AboutUsPage());
            }),
            _buildDrawerItem(Icons.exit_to_app, 'Logout', () async {
              await UserStorage.clear();
              Get.toNamed('/login');
            }),
          ],
        );
      }),
    );
  }

  // Helper function for building drawer items
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentColor),
      title: Text(title,
          style:
              AppTextStyles.subheading.copyWith(color: AppColors.blackColor)),
      onTap: onTap,
    );
  }

  Widget _buildTabButton(String title, IconData icon, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        // Handle tab change
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

  Widget _buildPointsCard(String title, String points, String period) {
    return Expanded(
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(points,
                style: AppTextStyles.heading
                    .copyWith(color: AppColors.primaryColor)),
            const SizedBox(height: 4),
            Text(title, style: AppTextStyles.subheading),
            Text(period,
                style: AppTextStyles.normalText.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelProgress(HomeVm p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Your Points: ${p.level!.points} points',
            style: AppTextStyles.subheading
                .copyWith(color: AppColors.accentColor)),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.center,
          children: [
            // Background Circle
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            // Circular Progress Indicator
            SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                    value: p.level != null && p.level!.level != null
                        ? (double.parse(
                                    p.level!.level!.needed.toString().isEmpty
                                        ? "1"
                                        : p.level!.level!.needed.toString()) -
                                100.0) /
                            100.0
                        : 1.00,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor))),
            // Progress Text in the Center
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '${p.level != null && p.level!.level != null ? (double.parse(p.level!.level!.needed.toString().isEmpty ? "1" : p.level!.level!.needed.toString()) - 100.0) / 100.0 : 1.00}%',
                    style: AppTextStyles.heading
                        .copyWith(fontSize: 20, color: AppColors.primaryColor)),
                const SizedBox(height: 4),
                Text('Level ${p.level!.level?.current}',
                    style: AppTextStyles.normalText
                        .copyWith(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Next level at: ${p.level!.level?.next} points',
            style: AppTextStyles.normalText),
      ],
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
}
