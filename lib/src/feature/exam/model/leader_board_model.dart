import 'dart:convert';

import 'package:science_platform/src/utils/extensions/string_extension.dart';

class LeaderBoardModel {
  LeaderBoardModel({
    this.data,
    this.links,
    this.meta,
  });

  List<LeaderBoardItemModel>? data;
  Links? links;
  Meta? meta;

  LeaderBoardModel copyWith({
    List<LeaderBoardItemModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      LeaderBoardModel(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory LeaderBoardModel.fromRawJson(String str) =>
      LeaderBoardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
        data: json["data"] == null
            ? null
            : List<LeaderBoardItemModel>.from(
                json["data"].map((x) => LeaderBoardItemModel.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class LeaderBoardItemModel {
  LeaderBoardItemModel({
    this.total,
    this.correct,
    this.submitted,
    this.wrong,
    this.totalMark,
    this.positiveMark,
    this.negativeMark,
    this.obtainedMark,
    this.startTime,
    this.endTime,
    this.subjects,
    this.user,
  });

  int? total;
  int? correct;
  dynamic submitted;
  int? wrong;
  String? totalMark;
  String? positiveMark;
  String? negativeMark;
  String? obtainedMark;
  DateTime? startTime;
  DateTime? endTime;
  dynamic subjects;
  LeaderBoardItemUserModel? user;

  LeaderBoardItemModel copyWith({
    int? total,
    int? correct,
    dynamic submitted,
    int? wrong,
    String? totalMark,
    String? positiveMark,
    String? negativeMark,
    String? obtainedMark,
    DateTime? startTime,
    DateTime? endTime,
    dynamic subjects,
    LeaderBoardItemUserModel? user,
  }) =>
      LeaderBoardItemModel(
        total: total ?? this.total,
        correct: correct ?? this.correct,
        submitted: submitted ?? this.submitted,
        wrong: wrong ?? this.wrong,
        totalMark: totalMark ?? this.totalMark,
        positiveMark: positiveMark ?? this.positiveMark,
        negativeMark: negativeMark ?? this.negativeMark,
        obtainedMark: obtainedMark ?? this.obtainedMark,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        subjects: subjects ?? this.subjects,
        user: user ?? this.user,
      );

  String get timeTaken {
    String time = "00:00:00";
    if (endTime != null && startTime != null) {
      final difference = endTime!.difference(startTime!);
      time = Duration(seconds: difference.inSeconds).formatToHMS;
    }
    return time;
  }

  String get scoreEarned {
    String result;
    result = '${correct ?? 0}/${total ?? 0}';
    return result;
  }

  factory LeaderBoardItemModel.fromRawJson(String str) =>
      LeaderBoardItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaderBoardItemModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardItemModel(
        total: json["total"] ?? 0,
        correct: json["correct"] ?? 0,
        submitted: json["submitted"],
        wrong: json["wrong"],
        totalMark: json["total_mark"],
        positiveMark: json["positive_mark"],
        negativeMark: json["negative_mark"],
        obtainedMark: json["obtained_mark"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        subjects: json["subjects"],
        user: json["user"] == null
            ? null
            : LeaderBoardItemUserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "correct": correct,
        "submitted": submitted,
        "wrong": wrong,
        "total_mark": totalMark,
        "positive_mark": positiveMark,
        "negative_mark": negativeMark,
        "obtained_mark": obtainedMark,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "subjects": subjects,
        "user": user?.toJson(),
      };
}

class LeaderBoardItemUserModel {
  LeaderBoardItemUserModel({
    this.id,
    this.name,
    this.username,
    this.roll,
    this.photo,
    this.phone,
    this.email,
    this.type,
    this.gender,
    this.dob,
    this.affiliation,
    this.subject,
    this.guardiansPhone,
    this.currentInstitution,
    this.varsity,
    this.college,
    this.hscGroup,
    this.hscPassingYear,
    this.school,
    this.lastLoginTime,
    this.approved,
    this.active,
    this.secondTimer,
    this.permissions,
    this.roles,
    this.district,
    this.ref,
    this.isAffiliate,
    this.phoneVerifiedAt,
  });

  int? id;
  String? name;
  String? username;
  String? roll;
  String? photo;
  String? phone;
  String? email;
  String? type;
  dynamic gender;
  String? dob;
  dynamic affiliation;
  dynamic subject;
  dynamic guardiansPhone;
  dynamic currentInstitution;
  dynamic varsity;
  dynamic college;
  dynamic hscGroup;
  dynamic hscPassingYear;
  dynamic school;
  dynamic lastLoginTime;
  bool? approved;
  bool? active;
  bool? secondTimer;
  List<String>? permissions;
  List<String>? roles;
  dynamic district;
  dynamic ref;
  bool? isAffiliate;
  dynamic phoneVerifiedAt;

  LeaderBoardItemUserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? roll,
    String? photo,
    String? phone,
    String? email,
    String? type,
    dynamic gender,
    String? dob,
    dynamic affiliation,
    dynamic subject,
    dynamic guardiansPhone,
    dynamic currentInstitution,
    dynamic varsity,
    dynamic college,
    dynamic hscGroup,
    dynamic hscPassingYear,
    dynamic school,
    dynamic lastLoginTime,
    bool? approved,
    bool? active,
    bool? secondTimer,
    List<String>? permissions,
    List<String>? roles,
    dynamic district,
    dynamic ref,
    bool? isAffiliate,
    dynamic phoneVerifiedAt,
  }) =>
      LeaderBoardItemUserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        roll: roll ?? this.roll,
        photo: photo ?? this.photo,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        affiliation: affiliation ?? this.affiliation,
        subject: subject ?? this.subject,
        guardiansPhone: guardiansPhone ?? this.guardiansPhone,
        currentInstitution: currentInstitution ?? this.currentInstitution,
        varsity: varsity ?? this.varsity,
        college: college ?? this.college,
        hscGroup: hscGroup ?? this.hscGroup,
        hscPassingYear: hscPassingYear ?? this.hscPassingYear,
        school: school ?? this.school,
        lastLoginTime: lastLoginTime ?? this.lastLoginTime,
        approved: approved ?? this.approved,
        active: active ?? this.active,
        secondTimer: secondTimer ?? this.secondTimer,
        permissions: permissions ?? this.permissions,
        roles: roles ?? this.roles,
        district: district ?? this.district,
        ref: ref ?? this.ref,
        isAffiliate: isAffiliate ?? this.isAffiliate,
        phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      );

  factory LeaderBoardItemUserModel.fromRawJson(String str) =>
      LeaderBoardItemUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaderBoardItemUserModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardItemUserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        roll: json["roll"],
        photo: json["photo"],
        phone: json["phone"],
        email: json["email"],
        type: json["type"],
        gender: json["gender"],
        dob: json["dob"],
        affiliation: json["affiliation"],
        subject: json["subject"],
        guardiansPhone: json["guardians_phone"],
        currentInstitution: json["current_institution"],
        varsity: json["varsity"],
        college: json["college"],
        hscGroup: json["hsc_group"],
        hscPassingYear: json["hsc_passing_year"],
        school: json["school"],
        lastLoginTime: json["last_login_time"],
        approved: json["approved"],
        active: json["active"],
        secondTimer: json["second_timer"],
        permissions: json["permissions"] == null
            ? null
            : List<String>.from(json["permissions"].map((x) => x)),
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        district: json["district"],
        ref: json["ref"],
        isAffiliate: json["isAffiliate"],
        phoneVerifiedAt: json["phone_verified_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "roll": roll,
        "photo": photo,
        "phone": phone,
        "email": email,
        "type": type,
        "gender": gender,
        "dob": dob,
        "affiliation": affiliation,
        "subject": subject,
        "guardians_phone": guardiansPhone,
        "current_institution": currentInstitution,
        "varsity": varsity,
        "college": college,
        "hsc_group": hscGroup,
        "hsc_passing_year": hscPassingYear,
        "school": school,
        "last_login_time": lastLoginTime,
        "approved": approved,
        "active": active,
        "second_timer": secondTimer,
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions!.map((x) => x)),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "district": district,
        "ref": ref,
        "isAffiliate": isAffiliate,
        "phone_verified_at": phoneVerifiedAt,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links copyWith({
    String? first,
    String? last,
    dynamic prev,
    dynamic next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
