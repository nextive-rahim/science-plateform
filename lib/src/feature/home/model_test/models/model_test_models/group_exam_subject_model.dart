import 'dart:convert';

import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_mcq_model.dart';

class GroupExamSubjectModel {
  GroupExamSubjectModel({
    this.id,
    this.name,
    this.isRequired,
    this.order,
    this.mcqs,
    this.mcqCount,
  });

  int? id;
  String? name;
  bool? isRequired;
  int? order;
  List<ExamMcqModel>? mcqs;
  int? mcqCount;

  GroupExamSubjectModel copyWith({
    int? id,
    String? name,
    bool? isRequired,
    int? order,
    List<ExamMcqModel>? mcqs,
    int? mcqCount,
  }) =>
      GroupExamSubjectModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isRequired: isRequired ?? this.isRequired,
        order: order ?? this.order,
        mcqs: mcqs ?? this.mcqs,
        mcqCount: mcqCount ?? this.mcqCount,
      );

  factory GroupExamSubjectModel.fromRawJson(String str) =>
      GroupExamSubjectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupExamSubjectModel.fromJson(Map<String, dynamic> json) =>
      GroupExamSubjectModel(
        id: json["id"],
        name: json["name"],
        isRequired: json["required"],
        order: json["order"],
        mcqs: json["mcqs"] == null
            ? null
            : List<ExamMcqModel>.from(
                json["mcqs"].map((x) => ExamMcqModel.fromJson(x))),
        mcqCount: json["mcq_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "required": isRequired,
        "order": order,
        "mcqs": mcqs == null
            ? null
            : List<dynamic>.from(mcqs!.map((x) => x.toJson())),
        "mcq_count": mcqCount,
      };
}
