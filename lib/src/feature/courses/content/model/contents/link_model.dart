class LinkModel {
  int? id;
  String? title;
  String? link;

  LinkModel({
    this.id,
    this.title,
    this.link,
  });

  LinkModel copyWith({
    int? id,
    String? title,
    String? link,
  }) =>
      LinkModel(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
      );

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
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