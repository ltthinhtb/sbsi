import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_images.dart';
import '../../../common/app_colors.dart';

class AppTextFieldNumber extends StatefulWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final VoidCallback? minus;
  final VoidCallback? plus;
  final Color? backColor;

  const AppTextFieldNumber(
      {Key? key,
      this.inputController,
      this.onChanged,
      this.focusNode,
      this.label,
      this.hintText,
      this.minus,
      this.plus,
      this.backColor})
      : super(key: key);

  @override
  State<AppTextFieldNumber> createState() => _AppTextFieldNumberState();
}

class _AppTextFieldNumberState extends State<AppTextFieldNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: widget.backColor, boxShadow: [
        const BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4)),
      ]),
      child: TextFormField(
        controller: widget.inputController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [CommaTextInputFormatter()],
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            fillColor: widget.backColor ?? AppColors.white,
            filled: true,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 33, maxWidth: 41),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 33, maxWidth: 41),
            prefixIcon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.minus,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 4),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 20),
                ]),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(AppImages.minusSmall),
              ),
            ),
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.plus,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 4),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 20),
                ]),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(AppImages.plusSmall),
              ),
            )),
      ),
    );
  }
}

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(",")) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}
