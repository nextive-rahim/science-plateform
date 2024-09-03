import 'dart:convert';

class AssignmentModel {
  AssignmentModel({
    this.id,
    this.question,
    this.instruction,
    this.marks,
    this.passMark,
    this.startTime,
    this.endTime,
    this.resultPublishTime,
    this.users,
    this.userAnswer,
    this.submissionNo,
    this.obtainedMarks,
  });

  int? id;
  String? question;
  String? instruction;
  String? marks;
  String? passMark;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? resultPublishTime;
  List<AssignmentUser>? users;
  dynamic userAnswer;
  String? submissionNo;
  String? obtainedMarks;

  bool get userPassed =>
      double.tryParse(obtainedMarks ?? '0')! >=
      double.tryParse(passMark ?? '0')!;

  bool get assignmentIsNotAvailableYet =>
      startTime == null ? false : startTime!.isAfter(DateTime.now());

  bool get assignmentSubmissionTimeEnded =>
      endTime == null ? false : endTime!.isBefore(DateTime.now());

  AssignmentModel copyWith({
    int? id,
    String? question,
    String? instruction,
    String? marks,
    String? passMark,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? resultPublishTime,
    List<AssignmentUser>? users,
    dynamic userAnswer,
    String? submissionNo,
    String? obtainedMarks,
  }) =>
      AssignmentModel(
        id: id ?? this.id,
        question: question ?? this.question,
        instruction: instruction ?? this.instruction,
        marks: marks ?? this.marks,
        passMark: passMark ?? this.passMark,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        resultPublishTime: resultPublishTime ?? this.resultPublishTime,
        users: users ?? this.users,
        userAnswer: userAnswer ?? this.userAnswer,
        submissionNo: submissionNo ?? this.submissionNo,
        obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      );

  factory AssignmentModel.fromRawJson(String str) =>
      AssignmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        id: json["id"],
        question: json["question"],
        instruction: json["instruction"],
        marks: json["marks"],
        passMark: json["pass_mark"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]).toLocal(),
        endTime: json["end_time"] == null
            ? null
            : DateTime.parse(json["end_time"]).toLocal(),
        resultPublishTime: json["result_publish_time"] == null
            ? null
            : DateTime.parse(json["result_publish_time"]).toLocal(),
        users: json["users"] == null
            ? null
            : List<AssignmentUser>.from(
                json["users"].map((x) => AssignmentUser.fromJson(x))),
        userAnswer: json["user_answer"],
        submissionNo: json["submission_no"],
        obtainedMarks: json["obtained_marks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "instruction": instruction,
        "marks": marks,
        "pass_mark": passMark,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "result_publish_time": resultPublishTime?.toIso8601String(),
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "user_answer": userAnswer,
        "submission_no": submissionNo,
        "obtained_marks": obtainedMarks,
      };
}

class AssignmentUser {
  AssignmentUser({
    this.id,
    this.createdBy,
    this.name,
    this.username,
    this.photo,
    this.phone,
    this.email,
    this.type,
    this.dob,
    this.gender,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.introduction,
    this.institution,
    this.subject,
    this.currentInstitution,
    this.varsity,
    this.varsityPassingYear,
    this.varsityResult,
    this.college,
    this.hscGroup,
    this.hscPassingYear,
    this.hscResult,
    this.school,
    this.sscGroup,
    this.sscPassingYear,
    this.sscResult,
    this.ip,
    this.deviceId,
    this.notificationToken,
    this.lastLoginTime,
    this.approved,
    this.active,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.district,
    this.ref,
    this.guardiansPhone,
    this.secondTimer,
    this.roll,
    this.isAffiliate,
    this.pivot,
  });

  int? id;
  dynamic createdBy;
  String? name;
  String? username;
  String? photo;
  String? phone;
  String? email;
  String? type;
  dynamic dob;
  dynamic gender;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  dynamic introduction;
  dynamic institution;
  dynamic subject;
  dynamic currentInstitution;
  dynamic varsity;
  dynamic varsityPassingYear;
  dynamic varsityResult;
  dynamic college;
  dynamic hscGroup;
  dynamic hscPassingYear;
  dynamic hscResult;
  dynamic school;
  dynamic sscGroup;
  dynamic sscPassingYear;
  dynamic sscResult;
  dynamic ip;
  dynamic deviceId;
  dynamic notificationToken;
  dynamic lastLoginTime;
  bool? approved;
  bool? active;
  dynamic emailVerifiedAt;
  DateTime? phoneVerifiedAt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic district;
  dynamic ref;
  dynamic guardiansPhone;
  bool? secondTimer;
  String? roll;
  bool? isAffiliate;
  Pivot? pivot;

  AssignmentUser copyWith({
    int? id,
    dynamic createdBy,
    String? name,
    String? username,
    String? photo,
    String? phone,
    String? email,
    String? type,
    dynamic dob,
    dynamic gender,
    dynamic twoFactorSecret,
    dynamic twoFactorRecoveryCodes,
    dynamic introduction,
    dynamic institution,
    dynamic subject,
    dynamic currentInstitution,
    dynamic varsity,
    dynamic varsityPassingYear,
    dynamic varsityResult,
    dynamic college,
    dynamic hscGroup,
    dynamic hscPassingYear,
    dynamic hscResult,
    dynamic school,
    dynamic sscGroup,
    dynamic sscPassingYear,
    dynamic sscResult,
    dynamic ip,
    dynamic deviceId,
    dynamic notificationToken,
    dynamic lastLoginTime,
    bool? approved,
    bool? active,
    dynamic emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic district,
    dynamic ref,
    dynamic guardiansPhone,
    bool? secondTimer,
    String? roll,
    bool? isAffiliate,
    Pivot? pivot,
  }) =>
      AssignmentUser(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        name: name ?? this.name,
        username: username ?? this.username,
        photo: photo ?? this.photo,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        type: type ?? this.type,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        twoFactorSecret: twoFactorSecret ?? this.twoFactorSecret,
        twoFactorRecoveryCodes:
            twoFactorRecoveryCodes ?? this.twoFactorRecoveryCodes,
        introduction: introduction ?? this.introduction,
        institution: institution ?? this.institution,
        subject: subject ?? this.subject,
        currentInstitution: currentInstitution ?? this.currentInstitution,
        varsity: varsity ?? this.varsity,
        varsityPassingYear: varsityPassingYear ?? this.varsityPassingYear,
        varsityResult: varsityResult ?? this.varsityResult,
        college: college ?? this.college,
        hscGroup: hscGroup ?? this.hscGroup,
        hscPassingYear: hscPassingYear ?? this.hscPassingYear,
        hscResult: hscResult ?? this.hscResult,
        school: school ?? this.school,
        sscGroup: sscGroup ?? this.sscGroup,
        sscPassingYear: sscPassingYear ?? this.sscPassingYear,
        sscResult: sscResult ?? this.sscResult,
        ip: ip ?? this.ip,
        deviceId: deviceId ?? this.deviceId,
        notificationToken: notificationToken ?? this.notificationToken,
        lastLoginTime: lastLoginTime ?? this.lastLoginTime,
        approved: approved ?? this.approved,
        active: active ?? this.active,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        district: district ?? this.district,
        ref: ref ?? this.ref,
        guardiansPhone: guardiansPhone ?? this.guardiansPhone,
        secondTimer: secondTimer ?? this.secondTimer,
        roll: roll ?? this.roll,
        isAffiliate: isAffiliate ?? this.isAffiliate,
        pivot: pivot ?? this.pivot,
      );

  factory AssignmentUser.fromRawJson(String str) =>
      AssignmentUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignmentUser.fromJson(Map<String, dynamic> json) => AssignmentUser(
        id: json["id"],
        createdBy: json["created_by"],
        name: json["name"],
        username: json["username"],
        photo: json["photo"],
        phone: json["phone"],
        email: json["email"],
        type: json["type"],
        dob: json["dob"],
        gender: json["gender"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        introduction: json["introduction"],
        institution: json["institution"],
        subject: json["subject"],
        currentInstitution: json["current_institution"],
        varsity: json["varsity"],
        varsityPassingYear: json["varsity_passing_year"],
        varsityResult: json["varsity_result"],
        college: json["college"],
        hscGroup: json["hsc_group"],
        hscPassingYear: json["hsc_passing_year"],
        hscResult: json["hsc_result"],
        school: json["school"],
        sscGroup: json["ssc_group"],
        sscPassingYear: json["ssc_passing_year"],
        sscResult: json["ssc_result"],
        ip: json["ip"],
        deviceId: json["device_id"],
        notificationToken: json["notification_token"],
        lastLoginTime: json["last_login_time"],
        approved: json["approved"],
        active: json["active"],
        emailVerifiedAt: json["email_verified_at"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : DateTime.parse(json["phone_verified_at"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        district: json["district"],
        ref: json["ref"],
        guardiansPhone: json["guardians_phone"],
        secondTimer: json["second_timer"],
        roll: json["roll"],
        isAffiliate: json["isAffiliate"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "name": name,
        "username": username,
        "photo": photo,
        "phone": phone,
        "email": email,
        "type": type,
        "dob": dob,
        "gender": gender,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "introduction": introduction,
        "institution": institution,
        "subject": subject,
        "current_institution": currentInstitution,
        "varsity": varsity,
        "varsity_passing_year": varsityPassingYear,
        "varsity_result": varsityResult,
        "college": college,
        "hsc_group": hscGroup,
        "hsc_passing_year": hscPassingYear,
        "hsc_result": hscResult,
        "school": school,
        "ssc_group": sscGroup,
        "ssc_passing_year": sscPassingYear,
        "ssc_result": sscResult,
        "ip": ip,
        "device_id": deviceId,
        "notification_token": notificationToken,
        "last_login_time": lastLoginTime,
        "approved": approved,
        "active": active,
        "email_verified_at": emailVerifiedAt,
        "phone_verified_at":
            phoneVerifiedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "district": district,
        "ref": ref,
        "guardians_phone": guardiansPhone,
        "second_timer": secondTimer,
        "roll": roll,
        "isAffiliate": isAffiliate,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  Pivot({
    this.assignmentId,
    this.userId,
    this.answer,
    this.obtainedMarks,
    this.submissionNo,
  });

  int? assignmentId;
  int? userId;
  String? answer;
  dynamic obtainedMarks;
  String? submissionNo;

  Pivot copyWith({
    int? assignmentId,
    int? userId,
    String? answer,
    dynamic obtainedMarks,
    String? submissionNo,
  }) =>
      Pivot(
        assignmentId: assignmentId ?? this.assignmentId,
        userId: userId ?? this.userId,
        answer: answer ?? this.answer,
        obtainedMarks: obtainedMarks ?? this.obtainedMarks,
        submissionNo: submissionNo ?? this.submissionNo,
      );

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        assignmentId: json["assignment_id"],
        userId: json["user_id"],
        answer: json["answer"],
        obtainedMarks: json["obtained_marks"],
        submissionNo: json["submission_no"],
      );

  Map<String, dynamic> toJson() => {
        "assignment_id": assignmentId,
        "user_id": userId,
        "answer": answer,
        "obtained_marks": obtainedMarks,
        "submission_no": submissionNo,
      };
}
