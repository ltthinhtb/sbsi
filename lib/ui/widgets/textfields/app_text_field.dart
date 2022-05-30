import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/common/app_text_styles.dart';

class AppTextFieldWidget extends StatefulWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final String? label;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool autoFocus;
  final SvgPicture? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool? enableBorder;
  final Widget? suffixIcon;
  final bool? isShowLabel;
  final String? errorText;
  final bool? filled;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final bool? enable;
  final bool? isShowLabelText;

  const AppTextFieldWidget(
      {this.inputController,
      this.onChanged,
      this.textInputType,
      this.label,
      this.hintTextStyle,
      this.hintText,
      this.validator,
      this.obscureText = false,
      this.onFieldSubmitted,
      this.focusNode,
      this.autoFocus = false,
      this.prefixIcon,
      this.maxLength,
      this.readOnly = false,
      this.onTap,
      this.maxLines,
      this.enableBorder,
      this.suffixIcon,
      this.isShowLabel = true,
      this.errorText,
      this.filled,
      this.fillColor,
      this.border,
      this.focusBorder,
      this.enable = true,
      this.isShowLabelText = true});

  @override
  State<AppTextFieldWidget> createState() => _AppTextFieldWidgetState();
}

class _AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    } else {
      _focusNode = widget.focusNode!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.label != null && (widget.isShowLabel ?? true),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            )),
        TextFormField(
          enabled: widget.enable,
          readOnly: widget.readOnly,
          autofocus: widget.autoFocus,
          focusNode: _focusNode,
          controller: widget.inputController,
          obscureText: _obscureText,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          style: AppTextStyle.bodyText2.copyWith(color: AppColors.textBlack),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          decoration: InputDecoration(
            filled: widget.filled,
            fillColor: widget.fillColor,
            errorText: widget.errorText,
            labelText: (widget.isShowLabelText ?? true) ? widget.label : null,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle,
            border: widget.border,
            focusedBorder: widget.focusBorder,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            prefixIconConstraints: const BoxConstraints(maxHeight: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: widget.prefixIcon,
            ),
            counterText: "",
            suffixIconConstraints: const BoxConstraints(maxHeight: 24),
            enabledBorder: widget.enableBorder == null
                ? null
                : (!widget.enableBorder!
                    ? Theme.of(context).inputDecorationTheme.enabledBorder
                    : Theme.of(context)
                        .inputDecorationTheme
                        .enabledBorder
                        ?.copyWith(
                            borderSide: BorderSide(
                                color: AppColors.textBlack.withOpacity(0.5)))),
            suffixIcon: widget.suffixIcon ??
                (widget.obscureText
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                            _focusNode.unfocus();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(_obscureText
                              ? AppImages.eye_lock
                              : AppImages.eye),
                        ),
                      )
                    : null),
          ),
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}
