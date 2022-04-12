import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/ui/pages/search/search_view.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';

class StockOrderAppbar extends StatefulWidget implements PreferredSizeWidget {
  const StockOrderAppbar(
      {Key? key, required this.onLeadingPress, required this.onSelectStockCode})
      : super(key: key);
  final Function() onLeadingPress;
  final ValueChanged<StockCompanyData?>? onSelectStockCode;

  @override
  _StockOrderAppbarState createState() => _StockOrderAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StockOrderAppbarState extends State<StockOrderAppbar> {
  final logic = Get.find<StockOrderLogic>();
  final state = Get.find<StockOrderLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      // foregroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 15,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: Material(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                side: BorderSide.none,
              ),
              color: Theme.of(context).buttonTheme.colorScheme!.primary,
              child: RawMaterialButton(
                onPressed: widget.onLeadingPress,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  side: BorderSide.none,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                ),
              ),
            ),
          ),
          Container(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: MaterialButton(
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                side: BorderSide.none,
              ),
              color: Theme.of(context).buttonTheme.colorScheme!.primary,
              onPressed: () async {
                StockCompanyData? result = await Get.to(const SearchPage(),
                    transition: Transition.noTransition);
                widget.onSelectStockCode?.call(result);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(AppImages.search_normal),
                  ),
                  Text(S.of(context).search +"sad"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
