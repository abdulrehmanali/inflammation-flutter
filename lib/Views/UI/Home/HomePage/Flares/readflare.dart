import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';

class ReadFlarePage extends StatefulWidget {
  String date;
  String symtoms;
  String description;
  ReadFlarePage({
    super.key,
    this.date = "",
    this.symtoms = "",
    this.description = "",
  });

  @override
  State<ReadFlarePage> createState() => _ReadFlarePageState();
}

class _ReadFlarePageState extends State<ReadFlarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop()),
            title:
                const Text('InflamEase', style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                  icon: const Icon(Icons.person, color: AppColors.primaryColor),
                  onPressed: () {})
            ]),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                      tileColor: AppColors.primaryColor.withOpacity(0.05),
                      title: const Text("Symptoms"),
                      subtitle: Text(widget.date),
                      trailing: widget.symtoms.toLowerCase() == "mild"
                          ? const Icon(Icons.emoji_emotions_outlined,
                              color: AppColors.primaryColor)
                          : widget.symtoms.toLowerCase() == "moderate"
                              ? const Icon(Icons.sentiment_satisfied,
                                  color: AppColors.primaryColor)
                              : const Icon(
                                  Icons.sentiment_very_dissatisfied_sharp)),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description: ",
                            style: TextStyle(color: Colors.blueGrey.shade400)),
                        const SizedBox(height: 5),
                        Text(widget.description)
                      ],
                    ),
                  )
                ])));
  }
}
