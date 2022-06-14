import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/model/entities/order_history.dart';
import '../../../common/app_text_styles.dart';
import '../../../model/entities/bank.dart';
import '../../../model/order_data/inday_order.dart';
import '../../../model/stock_company_data/stock_company_data.dart';

class AppTextTypeHead<T> extends StatefulWidget {
  final TextEditingController? inputController;
  final String? label;
  final String? hintText;
  final FocusNode? focusNode;
  final SuggestionsCallback<T> suggestionsCallback;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final String? errorText;
  final Widget? suffixIcon;

  const AppTextTypeHead(
      {Key? key,
      this.inputController,
      this.label,
      this.hintText,
      required this.suggestionsCallback,
      required this.onSuggestionSelected,
      this.focusNode,
      this.errorText,
      this.suffixIcon})
      : super(key: key);

  @override
  State<AppTextTypeHead> createState() => _AppTextTypeHeadState<T>();
}

class _AppTextTypeHeadState<T> extends State<AppTextTypeHead<T>> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: (BuildContext context, itemData) {
        if (itemData is StockCompanyData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('${itemData.stockCode}'),
                const SizedBox(width: 5),
                Flexible(child: Text('${itemData.nameVn}')),
              ],
            ),
          );
        }
        if (itemData is IndayOrder) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('${itemData.symbol}'),
              ],
            ),
          );
        }
        if (itemData is OrderHistory) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('${itemData.cSHARECODE}'),
              ],
            ),
          );
        }
        if (itemData is String) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(itemData),
              ],
            ),
          );
        }
        if (itemData is Bank) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FadeInImage(
                  image: AssetImage(itemData.logo ?? ""),
                  placeholder: AssetImage(itemData.logo ?? ""),
                  width: 30,
                  height: 30,
                  imageErrorBuilder: (_, __, ___) {
                    return SvgPicture.asset(
                      AppImages.bank_icon,
                      height: 30,
                      width: 30,
                    );
                  },
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    '${itemData.cBANKCODE} - ${itemData.cBANKNAME}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
      onSuggestionSelected: widget.onSuggestionSelected,
      textFieldConfiguration: TextFieldConfiguration(
          controller: widget.inputController,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            isDense: true,
            labelText: widget.label,
            hintText: widget.hintText,
            errorText: widget.errorText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: widget.suffixIcon ??
                  SvgPicture.asset(
                    AppImages.search_normal,
                    color: AppColors.gray7E,
                  ),
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 24),
          )),
      noItemsFoundBuilder: (context) {
        var errorText = "Chúng khoán không hợp lệ";
        if (T is Bank) errorText = "Ngân hàng không hợp lệ";
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            errorText,
            textAlign: TextAlign.center,
            style: AppTextStyle.caption,
          ),
        );
      },
    );
  }
}
