import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_mcq_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MCQAnalysisCard extends StatefulWidget {
  const MCQAnalysisCard({
    super.key,
    required this.index,
    required this.mcqModel,
  });

  final int index;
  final ExamMcqModel mcqModel;

  @override
  State<MCQAnalysisCard> createState() => _MCQAnalysisCardState();
}

class _MCQAnalysisCardState extends State<MCQAnalysisCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
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
            ),
            if (!widget.mcqModel.isQuestionAnswered)
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Tooltip(
                  message: 'Question was not answered!',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.report_gmailerrorred_rounded,
                    color: AppColors.red80,
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
        ),
        ((widget.mcqModel.answerDescription != null &&
                    widget.mcqModel.answerDescription!.isNotEmpty) ||
                (widget.mcqModel.answerPhoto != null))
            ? Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  top: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Answer:',
                          style: AppTextStyle.bold14.copyWith(
                            fontSize: 13,
                            height: 0,
                            color: AppColors.lightBlack90,
                          ),
                        ),
                      ],
                    ),
                    (widget.mcqModel.answerDescription != null &&
                            widget.mcqModel.answerDescription!.isNotEmpty)
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: HtmlWidget(
                              '${widget.mcqModel.answerDescription}',
                            ),
                          )
                        : const Offstage(),
                    (widget.mcqModel.answerPhoto != null)
                        ? Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: widget.mcqModel.answerPhoto,
                              ),
                            ),
                          )
                        : const Offstage(),
                  ],
                ),
              )
            : const Offstage(),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _OptionsBuilder extends StatefulWidget {
  const _OptionsBuilder({
    required this.mcqModel,
  });

  final ExamMcqModel mcqModel;

  @override
  State<_OptionsBuilder> createState() => _OptionsBuilderState();
}

class _OptionsBuilderState extends State<_OptionsBuilder> {
  @override
  Widget build(BuildContext context) {
    ExamMcqModel mcqModel = widget.mcqModel;
    return ListView.builder(
      itemCount: widget.mcqModel.options.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: ((context, index) {
        return AbsorbPointer(
          absorbing: true,
          child: _Option(
            index: index,
            isSelected: mcqModel.options[index] == mcqModel.userAnswer,
            isCorrect: mcqModel.options[index] == mcqModel.answer,
            optionText: mcqModel.options[index],
            isLocked: true,
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
    this.isSelected = false,
    this.optionText,
  });

  final int index;
  final bool isSelected;
  final bool isLocked;
  final bool isCorrect;
  final String? optionText;

  @override
  State<_Option> createState() => _OptionState();
}

class _OptionState extends State<_Option> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      if (widget.isCorrect) {
        return AppColors.green25;
      } else if (widget.isSelected && !widget.isCorrect) {
        return AppColors.red25;
      } else {
        return AppColors.lightBlack10;
      }
    } else {
      return AppColors.white;
    }
  }

  Color getBorderColor() {
    if (widget.isLocked) {
      if (widget.isCorrect) {
        return AppColors.lightGrey25;
      } else if (widget.isSelected && !widget.isCorrect) {
        return AppColors.red80;
      } else {
        return AppColors.grey.withOpacity(.10);
      }
    } else {
      return AppColors.lightGrey25;
    }
  }

  Widget getIcon() {
    if (widget.isLocked) {
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
    } else {
      return const SizedBox();
    }
  }
}
