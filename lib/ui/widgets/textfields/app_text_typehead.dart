import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import '../../../common/app_text_styles.dart';
import '../../../model/order_data/inday_order.dart';
import '../../../model/stock_company_data/stock_company_data.dart';

class AppTextTypeHead<T> extends StatefulWidget {
  final TextEditingController? inputController;
  final String? label;
  final String? hintText;
  final FocusNode? focusNode;
  final SuggestionsCallback<T> suggestionsCallback;
  final SuggestionSelectionCallback<T> onSuggestionSelected;

  const AppTextTypeHead(
      {Key? key,
      this.inputController,
      this.label,
      this.hintText,
      required this.suggestionsCallback,
      required this.onSuggestionSelected,
      this.focusNode})
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
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset(
                AppImages.search_normal,
                color: AppColors.gray7E,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 24),
          )),
      noItemsFoundBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Chúng khoán không hợp lệ',
            textAlign: TextAlign.center,
            style: AppTextStyle.caption,
          ),
        );
      },
    );
  }
}
