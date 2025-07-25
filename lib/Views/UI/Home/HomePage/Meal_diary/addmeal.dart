import 'dart:io';

import 'package:anti_inflammatory_app/Controllers/homevm.dart';
import 'package:anti_inflammatory_app/Model/recipeModel.dart';
import 'package:anti_inflammatory_app/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/text_styles.dart';

class AddMealPage extends StatefulWidget {
  String selectedCal;
  String selectedDate;
  bool isFromAddMeal = false;
  AddMealPage(
      {super.key,
      this.selectedCal = "",
      this.selectedDate = "",
      this.isFromAddMeal = false});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final ImagePicker imgPicker = ImagePicker();
  String imgPath = "";

  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    await Provider.of<HomeVm>(context, listen: false).getRecipesF(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(builder: (context, p, c) {
      return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: AppColors.primaryColor,
          //   elevation: 0,
          //   leading: const Text(""),
          //   // leading: IconButton(
          //   //     icon: const Icon(
          //   //       Icons.arrow_back_ios,
          //   //       color: Colors.white,
          //   //     ),
          //   //     onPressed: () => Navigator.of(context).pop()),
          //   title: Text(
          //     'Add meal',
          //     style: AppTextStyles.heading
          //         .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          //   ),
          //   centerTitle: true,
          // ),
          body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Add meal',
                            style: AppTextStyles.heading.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: const Text(
                                            'Add Pre Existing Recipe'),
                                        content: Consumer<HomeVm>(
                                            builder: (context, p, c) {
                                          return SizedBox(
                                            width: 300,
                                            height: 300,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(),
                                              itemCount: p.recipes.length,
                                              itemBuilder: (context, index) {
                                                var recipe = p.recipes[index];
                                                return GestureDetector(
                                                    onTap: () {
                                                      p.selectRecipeIdIsForAddMealF(
                                                          recipe);
                                                      Navigator.pop(context);
                                                    },
                                                    child: CupertinoListTile(
                                                        leading: Image.network(
                                                          recipe.image,
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 2,
                                                                vertical: 4),
                                                        title:
                                                            Text(recipe.name)));
                                              },
                                            ),
                                          );
                                        }),
                                        actions: [
                                          CupertinoButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Close")),
                                        ],
                                        insetAnimationCurve: Curves.slowMiddle,
                                        insetAnimationDuration:
                                            const Duration(seconds: 2),
                                      );
                                    });
                              },
                              label: const Text(
                                "Pick Pre existing Recipe",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              "Add Your Own Recipe",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Row(
                          children: [
                            Icon(
                              Icons.menu_book_sharp,
                              color: Colors.red,
                            ),
                            Text(
                              " Ingradients",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: p.ingradientsList
                                    .map((e) => Chip(
                                        label: Text(e),
                                        deleteButtonTooltipMessage: 'Delete',
                                        onDeleted: () {
                                          p.removeIngradientsListF(e);
                                        },
                                        deleteIcon: const Icon(Icons.close,
                                            color: Colors.grey)))
                                    .toList()),
                            TextButton.icon(
                                icon: const Icon(Icons.add, color: Colors.red),
                                onPressed: () {
                                  TextEditingController
                                      ingradientsNameController =
                                      TextEditingController();
                                  showCupertinoDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return Consumer<HomeVm>(
                                            builder: (context, p2, c) {
                                          return CupertinoAlertDialog(
                                            title:
                                                const Text('Add Ingradients'),
                                            content: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                CupertinoTextField(
                                                  controller:
                                                      ingradientsNameController,
                                                  placeholder: "Ingradients",
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              CupertinoButton(
                                                  onPressed: () {
                                                    p2.addIngradientsListF(
                                                        ingradientsNameController
                                                            .text);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Save")),
                                            ],
                                            insetAnimationCurve:
                                                Curves.slowMiddle,
                                            insetAnimationDuration:
                                                const Duration(seconds: 2),
                                          );
                                        });
                                      });
                                },
                                label: const Text(
                                  "Add More",
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Row(
                          children: [
                            Icon(
                              Icons.cookie_rounded,
                              color: Colors.red,
                            ),
                            Text(
                              " Prepration",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              controller: ScrollController(),
                              itemBuilder: (BuildContext context, int index) {
                                var data = p.preprationList[index];
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data['title']}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: (data['points']! as List)
                                            .map((e) => Text(
                                                  "• $e",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ))
                                            .toList(),
                                      )
                                    ]);
                              }),
                        ),
                        TextButton.icon(
                            icon: const Icon(Icons.add, color: Colors.red),
                            onPressed: () {
                              TextEditingController preprationTitleController =
                                  TextEditingController();
                              TextEditingController preprationPointsController =
                                  TextEditingController();
                              showCupertinoDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return Consumer<HomeVm>(
                                        builder: (context, p2, c) {
                                      return CupertinoAlertDialog(
                                        title: const Text('Add Prepration'),
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: ListView(
                                            shrinkWrap: true,
                                            controller: ScrollController(),
                                            children: [
                                              const SizedBox(height: 10),
                                              CupertinoTextField(
                                                controller:
                                                    preprationTitleController,
                                                placeholder: "Title",
                                              ),
                                              const SizedBox(height: 10),
                                              CupertinoTextField(
                                                controller:
                                                    preprationPointsController,
                                                placeholder: "Points",
                                                suffix: IconButton(
                                                    onPressed: () {
                                                      p2.addPreprationPointsF(
                                                          preprationPointsController
                                                              .text);
                                                      preprationPointsController
                                                          .clear();
                                                    },
                                                    icon:
                                                        const Icon(Icons.add)),
                                              ),
                                              const SizedBox(height: 5),
                                              const Row(
                                                children: [
                                                  Text("Points"),
                                                ],
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: Wrap(
                                                    spacing: 5,
                                                    runSpacing: 5,
                                                    children: p2
                                                        .preprationPointsList
                                                        .map((e) => Chip(
                                                            label: Text(e),
                                                            deleteButtonTooltipMessage:
                                                                'Delete',
                                                            onDeleted: () {
                                                              p2.removePreprationPointsF(
                                                                  e);
                                                            },
                                                            deleteIcon:
                                                                const Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .grey)))
                                                        .toList()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          CupertinoButton(
                                              onPressed: () {
                                                p2.addPreprationF(
                                                    preprationTitleController
                                                        .text);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Save")),
                                        ],
                                        insetAnimationCurve: Curves.slowMiddle,
                                        insetAnimationDuration:
                                            const Duration(seconds: 2),
                                      );
                                    });
                                  });
                            },
                            label: const Text(
                              "Add More",
                              style: TextStyle(color: Colors.red),
                            )),
                        const SizedBox(height: 30),
                        const Row(
                          children: [
                            Icon(Icons.local_fire_department_rounded,
                                color: Colors.red),
                            Text(
                              " Calories Count",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(10),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text("Kcal",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text("0",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(10),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text("Carb",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text("0 g",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(10),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text("Proti",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text("0 G",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(10),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text("Fat",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text("0 g",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(height: 5),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: imgPath.isEmpty
                                    ? Image.asset(
                                        "assets/supps1.png",
                                        fit: BoxFit.cover,
                                        width: 100,
                                        opacity:
                                            const AlwaysStoppedAnimation(0.2),
                                      )
                                    : Image.file(File(imgPath)),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 5,
                                  child: IconButton(
                                      style: IconButton.styleFrom(
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(10),
                                          backgroundColor:
                                              Colors.blueGrey.shade50,
                                          foregroundColor: Colors.black),
                                      onPressed: () async {
                                        var img = await imgPicker.pickImage(
                                            source: ImageSource.camera);
                                        if (img != null) {
                                          setState(() {
                                            imgPath = img.path;
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.camera_enhance))),
                              Positioned(
                                  right: 0,
                                  top: 55,
                                  child: IconButton(
                                      style: IconButton.styleFrom(
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(10),
                                          backgroundColor:
                                              Colors.blueGrey.shade50,
                                          foregroundColor: Colors.black),
                                      onPressed: () async {
                                        var img = await imgPicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (img != null) {
                                          setState(() {
                                            imgPath = img.path;
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.image))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: p.isBtnLoading
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: ThreeBounceLoader())
                                : ElevatedButton(
                                    onPressed: () {
                                      if (widget.isFromAddMeal) {
                                        p.addMealF(
                                          context,
                                          date: widget.selectedDate,
                                          type: widget.selectedCal,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -13,
                top: -13,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ));
    });
  }
}



//  •