class VideoModel {
  int? id;
  String? title;
  String? source;
  String? link;
  dynamic description;
  dynamic embedded;

  VideoModel({
    this.id,
    this.title,
    this.source,
    this.link,
    this.description,
    this.embedded,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        source: json["source"],
        link: json["link"],
        description: json["description"],
        embedded: json["embedded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "source": source,
        "link": link,
        "description": description,
        "embedded": embedded,
      };
}
