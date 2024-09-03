import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';

class OutlinedInputField extends StatefulWidget {
  const OutlinedInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.isPasswordField = false,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.fillColor,
    this.bottomPadding,
    this.showBorder = false,
    this.height,
    this.borderColor,
    this.readOnly = false,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPasswordField;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final double? bottomPadding;
  final bool? showBorder;
  final double? height;
  final Color? borderColor;
  final bool? readOnly;
  final bool? isEnabled;

  @override
  State<OutlinedInputField> createState() => _OutlinedInputFieldState();
}

class _OutlinedInputFieldState extends State<OutlinedInputField> {
  bool showPassword = false;
  String? errorMessage;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding ?? 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.maxLines! == 1 ? (widget.height ?? 41) : null,
            width: double.infinity,
            child: TextFormField(
              readOnly: widget.readOnly!,
              textAlign: TextAlign.left,
              enabled: widget.isEnabled,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              textAlignVertical: TextAlignVertical.center,
              controller: widget.controller,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              style: AppTextStyle.regular15.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlack80,
              ),
              obscureText: widget.isPasswordField ? !showPassword : false,
              decoration: InputDecoration(
                disabledBorder: widget.isEnabled == false
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: AppColors.lightGrey40,
                        ),
                      )
                    : null,
                enabledBorder: widget.showBorder == false
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.transparent,
                        ),
                      )
                    : Theme.of(context)
                        .inputDecorationTheme
                        .enabledBorder
                        ?.copyWith(
                          borderSide: BorderSide(
                            color: widget.borderColor ?? AppColors.primary,
                            width: 0.5,
                          ),
                        ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: widget.showBorder == false
                        ? Colors.transparent
                        : AppColors.primary,
                  ),
                ),
                filled: true,
                fillColor: widget.isEnabled == false
                    ? AppColors.grey100
                    : widget.fillColor ?? const Color(0xFFe6f2ec),
                prefixIcon: widget.prefix,
                suffixIcon:
                    widget.isPasswordField ? _passwordSuffix() : widget.suffix,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                isDense: true,
                hintText: widget.hintText,
                hintStyle: AppTextStyle.regular15.copyWith(
                  color: AppColors.lightBlack40,
                ),
              ),
              inputFormatters: widget.inputFormatters,
              onChanged: (v) {
                if (showError) {
                  setState(() => showError = false);
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(v);
                }
              },
              validator: (v) {
                if (widget.validator != null) {
                  errorMessage = widget.validator!(v);
                  setState(() => showError = true);
                  return errorMessage;
                }
                return null;
              },
            ),
          ),
          if (showError && errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 5,
              ),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            )
        ],
      ),
    );
  }

  IconButton _passwordSuffix() {
    return IconButton(
      onPressed: () {
        setState(() {
          showPassword = !showPassword;
        });
      },
      icon: Icon(
        !showPassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: AppColors.primary,
        size: 20,
      ),
    );
  }
}
