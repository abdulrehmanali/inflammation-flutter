class SupplementsModel {
  String id;
  String title;
  String image;
  String link;
  String subTitle;
  int v;

  SupplementsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
    required this.subTitle,
    required this.v,
  });

  factory SupplementsModel.fromJson(Map<String, dynamic> json) {
    return SupplementsModel(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      link: json['link'],
      subTitle: json['subTitle'],
      v: json['__v'],
    );
  }
}
