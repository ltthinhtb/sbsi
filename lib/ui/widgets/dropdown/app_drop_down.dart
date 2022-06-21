import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';


typedef DropdownButtonBuilder = List<Widget> Function(BuildContext context);

class AppDropDownWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool isExpanded;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Color? iconDisabledColor ;

  const AppDropDownWidget(
      {Key? key,
      required this.items,
      this.value,
      this.hintText,
      this.onChanged,
      this.label,
      this.isExpanded = false, this.selectedItemBuilder, this.iconDisabledColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: label != null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            )),
        DropdownButtonHideUnderline(

          child: DropdownButtonFormField(
            alignment: Alignment.bottomCenter,
            isDense: true,
            value: value,
            onChanged: onChanged,
            isExpanded: isExpanded,
            iconDisabledColor: iconDisabledColor,
            selectedItemBuilder: selectedItemBuilder,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            style: Theme.of(context).textTheme.subtitle2,
            icon: SvgPicture.asset(AppImages.chevron_down,
                color: onChanged != null
                    ? AppColors.black
                    : const Color.fromRGBO(177, 177, 177, 1)),
            items: items,
          ),
        ),
      ],
    );
  }
}
