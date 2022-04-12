import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/widgets/dropdown/custom_dropdown.dart';

class DropdownWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool isExpanded;

  const DropdownWidget(
      {Key? key,
      required this.items,
      this.value,
      this.hintText,
      this.onChanged,
      this.label,
      this.isExpanded = false})
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
        items.isEmpty
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              )
            : DropdownButtonHideUnderline(
                child: CustomDropdownButton<T>(
                  isExpanded: isExpanded,
                  isDense: false,
                  // dropdownOverButton: true,
                  alignment: Alignment.centerLeft,
                  buttonPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  // customButton: MaterialButton(
                  //   onPressed: () {},
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   shape: const RoundedRectangleBorder(
                  //     side: BorderSide(),
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  buttonDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  value: value,
                  onChanged: onChanged,
                  style: Theme.of(context).textTheme.headline6,
                  icon: SvgPicture.asset(AppImages.chevron_down),
                  items: items,
                ),
              ),
      ],
    );
  }
}
