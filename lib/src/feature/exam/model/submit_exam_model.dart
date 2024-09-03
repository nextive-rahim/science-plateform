import 'dart:convert';

class SubmitExamModel {
  SubmitExamModel({
    this.examId,
    this.submitted,
    this.answers,
    this.subjects,
  });

  int? examId;
  int? submitted;
  List<SubmitExamAnswerModel?>? answers;
  List<int?>? subjects;

  SubmitExamModel copyWith({
    int? examId,
    int? submitted,
    List<SubmitExamAnswerModel?>? answers,
    List<int?>? subjects,
  }) =>
      SubmitExamModel(
        examId: examId ?? this.examId,
        submitted: submitted ?? this.submitted,
        answers: answers ?? this.answers,
        subjects: subjects ?? this.subjects,
      );

  factory SubmitExamModel.fromRawJson(String str) =>
      SubmitExamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitExamModel.fromJson(Map<String, dynamic> json) =>
      SubmitExamModel(
        examId: json["exam_id"],
        submitted: json["submitted"],
        answers: json["answers"] == null
            ? null
            : List<SubmitExamAnswerModel>.from(
                json["answers"].map((x) => SubmitExamAnswerModel.fromJson(x))),
        subjects: json["subjects"] == null
            ? []
            : List<int>.from(json["subjects"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "exam_id": examId,
        "submitted": submitted,
        "answers": answers == null
            ? null
            : List<dynamic>.from(answers!.map((x) => x?.toJson())),
        "subjects":
            subjects == null ? [] : List<int>.from(subjects!.map((x) => x)),
      };
}

class SubmitExamAnswerModel {
  SubmitExamAnswerModel({
    this.userAnswer,
    this.mcqId,
  });

  String? userAnswer;
  int? mcqId;

  SubmitExamAnswerModel copyWith({
    String? userAnswer,
    int? mcqId,
  }) =>
      SubmitExamAnswerModel(
        userAnswer: userAnswer ?? this.userAnswer,
        mcqId: mcqId ?? this.mcqId,
      );

  factory SubmitExamAnswerModel.fromRawJson(String str) =>
      SubmitExamAnswerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitExamAnswerModel.fromJson(Map<String, dynamic> json) =>
      SubmitExamAnswerModel(
        userAnswer: json["user_answer"],
        mcqId: json["mcq_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_answer": userAnswer,
        "mcq_id": mcqId,
      };
}
