import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';

class CommonTabView extends StatefulWidget {
  const CommonTabView({
    super.key,
    required this.tabBarItems,
    required this.tabViewItems,
    this.initialIndex,
    this.backgroundColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.radius,
    this.onTap,
  });
  final int? initialIndex;
  final List<String> tabBarItems;
  final List<Widget> tabViewItems;
  final Color? backgroundColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double? radius;
  final Function(int)? onTap;

  @override
  State<CommonTabView> createState() => _CommonTabViewState();
}

class _CommonTabViewState extends State<CommonTabView> {
  int _currentIndex = 0;
  int? initialIndex;

  void updateTab(int index) {
    setState(() {
      _currentIndex = index;
      if (widget.onTap != null) widget.onTap!(index);
    });
    initialIndex = null;
  }

  void updateInitialIndex() {
    initialIndex = widget.initialIndex;
    if (initialIndex != null) {
      updateTab(widget.initialIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    updateInitialIndex();

    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex ?? _currentIndex,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightBlack10.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 55,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? AppColors.primary,
                  borderRadius: BorderRadius.circular(widget.radius ?? 16),
                ),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(
                    widget.radius == null ? 11 : (widget.radius! - 5),
                  ),
                  onTap: (index) {
                    updateTab(index);
                  },
                  unselectedLabelColor:
                      widget.unselectedTextColor ?? AppColors.white,
                  labelColor: widget.selectedTextColor ?? AppColors.darkerGrey,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      widget.radius == null ? 11 : (widget.radius! - 5),
                    ),
                    color: AppColors.white,
                  ),
                  tabs: widget.tabBarItems.map((item) {
                    return Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item,
                            textScaleFactor: 1,
                            style: AppTextStyle.bold14.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          _currentIndex == widget.tabBarItems.indexOf(item)
                              ? const _TabUnderline()
                              : const SizedBox(),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: widget.tabViewItems,
            ),
          ),
          // TabBarView(
          //   physics: const NeverScrollableScrollPhysics(),
          //   children: widget.tabViewItems,
          // ),
        ],
      ),
    );
  }
}

class _TabUnderline extends StatelessWidget {
  const _TabUnderline();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 30,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
