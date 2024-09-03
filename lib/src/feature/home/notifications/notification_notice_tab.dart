import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/controller/notice_view_controller.dart';
import 'package:science_platform/src/feature/home/notifications/tab/notice/view/notice_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tab/notification/view/notification_page.dart';

class NotificationAndNoticeTab extends StatefulWidget {
  const NotificationAndNoticeTab({
    super.key,
    this.initialIndex = 0,
  });

  final int initialIndex;

  @override
  State<NotificationAndNoticeTab> createState() =>
      _NotificationAndNoticeTabState();
}

class _NotificationAndNoticeTabState extends State<NotificationAndNoticeTab> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(NoticeViewController());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          leadingWidth: 65,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            _currentIndex == 0 ? "নোটিফিকেশন" : "নোটিশ",
            textScaleFactor: 1,
            style: AppTextStyle.semiBold16.copyWith(
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 65),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              decoration: BoxDecoration(
                  color: AppColors.lighterBlue,
                  borderRadius: BorderRadius.circular(15)),
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Creates border
                  color: AppColors.white,
                  border: Border.all(
                    width: 5,
                    color: AppColors.lighterBlue,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "নোটিফিকেশন",
                          textScaleFactor: 1,
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColors.darkerGrey,
                          ),
                        ),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "নোটিশ",
                          textScaleFactor: 1,
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColors.darkerGrey,
                          ),
                        ),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationPage(),
            NoticePage(),
          ],
        ),
      ),
    );
  }
}
