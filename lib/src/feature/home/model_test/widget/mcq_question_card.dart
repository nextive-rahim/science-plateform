import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/exam/controller/exam_view_controller.dart';
import 'package:science_platform/src/feature/exam/model/submit_exam_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_mcq_model.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MCQQuestionCard extends StatefulWidget {
  const MCQQuestionCard({
    super.key,
    required this.index,
    required this.mcqModel,
    required this.examMode,
    this.tabBar,
  });

  final int index;
  final ExamMcqModel mcqModel;
  final String examMode;
  final TabController? tabBar;

  @override
  State<MCQQuestionCard> createState() => _MCQQuestionCardState();
}

class _MCQQuestionCardState extends State<MCQQuestionCard>
    with AutomaticKeepAliveClientMixin<MCQQuestionCard> {
  bool _isAnswered = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(_isAnswered ? 10 : 0),
      decoration: BoxDecoration(
        color: _isAnswered ? AppColors.primary20 : AppColors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.index + 1}. ',
                style: AppTextStyle.bold14.copyWith(
                  fontSize: 13,
                  height: 0,
                  color: AppColors.lightBlack80,
                ),
              ),
              Expanded(
                child: HtmlWidget(
                  '${widget.mcqModel.question}',
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          (widget.mcqModel.questionPhoto != null)
              ? Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.mcqModel.questionPhoto,
                    ),
                  ),
                )
              : const Offstage(),
          _OptionsBuilder(
              mcqModel: widget.mcqModel,
              examMode: widget.examMode,
              onOptionSelected: () {
                setState(() {
                  _isAnswered = true;
                });
              }),
        ],
      ),
    );
  }
}

class _OptionsBuilder extends StatefulWidget {
  const _OptionsBuilder({
    required this.mcqModel,
    required this.examMode,
    required this.onOptionSelected,
  });

  final ExamMcqModel mcqModel;
  final String examMode;
  final Function() onOptionSelected;

  @override
  State<_OptionsBuilder> createState() => _OptionsBuilderState();
}

class _OptionsBuilderState extends State<_OptionsBuilder> {
  late ExamMcqModel mcqModel;
  late SubmitExamAnswerModel selectedOptionModel;

  int _selectedOptionIndex = -1;
  bool _isLocked = false;

  void updateSelectedOption(index) {
    _isLocked = true;
    _selectedOptionIndex = index;
    String selectedOption = mcqModel.options[index];

    selectedOptionModel = SubmitExamAnswerModel(
      mcqId: mcqModel.id,
      userAnswer: selectedOption,
    );

    Get.find<ExamViewController>()
        .updateSelectedAnswerList(selectedOptionModel);

    widget.onOptionSelected();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mcqModel = widget.mcqModel;

    return ListView.builder(
      itemCount: mcqModel.options.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: ((context, index) {
        return AbsorbPointer(
          absorbing: _isLocked,
          child: _Option(
            index: index,
            onTap: updateSelectedOption,
            isSelected: index == _selectedOptionIndex,
            isCorrect: mcqModel.options[index] == mcqModel.answer,
            optionText: mcqModel.options[index],
            isLocked: _isLocked,
            examMode: widget.examMode,
          ),
        );
      }),
    );
  }
}

class _Option extends StatefulWidget {
  const _Option({
    required this.index,
    required this.isCorrect,
    required this.isLocked,
    required this.onTap,
    required this.examMode,
    this.isSelected = false,
    this.optionText,
  });

  final int index;
  final bool isSelected;
  final bool isLocked;
  final bool isCorrect;
  final String? optionText;
  final Function(int) onTap;
  final String examMode;

  @override
  State<_Option> createState() => _OptionState();
}

class _OptionState extends State<_Option> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.index);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: widget.index < 3 ? 10 : 0),
        decoration: _optionDecorator(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${widget.index + 1}. ${widget.optionText}',
                  style: AppTextStyle.semibold14.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 21 / 14,
                  ),
                ),
              ),
              getIcon(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _optionDecorator() {
    return BoxDecoration(
      color: getColor(),
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: getBorderColor()),
    );
  }

  Color getColor() {
    if (widget.isLocked) {
      if (widget.examMode == ExamType.practice.name) {
        if (widget.isCorrect) {
          return AppColors.green25;
        } else if (widget.isSelected && !widget.isCorrect) {
          return AppColors.red25;
        } else {
          return AppColors.white;
        }
      } else {
        if (widget.isSelected) {
          return AppColors.lighterBlue;
        }
        return AppColors.white;
      }
    } else {
      return AppColors.white;
    }
  }

  Color getBorderColor() {
    if (widget.isLocked) {
      if (widget.examMode == ExamType.practice.name) {
        if (widget.isCorrect) {
          return AppColors.lightGrey25;
        } else if (widget.isSelected && !widget.isCorrect) {
          return AppColors.red80;
        } else {
          return AppColors.grey.withOpacity(.10);
        }
      } else {
        if (widget.isSelected) {
          return AppColors.primary;
        } else {
          return AppColors.grey.withOpacity(.10);
        }
      }
    } else {
      return AppColors.lightGrey25;
    }
  }

  Widget getIcon() {
    if (widget.isLocked) {
      if (widget.examMode == ExamType.practice.name) {
        if (widget.isCorrect && widget.isSelected) {
          return const Icon(
            Icons.check_circle,
            color: AppColors.lightGreen,
          );
        } else if (widget.isSelected && !widget.isCorrect) {
          return const Icon(
            Icons.cancel_rounded,
            color: AppColors.red80,
          );
        } else {
          return const SizedBox();
        }
      }
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }
}
