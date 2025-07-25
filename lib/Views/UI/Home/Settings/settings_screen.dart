import 'package:anti_inflammatory_app/Controllers/authVm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../Utils/colors.dart';
import '../../../../Utils/text_styles.dart';
import '../../../../storage/userstorage.dart';
import '../../Auth/profile.dart'; // Assuming LoginScreen exists for logout

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<AuthVm>(builder: (context, p, c) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Text(
            'Configuration',
            style: AppTextStyles.heading.copyWith(
              fontSize: screenWidth * 0.06,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.primaryColor),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildUserProfile(p, context),
              SizedBox(height: screenHeight * 0.03),
              _buildAccountSection(context),
              SizedBox(height: screenHeight * 0.02),
              _buildPrivacySecuritySection(),
              SizedBox(height: screenHeight * 0.02),
              _buildPreferencesSection(),
            ],
          ),
        ),
      );
    });
  }

  // User Profile Section
  Widget _buildUserProfile(AuthVm p, BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: const Icon(Icons.person,
                  size: 30, color: AppColors.primaryColor)),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${p.user?.name}',
                style: AppTextStyles.subheading
                    .copyWith(color: AppColors.primaryColor)),
            Text('${p.user?.email}',
                style: AppTextStyles.normalText.copyWith(color: Colors.grey))
          ])
        ]),
        OutlinedButton(
            onPressed: () {
              Get.to(const ProfilePage());
            },
            child: const Text("Update",
                style: TextStyle(color: AppColors.primaryColor)))
      ]),
      const SizedBox(height: 16),
      const Divider(thickness: 1.2),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
            onPressed: () {}, // Add functionality
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            child: const Text('Notifications',
                style: TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: () async {
              await UserStorage.clear();
              Get.toNamed('/login');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            child: const Text('Log Out', style: TextStyle(color: Colors.white)))
      ])
    ]);
  }

  // Account Section
  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style:
              AppTextStyles.subheading.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 8),
        _buildListTile('Personal Information', Icons.arrow_forward_ios),
        _buildListTile('Country', Icons.location_on_outlined),
        _buildListTile('Language', Icons.language),
      ],
    );
  }

  // Privacy and Security Section
  Widget _buildPrivacySecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy and Security',
          style:
              AppTextStyles.subheading.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 8),
        _buildListTile('Help Center', Icons.help_outline),
        SwitchListTile(
          contentPadding: const EdgeInsets.only(),
          title: const Text(
            'Private Account',
            style: AppTextStyles.normalText,
          ),
          value: true,
          activeColor: AppColors.primaryColor,
          onChanged: (bool newValue) {},
        ),
        _buildListTile('Terms & Conditions', Icons.article_outlined),
      ],
    );
  }

  // Preferences Section
  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferences',
          style:
              AppTextStyles.subheading.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: const EdgeInsets.only(),
          title: const Text('Something', style: AppTextStyles.normalText),
          value: false,
          onChanged: (bool newValue) {},
        ),
        SwitchListTile(
          contentPadding: const EdgeInsets.only(),
          title: const Text('Something Else', style: AppTextStyles.normalText),
          value: false,
          onChanged: (bool newValue) {},
        ),
      ],
    );
  }

  // Helper method for ListTiles
  Widget _buildListTile(String title, IconData trailingIcon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: AppTextStyles.normalText),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(trailingIcon, size: 25, color: AppColors.primaryColor),
      ),
      onTap: () {
        // Handle navigation here
      },
    );
  }
}
