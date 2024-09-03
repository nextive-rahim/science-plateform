import 'dart:developer';

import 'package:science_platform/src/core/network/endpoints.dart';
import 'package:science_platform/src/core/network/rest_client.dart';

class ExamRepository {
  Future<dynamic> fetchExamDetails(id, {bool isWrittenExam = false}) async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      isWrittenExam ? API.writtenExamDetails(id) : API.examDetails(id),
    );
    return res.data;
  }

  Future<dynamic> submitExam(Map<String, dynamic> data) async {
    final res = await RestClient.dev().post(
      APIType.PROTECTED,
      API.submitExam,
      data,
    );
    return res.data;
  }

  Future<dynamic> submitWrittenExam(Map<String, dynamic> data) async {
    final res = await RestClient().post(
      APIType.PROTECTED,
      API.submitWrittenExam,
      data,
    );
    return res.data;
  }

  Future<dynamic> fetchLeaderBoard(int id) async {
    final res = await RestClient.dev().get(
      APIType.PROTECTED,
      API.leaderBoard(id),
    );
    return res.data;
  }

  Future<dynamic> createAwsLink({
    required Map<String, dynamic> data,
  }) async {
    final res = await RestClient().post(
      APIType.PROTECTED,
      API.uploadToAws,
      data,
    );

    return res.data;
  }

  Future<dynamic> uploadToAws({
    required String url,
    dynamic body,
    int? contentLength,
  }) async {
    log("repo body $body");
    final res = await RestClient().putFormDataToUrl(
      url,
      body: body,
      length: contentLength,
    );

    log('repo res.data ${res.data}');

    return res.data;
  }
}
