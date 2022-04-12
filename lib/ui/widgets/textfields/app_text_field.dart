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
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextFieldWidget({
    this.inputController,
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
  });

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Visibility(
        //     visible: widget.label != null,
        //     child: Padding(
        //       padding: const EdgeInsets.only(bottom: 5),
        //       child: Text(
        //         widget.label ?? "",
        //         style: Theme.of(context)
        //             .textTheme
        //             .headline6!
        //             .copyWith(fontWeight: FontWeight.w700),
        //       ),
        //     )),
        TextFormField(
          readOnly: widget.readOnly,
          autofocus: widget.autoFocus,
          focusNode: _focusNode,
          controller: widget.inputController,
          obscureText: _obscureText,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          style: AppTextStyle.bodyText2.copyWith(
            color: AppColors.textBlack
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            prefixIconConstraints: const BoxConstraints(maxHeight: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: widget.prefixIcon,
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 24),
            suffixIcon: widget.obscureText
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
                      child: SvgPicture.asset(
                          _obscureText ? AppImages.eye_lock : AppImages.eye),
                    ),
                  )
                : null,
          ),
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}


