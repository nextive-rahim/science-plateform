class CircularCategoryResponseModel {
  CircularCategoryResponseModel({
    this.data,
  });

  List<CircularCategoryModel>? data;

  factory CircularCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CircularCategoryResponseModel(
        data: json["data"] == null
            ? null
            : List<CircularCategoryModel>.from(
                json["data"].map((x) => CircularCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CircularCategoryModel {
  CircularCategoryModel({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.photo,
    this.order,
    this.active,
    this.children,
    this.childrenCount,
  });

  int? id;
  dynamic parentId;
  String? name;
  String? slug;
  dynamic photo;
  int? order;
  bool? active;
  List<dynamic>? children;
  int? childrenCount;

  factory CircularCategoryModel.fromJson(Map<String, dynamic> json) =>
      CircularCategoryModel(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"],
        order: json["order"],
        active: json["active"],
        children: json["children"] == null
            ? null
            : List<dynamic>.from(json["children"].map((x) => x)),
        childrenCount: json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "slug": slug,
        "photo": photo,
        "order": order,
        "active": active,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
        "children_count": childrenCount,
      };
}
