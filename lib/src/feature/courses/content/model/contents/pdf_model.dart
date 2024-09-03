class PdfModel {
  int? id;
  String? title;
  String? link;

  PdfModel({
    this.id,
    this.title,
    this.link,
  });

  PdfModel copyWith({
    int? id,
    String? title,
    String? link,
  }) =>
      PdfModel(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
      );

  factory PdfModel.fromJson(Map<String, dynamic> json) => PdfModel(
        id: json["id"],
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
      };
}
