import 'package:anti_inflammatory_app/Controllers/homevm.dart';
import 'package:anti_inflammatory_app/Views/UI/Home/HomePage/Flares/readflare.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/text_styles.dart';
import '../../../../../loader.dart';
import '../Recipies/recipie.dart';
import '../Supps/supplements.dart';

class FlaresScreen extends StatefulWidget {
  const FlaresScreen({super.key});

  @override
  State<FlaresScreen> createState() => _FlaresScreenState();
}

class _FlaresScreenState extends State<FlaresScreen> {
  TextEditingController dateSelectorController =
      TextEditingController(text: DateTime.now().toString());
  TextEditingController notesController = TextEditingController();
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<HomeVm>(context, listen: false).getFlaresF(context);
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
              title: Text('InflamEase',
                  style: AppTextStyles.heading.copyWith(
                      fontSize: screenWidth * 0.06,
                      color: AppColors.primaryColor)),
              centerTitle: true,
              actions: [
                IconButton(
                    icon:
                        const Icon(Icons.person, color: AppColors.primaryColor),
                    onPressed: () {})
              ]),
          body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTopTabs(screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildInflammatoryFlareSection(
                            p, screenWidth, screenHeight, context),
                        SizedBox(height: screenHeight * 0.03),
                        Text(
                          'Previous Flares',
                          style: AppTextStyles.subheading.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        p.isLoading
                            ? const SizedBox(
                                width: 4,
                                height: 40,
                                child: ThreeBounceLoader())
                            : _buildPreviousFlares(p, screenWidth)
                      ]))));
    });
  }

  // Top Tabs: Recipes, Flares (selected), Supps
  Widget _buildTopTabs(double screenWidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(child: _buildTabButton('Recipes', Icons.restaurant, false)),
      Flexible(
          child: _buildTabButton('Flares', Icons.local_fire_department, true)),
      Flexible(child: _buildTabButton('Supps', Icons.medical_services, false))
    ]);
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
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon,
              color: isSelected ? Colors.white : AppColors.primaryColor,
              size: 16),
          const SizedBox(width: 4),
          Text(title,
              style: AppTextStyles.buttonText.copyWith(
                  color: isSelected ? Colors.white : AppColors.primaryColor))
        ]));
  }

  // Inflammatory Flare Section
  Widget _buildInflammatoryFlareSection(
      HomeVm p, double screenWidth, double screenHeight, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Inflammatory Flare',
            style: AppTextStyles.heading.copyWith(
                fontSize: screenWidth * 0.05, color: AppColors.primaryColor)),
        ElevatedButton.icon(
            onPressed: () {
              _showCalendarDialog(context, p);
            },
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            label:
                const Text('Calendar', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10)))
      ]),
      SizedBox(height: screenHeight * 0.02),
      TextFormField(
          controller: dateSelectorController,
          decoration: InputDecoration(
              labelText: 'Date Selector:',
              labelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              suffixIcon: const Icon(Icons.calendar_today,
                  color: AppColors.accentColor),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8)),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8)))),
      SizedBox(height: screenHeight * 0.03),
      Text('Symptom Severity Scale',
          style:
              AppTextStyles.subheading.copyWith(color: AppColors.primaryColor)),
      SizedBox(height: screenHeight * 0.04),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _buildSeverityButton(
          context,
          p,
          icon: Icons.emoji_emotions_outlined,
          title: 'Mild',
          desc: 'Low: 1-3',
        ),
        _buildSeverityButton(
          context,
          p,
          icon: Icons.sentiment_satisfied,
          title: 'Moderate',
          desc: 'Low: 4-6',
        ),
        _buildSeverityButton(
          context,
          p,
          icon: Icons.sentiment_very_dissatisfied_sharp,
          title: 'Severe',
          desc: 'Low: 7-10',
        ),
      ]),
      SizedBox(height: screenHeight * 0.03),
      TextFormField(
          controller: notesController,
          decoration: InputDecoration(
              labelText: 'Notes',
              labelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              hintText: 'What do you feel?',
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          maxLines: 4),
      SizedBox(height: screenHeight * 0.02),
      ElevatedButton(
          onPressed: () {
            p.setFlaresF(context, notes: notesController.text);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: p.isBtnLoading
              ? const CircularProgressIndicator.adaptive(
                  strokeWidth: 1, backgroundColor: Colors.white)
              : const Text('SAVE', style: TextStyle(color: Colors.white)))
    ]);
  }

  // Severity Scale Button Widget
  Widget _buildSeverityButton(context, HomeVm p,
      {IconData icon = Icons.emoji_emotions,
      String title = "",
      String desc = ""}) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.27,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Transform.translate(
                      offset: const Offset(0, -30),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Icon(icon,
                                color: AppColors.primaryColor, size: 35),
                          ))),
                  const SizedBox(height: 4),
                  Text(title,
                      style: AppTextStyles.subheading
                          .copyWith(color: Colors.black)),
                  Text(desc,
                      style: AppTextStyles.normalText
                          .copyWith(color: Colors.grey)),
                ],
              ),
            )),
        const SizedBox(height: 5),
        // Text(p.emojiNameIs),
        Container(
          decoration: BoxDecoration(
              color: p.emojiNameIs == title
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(8)),
          width: MediaQuery.of(context).size.width * 0.27,
          child: TextButton(
            onPressed: () {
              p.chooseEmojiF(emojiName: title);
            },
            child: const Text('Pick',
                style: TextStyle(color: AppColors.primaryColor)),
          ),
        )
      ],
    );
  }

  // Previous Flares Section
  Widget _buildPreviousFlares(HomeVm p, double screenWidth) {
    return ListView.builder(
      itemCount: p.flares.length,
      shrinkWrap: true,
      controller: ScrollController(),
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var data = p.flares[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department,
                      color: AppColors.primaryColor, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.date}',
                            style: AppTextStyles.subheading
                                .copyWith(color: AppColors.primaryColor)),
                        Text(data.notes,
                            style: AppTextStyles.normalText
                                .copyWith(color: Colors.grey)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadFlarePage(
                                description: data.notes,
                                symtoms: data.sovereignty,
                                date: data.date.toString()),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Read notes',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show calendar dialog
  void _showCalendarDialog(BuildContext context, HomeVm p) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<HomeVm>(builder: (context, p2, c) {
            return AlertDialog(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.white, // Set background to white
                content: SizedBox(
                    height: 600, // Fixed height for the dialog
                    width: 500, // Fixed width for the dialog
                    child: SingleChildScrollView(
                        // Make the content scrollable
                        controller: ScrollController(),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          _buildCalendarHeader(context),
                          // Text("${p2.selectedDateForFlares}"),
                          const Padding(
                              padding: EdgeInsets.only(left: 13, right: 13),
                              child: Divider(
                                  color: AppColors.primaryColor, thickness: 2)),
                          TableCalendar(
                            firstDay: DateTime.utc(2024, 1, 1),
                            lastDay: DateTime.now()
                                .toUtc()
                                .add(const Duration(days: 5)),
                            focusedDay: p2.selectedDateForFlares,
                            currentDay: p2.selectedDateForFlares,
                            calendarStyle: const CalendarStyle(
                                todayDecoration: BoxDecoration(
                                    color: AppColors.accentColor,
                                    shape: BoxShape.circle),
                                selectedDecoration: BoxDecoration(
                                    color: AppColors.accentColor,
                                    shape: BoxShape.circle)),
                            headerStyle: const HeaderStyle(
                                titleCentered: true,
                                formatButtonVisible: false),
                            onDaySelected: (selectedDay, focusedDay) {
                              debugPrint(
                                  "${selectedDay.toString()}, $focusedDay");
                              p2.saveSelectedDateForFlares(selectedDay);
                              p2.getFlaresF(context,
                                  isLoad: false,
                                  searchDate:
                                      '${selectedDay.year}-${selectedDay.month}-${selectedDay.day}');
                              setState(() {});
                            },
                          ),
                          Divider(color: Colors.grey[300]),
                          const Row(children: [
                            Text('   This month\'s flares',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ]),
                          const SizedBox(height: 10),
                          p2.flaresByDate.isEmpty
                              ? const Text('No flares',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16))
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: ListView.builder(
                                      itemCount: p2.flaresByDate.length,
                                      shrinkWrap: true,
                                      controller: ScrollController(),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var data = p2.flaresByDate[index];
                                        return InkWell(
                                          onTap: () {
                                            Get.to(ReadFlarePage(
                                              description: data.notes,
                                              symtoms: data.sovereignty,
                                              date: data.date.toString(),
                                            ));
                                          },
                                          child: Column(children: [
                                            Divider(color: Colors.grey[300]),
                                            _buildFlareItem(
                                                '${data.date.toLocal()}',
                                                data.sovereignty,
                                                data.notes)
                                          ]),
                                        );
                                      }))
                        ]))));
          });
        });
  }

  // Build the Calendar Header with Close (Cross) Button
  Widget _buildCalendarHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Calendar',
            style: AppTextStyles.heading.copyWith(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColors.accentColor,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }

  // Widget to build individual flare items in the list
  Widget _buildFlareItem(String day, String severity, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            severity,
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            description,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
