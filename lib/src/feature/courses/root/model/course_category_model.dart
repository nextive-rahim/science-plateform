// class CourseCategoryResponseModel {
//   CourseCategoryResponseModel({
//     required this.categories,
//   });

//   late final List<CourseCategory> categories;

//   CourseCategoryResponseModel.fromJson(Map<String, dynamic> json) {
//     categories =
//         List.from(json['data']).map((e) => CourseCategory.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['data'] = categories.map((e) => e.toJson()).toList();
//     return data;
//   }
// }

// class CourseCategory {
//   CourseCategory({
//     required this.id,
//     this.parentId,
//     required this.name,
//     this.title,
//     this.price,
//     this.discount,
//     this.discountTill,
//     this.discountedPrice,
//     required this.slug,
//     this.photo,
//     this.description,
//     this.order,
//     required this.active,
//     required this.featured,
//     required this.children,
//     required this.childrenCount,
//   });

//   late final int id;
//   late final dynamic parentId;
//   late final String name;
//   late final dynamic title;
//   late final dynamic price;
//   late final dynamic discount;
//   late final dynamic discountTill;
//   late final dynamic discountedPrice;
//   late final String slug;
//   late final String? photo;
//   late final String? description;
//   late final dynamic order;
//   late final bool active;
//   late final bool featured;
//   late final List<CourseCategory>? children;
//   late final int childrenCount;

//   CourseCategory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     parentId = null;
//     name = json['name'];
//     title = null;
//     price = null;
//     discount = null;
//     discountTill = null;
//     discountedPrice = null;
//     slug = json['slug'];
//     photo = json['photo'];
//     description = null;
//     order = null;
//     active = json['active'];
//     featured = json['featured'];
//     children = json['children'] == null
//         ? null
//         : List.from(json['children'])
//             .map((e) => CourseCategory.fromJson(e))
//             .toList();
//     childrenCount = json['children_count'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['parent_id'] = parentId;
//     data['name'] = name;
//     data['title'] = title;
//     data['price'] = price;
//     data['discount'] = discount;
//     data['discount_till'] = discountTill;
//     data['discounted_price'] = discountedPrice;
//     data['slug'] = slug;
//     data['photo'] = photo;
//     data['description'] = description;
//     data['order'] = order;
//     data['active'] = active;
//     data['featured'] = featured;
//     data['children'] = children?.map((e) => e.toJson()).toList();
//     data['children_count'] = childrenCount;
//     return data;
//   }
// }

// class Children {
//   Children({
//     required this.id,
//     required this.parentId,
//     required this.name,
//     this.title,
//     this.price,
//     this.discount,
//     this.discountTill,
//     this.discountedPrice,
//     required this.slug,
//     this.photo,
//     this.description,
//     this.order,
//     required this.active,
//     required this.featured,
//     required this.children,
//     required this.childrenCount,
//   });

//   late final int id;
//   late final int parentId;
//   late final String name;
//   late final dynamic title;
//   late final dynamic price;
//   late final dynamic discount;
//   late final dynamic discountTill;
//   late final dynamic discountedPrice;
//   late final String slug;
//   late final dynamic photo;
//   late final dynamic description;
//   late final dynamic order;
//   late final bool active;
//   late final bool featured;
//   late final List<dynamic> children;
//   late final int childrenCount;

//   Children.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     parentId = json['parent_id'];
//     name = json['name'];
//     title = null;
//     price = null;
//     discount = null;
//     discountTill = null;
//     discountedPrice = null;
//     slug = json['slug'];
//     photo = json['photo'];
//     description = null;
//     order = null;
//     active = json['active'];
//     featured = json['featured'];
//     children = List.castFrom<dynamic, dynamic>(json['children']);
//     childrenCount = json['children_count'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['parent_id'] = parentId;
//     data['name'] = name;
//     data['title'] = title;
//     data['price'] = price;
//     data['discount'] = discount;
//     data['discount_till'] = discountTill;
//     data['discounted_price'] = discountedPrice;
//     data['slug'] = slug;
//     data['photo'] = photo;
//     data['description'] = description;
//     data['order'] = order;
//     data['active'] = active;
//     data['featured'] = featured;
//     data['children'] = children;
//     data['children_count'] = childrenCount;
//     return data;
//   }
// }

import 'package:science_platform/src/feature/courses/root/model/category_model.dart';

class CourseCategoryListResponseModel {
  List<CategoryModel>? data;

  CourseCategoryListResponseModel({
    this.data,
  });

  CourseCategoryListResponseModel copyWith({
    List<CategoryModel>? data,
  }) =>
      CourseCategoryListResponseModel(
        data: data ?? this.data,
      );

  factory CourseCategoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      CourseCategoryListResponseModel(
        data: json["data"] == null
            ? []
            : List<CategoryModel>.from(
                json["data"]!.map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
