import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/text_styles.dart';

class PurchaseRecipesScreen extends StatelessWidget {
  const PurchaseRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Tabs (Recipes, Flares, Supps)
              _buildTopTabs(screenWidth),
              const SizedBox(height: 20),

              // Purchase Recipes Header
              Text(
                'Purchase Recipes',
                style: AppTextStyles.heading.copyWith(
                  fontSize: screenWidth * 0.05,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Purchase Recipe List
              _buildRecipeCard(
                  'Name Salad',
                  '00 min | 000 kcal | 00 gr. of carbs',
                  'assets/breakfast.png'),
              const SizedBox(height: 16),
              _buildRecipeCard('Name Salad',
                  '00 min | 000 kcal | 00 gr. of carbs', 'assets/lunch.png'),
              const SizedBox(height: 16),
              _buildRecipeCard('Name Salad',
                  '00 min | 000 kcal | 00 gr. of carbs', 'assets/dinner.png'),
            ],
          ),
        ),
      ),
    );
  }

  // Top Tabs
  Widget _buildTopTabs(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTabButton('Recipes', Icons.restaurant, true),
        _buildTabButton('Flares', Icons.local_fire_department, false),
        _buildTabButton('Supps', Icons.medical_services, false),
      ],
    );
  }

  // Individual Tab Button
  Widget _buildTabButton(String title, IconData icon, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        // Tab navigation logic
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.accentColor : Colors.white,
        side: const BorderSide(color: AppColors.accentColor, width: 1.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? Colors.white : AppColors.primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTextStyles.buttonText.copyWith(
                color: isSelected ? Colors.white : AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  // Recipe Card
  Widget _buildRecipeCard(String title, String description, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Recipe Image
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Recipe Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.normalText
                          .copyWith(color: Colors.grey[700], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child:
                    const Text('View', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text('Purchase',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Bottom Navigation Bar
}
