import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_images.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenter;
  final List<Widget>? action;
  final bool automaticallyImplyLeading;

  const AppBarCustom(
      {Key? key,
      required this.title,
      this.isCenter = false,
      this.action,
      this.automaticallyImplyLeading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: SvgPicture.asset(
        AppImages.appbar,
        fit: BoxFit.cover,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title),
      centerTitle: isCenter,
      actions: action,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
