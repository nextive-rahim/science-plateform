import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class ExamMcqModel {
  ExamMcqModel({
    this.id,
    this.mcqStoreId,
    this.question,
    this.questionPhoto,
    this.questionDescription,
    this.a,
    this.b,
    this.c,
    this.d,
    this.e,
    this.f,
    this.g,
    this.h,
    this.i,
    this.j,
    this.answer,
    this.answerPhoto,
    this.answerDescription,
    this.verified,
    this.difficultyLevel,
    this.active,
    this.videoLink,
    this.userAnswer,
  });

  int? id;
  int? mcqStoreId;
  String? question;
  dynamic questionPhoto;
  dynamic questionDescription;
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? f;
  String? g;
  String? h;
  String? i;
  String? j;
  String? answer;
  dynamic answerPhoto;
  dynamic answerDescription;
  dynamic verified;
  dynamic difficultyLevel;
  bool? active;
  dynamic videoLink;
  String? userAnswer;

  List<String> get options {
    List<String> mcqOptions = [];
    addToList(String? item) {
      if (item != null) {
        mcqOptions.add(item);
        return;
      }
    }

    addToList(a);
    addToList(b);
    addToList(c);
    addToList(d);
    addToList(e);
    addToList(f);
    addToList(g);
    addToList(h);
    addToList(i);
    addToList(j);

    return mcqOptions;
  }

  bool get isQuestionAnswered => userAnswer.isNotNull;

  bool get isCorrectAnswer => answer == userAnswer;

  ExamMcqModel copyWith({
    int? id,
    int? mcqStoreId,
    String? question,
    dynamic questionPhoto,
    dynamic questionDescription,
    String? a,
    String? b,
    String? c,
    String? d,
    String? e,
    String? f,
    String? g,
    String? h,
    String? i,
    String? j,
    String? answer,
    dynamic answerPhoto,
    dynamic answerDescription,
    dynamic verified,
    dynamic difficultyLevel,
    bool? active,
    dynamic videoLink,
    dynamic userAnswer,
  }) =>
      ExamMcqModel(
        id: id ?? this.id,
        mcqStoreId: mcqStoreId ?? this.mcqStoreId,
        question: question ?? this.question,
        questionPhoto: questionPhoto ?? this.questionPhoto,
        questionDescription: questionDescription ?? this.questionDescription,
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
        d: d ?? this.d,
        e: e ?? this.e,
        f: f ?? this.f,
        g: g ?? this.g,
        h: h ?? this.h,
        i: i ?? this.i,
        j: j ?? this.j,
        answer: answer ?? this.answer,
        answerPhoto: answerPhoto ?? this.answerPhoto,
        answerDescription: answerDescription ?? this.answerDescription,
        verified: verified ?? this.verified,
        difficultyLevel: difficultyLevel ?? this.difficultyLevel,
        active: active ?? this.active,
        videoLink: videoLink ?? this.videoLink,
        userAnswer: userAnswer ?? this.userAnswer,
      );

  factory ExamMcqModel.fromJson(Map<String, dynamic> json) => ExamMcqModel(
        id: json["id"],
        mcqStoreId: json["mcq_store_id"],
        question: json["question"],
        questionPhoto: json["question_photo"],
        questionDescription: json["question_description"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        e: json["e"],
        f: json["f"],
        g: json["g"],
        h: json["h"],
        i: json["i"],
        j: json["j"],
        answer: json["answer"],
        answerPhoto: json["answer_photo"],
        answerDescription: json["answer_description"],
        verified: json["verified"],
        difficultyLevel: json["difficulty_level"],
        active: json["active"],
        videoLink: json["video_link"],
        userAnswer: json["user_answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mcq_store_id": mcqStoreId,
        "question": question,
        "question_photo": questionPhoto,
        "question_description": questionDescription,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "e": e,
        "f": f,
        "g": g,
        "h": h,
        "i": i,
        "j": j,
        "answer": answer,
        "answer_photo": answerPhoto,
        "answer_description": answerDescription,
        "verified": verified,
        "difficulty_level": difficultyLevel,
        "active": active,
        "video_link": videoLink,
        "user_answer": userAnswer,
      };
}
