class NoteModel {
  NoteModel({
    this.id,
    this.body,
    this.title,
  });

  int? id;
  String? body;
  String? title;

  NoteModel copyWith({
    int? id,
    String? body,
  }) =>
      NoteModel(
        id: id ?? this.id,
        body: body ?? this.body,
        title: title ?? title,
      );

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        'title': title,
      };
}
