import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';

import '../../../widgets/textfields/app_text_typehead.dart';

class StockCashBalance extends StatelessWidget {
  const StockCashBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Get.find<StockOrderLogic>().state;
    var logic = Get.find<StockOrderLogic>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration:
          const BoxDecoration(color: AppColors.PastelSecond2, boxShadow: [
        const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 4),
        const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 20)
      ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 20),
            child: AppTextTypeHead<StockCompanyData>(
              key: state.searchCKKey,
              inputController: state.stockController,
              focusNode: state.stockNode,
              suggestionsCallback: (String pattern) {
                return logic.searchStock(pattern);
              },
              onSuggestionSelected: (suggestion) {
                return logic.selectStock(suggestion);
              },
            ),
          )
        ],
      ),
    );
  }
}
