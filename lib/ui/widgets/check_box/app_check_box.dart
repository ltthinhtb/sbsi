import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class AppCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AppCheckBox({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  Color _getColorCheckBox(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      print(states);
      return AppColors.colorMain;
    }
    return AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _value,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        checkColor: Colors.white,
        fillColor: MaterialStateColor.resolveWith(_getColorCheckBox),
        tristate: false,
        onChanged: (value) {
          setState(() {
            _value = !_value;
            widget.onChanged.call(value);
          });
        });
  }
}
