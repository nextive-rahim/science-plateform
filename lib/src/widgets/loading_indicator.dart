// ignore_for_file: must_be_immutable

import 'package:science_platform/src/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

enum LoadingIndicatorType {
  list,
  details,
  comment,
  card,
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({super.key});

  LoadingIndicator.list({super.key}) {
    _loadingIndicatorType = LoadingIndicatorType.list;
  }

  LoadingIndicator.details({super.key}) {
    _loadingIndicatorType = LoadingIndicatorType.details;
  }

  LoadingIndicator.comment({super.key}) {
    _loadingIndicatorType = LoadingIndicatorType.comment;
  }

  LoadingIndicator.card({super.key}) {
    _loadingIndicatorType = LoadingIndicatorType.card;
  }

  late LoadingIndicatorType _loadingIndicatorType;

  @override
  Widget build(BuildContext context) {
    switch (_loadingIndicatorType) {
      case LoadingIndicatorType.list:
        return _loadingContainer(
          _buildList(context),
        );
      case LoadingIndicatorType.card:
        return _loadingContainer(
          _buildCard(context),
        );
      case LoadingIndicatorType.details:
        return _loadingContainer(
          _buildDetails(context),
        );
      case LoadingIndicatorType.comment:
        return _loadingContainer(
          _buildComment(context),
        );
      default:
        return const CircularProgressIndicator.adaptive();
    }
  }

  Widget _loadingContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: child,
    );
  }

  Widget _buildList(BuildContext context) {
    Color baseColor = AppColors.white;
    Color highLightColor = AppColors.primary10;
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highLightColor,
                child: Container(
                  width: Get.width,
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildCard(BuildContext context) {
    Color baseColor = AppColors.white;
    Color highLightColor = AppColors.primary10;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highLightColor,
          child: Container(
            width: Get.width,
            height: 150,
            decoration: BoxDecoration(
                color: baseColor, borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: AppColors.grey200,
          highlightColor: AppColors.grey100,
          child: const CircleAvatar(
            radius: 20.0,
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.grey200,
          highlightColor: AppColors.grey100,
          child: Container(
            width: 200,
            height: 22,
            color: AppColors.grey200,
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.grey200,
          highlightColor: AppColors.grey100,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            color: AppColors.grey200,
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.grey200,
          highlightColor: AppColors.grey100,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            color: AppColors.grey100,
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.grey200,
          highlightColor: AppColors.grey100,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            color: AppColors.grey100,
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.grey200,
          highlightColor: AppColors.grey100,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            color: AppColors.grey100,
          ),
        ),
      ],
    );
  }

  Widget _buildComment(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(/*left: 10, right: 10,*/ top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Shimmer.fromColors(
                        baseColor: AppColors.grey200,
                        highlightColor: AppColors.grey100,
                        child: const CircleAvatar(
                          radius: 20.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Shimmer.fromColors(
                            baseColor: AppColors.grey200,
                            highlightColor: AppColors.grey100,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: Get.size.height * .65,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.grey200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Shimmer.fromColors(
                  baseColor: AppColors.grey200,
                  highlightColor: AppColors.grey100,
                  child: const CircleAvatar(radius: 20.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: AppColors.grey200,
                      highlightColor: AppColors.grey100,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: Get.size.height * .45,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
