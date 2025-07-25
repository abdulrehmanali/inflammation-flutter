import 'package:anti_inflammatory_app/Controllers/homevm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/text_styles.dart';
import '../Recipies/recipie.dart';
import '../Flares/flares.dart';

class Supplements extends StatefulWidget {
  const Supplements({super.key});

  @override
  State<Supplements> createState() => _SupplementsState();
}

class _SupplementsState extends State<Supplements> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<HomeVm>(context, listen: false).getSuplements(context);
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopTabs(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildSearchAndFilter(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildProductsGrid(screenWidth), // GridView placed here
              SizedBox(height: screenHeight * 0.02),
              // _buildShowAllButton(),
            ],
          ),
        ),
      );
    });
  }

  // Top Tabs: Recipes, Flares, Supps (selected)
  Widget _buildTopTabs(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _buildTabButton('Recipes', Icons.restaurant, false)),
        Flexible(
            child:
                _buildTabButton('Flares', Icons.local_fire_department, false)),
        Flexible(child: _buildTabButton('Supps', Icons.medical_services, true)),
      ],
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
              color: isSelected ? Colors.white : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Search and Filter Section
  Widget _buildSearchAndFilter(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ElevatedButton(
                  onPressed: () async {
                    await Provider.of<HomeVm>(context, listen: false)
                        .getSuplementsBySearch(context,
                            searchText: searchController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 1.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  child: const Text(
                    '  Filter  ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Products Grid View
  Widget _buildProductsGrid(double screenWidth) {
    List<Map<String, String>> products = [
      {
        'title': 'Vitamin D',
        'description': 'Bone & body health',
        'image': 'assets/supps1.png'
      },
      {
        'title': 'Zinc',
        'description': 'Rises immune defenses',
        'image': 'assets/supps2.png'
      },
      {
        'title': 'CoQ10',
        'description': 'Heart health & fatigue',
        'image': 'assets/supps1.png'
      },
      {
        'title': 'Vitamin C',
        'description': 'Boosts immunity',
        'image': 'assets/supps2.png'
      },
      {
        'title': 'Magnesium',
        'description': 'Supports muscle function',
        'image': 'assets/supps1.png'
      },
      {
        'title': 'Omega 3',
        'description': 'Supports heart health',
        'image': 'assets/supps2.png'
      },
    ];

    return Expanded(
      child: Consumer<HomeVm>(builder: (context, p, c) {
        return p.isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                backgroundColor: AppColors.primaryColor,
              ))
            : GridView.builder(
                itemCount: p.suplements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = p.suplements[index];
                  return _buildProductCard(product.title, product.subTitle,
                      product.image, product.link);
                },
              );
      }),
    );
  }

  // Build each product card
  Widget _buildProductCard(
      String title, String description, String imagePath, String link) {
    return Container(
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
      ),
      child: InkWell(
        onTap: () async {
          // navigate to site
          try {
            await launchUrl(Uri.parse(link));
          } catch (e) {
            debugPrint("💥 Error url can not open : $e");
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString().length > 8
                        ? '${title.toString().substring(0, 8)}..'
                        : title.toString(),
                    style: AppTextStyles.subheading
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    description.toString().length > 20
                        ? '${description.toString().substring(0, 20)}...'
                        : description.toString(),
                    style:
                        AppTextStyles.normalText.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show All Button
  Widget _buildShowAllButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(
          'Show all',
          style: AppTextStyles.buttonText.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
