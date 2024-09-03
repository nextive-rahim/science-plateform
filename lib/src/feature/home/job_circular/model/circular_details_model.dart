import 'dart:convert';
import 'package:science_platform/src/feature/home/job_circular/model/circular_list_model.dart';

CircularDetailsResponseModel circularDetailsResponseModelFromJson(String str) =>
    CircularDetailsResponseModel.fromJson(json.decode(str));

String circularDetailsResponseModelToJson(CircularDetailsResponseModel data) =>
    json.encode(data.toJson());

class CircularDetailsResponseModel {
  JobCircularModel? data;

  CircularDetailsResponseModel({
    this.data,
  });

  factory CircularDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      CircularDetailsResponseModel(
        data: json["data"] == null
            ? null
            : JobCircularModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}
