import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../Controllers/authVm.dart';
import '../../../../Utils/colors.dart';
import '../../../../Utils/text_styles.dart';
import 'package:provider/provider.dart';

class ReferralsPage extends StatelessWidget {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          'Referrals',
          style: AppTextStyles.heading.copyWith(
              color: AppColors.blackColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [_buildReferralSection(context, screenWidth)],
        ),
      ),
    );
  }

  // Referral Section
  Widget _buildReferralSection(
    context,
    double screenWidth,
  ) {
    var user = Provider.of<AuthVm>(context).user;
    TextEditingController referController = TextEditingController(
        text: user!.referral.isEmpty ? user.id : user.referral);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Refer to others & Get Free recipes!',
          style: AppTextStyles.subheading.copyWith(
              color: AppColors.blackColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: referController,
          // enabled: false,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Referral Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: InkWell(
                  onTap: () async {
                    await Share.share(referController.text.toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                          child: Text(
                        "Share",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ))),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildReferralOption(screenWidth, '1 Recipe', 'after you refer 10'),
            _buildReferralOption(
                screenWidth, '10 Recipes', 'after you refer 20'),
            _buildReferralOption(
                screenWidth, '20 Recipes', 'after you refer 50'),
          ],
        ),
      ],
    );
  }

  // Referral Option Card
  Widget _buildReferralOption(screenWidth, String title, String subtitle) {
    return Container(
      width: screenWidth * 0.3,
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(title,
                style: AppTextStyles.heading
                    .copyWith(fontSize: 14, color: AppColors.primaryColor)),
          ),
          Center(
            child: Text(subtitle,
                style: AppTextStyles.normalText
                    .copyWith(color: Colors.grey, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
