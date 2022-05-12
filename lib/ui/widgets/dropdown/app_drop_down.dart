import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_images.dart';

class AppDropDownWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final String? label;

  const AppDropDownWidget(
      {Key? key,
      required this.items,
      this.value,
      this.hintText,
      this.onChanged,
      this.label})
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
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            )),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            alignment: Alignment.bottomCenter,
            isDense: true,
            value: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            ),
            style: Theme.of(context).textTheme.subtitle2,
            icon: SvgPicture.asset(AppImages.chevron_down),
            items: items,
          ),
        ),
      ],
    );
  }
}
