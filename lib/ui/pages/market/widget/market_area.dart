import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';

class MarketAreaView extends StatelessWidget {
  MarketAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<MarketLogic>().state;
    return Obx(
      () {
        var data = state.listStockBranch;
        return data.length > 0
            ? Container(
                height: 600,
                color: AppColors.background,
                child: SfTreemap(
                  dataCount: data.length,
                  weightValueMapper: (int index) {
                    return data[index].kLGD?.toDouble() ?? 0.0;
                  },
                  levels: <TreemapLevel>[
                    TreemapLevel(
                      groupMapper: (int index) => data[index].iNDUSTRY,
                      color: AppColors.background,
                      colorValueMapper: (tile) => AppColors.background,
                      //_source[tile.indices[0]].vacancy % 20 != 0 ? Colors.red : Colors.greenAccent,
                      labelBuilder: (BuildContext context, TreemapTile tile) {
                        return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${tile.group}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.H8Bold.copyWith(
                                  color: Colors.white),
                            ));
                      },
                    ),
                    TreemapLevel(
                      groupMapper: (int index) => data[index].sTOCKCODE,
                      // chỉnh màu
                      colorValueMapper: (tile) => data[tile.indices[0]].color,
                      labelBuilder: (BuildContext context, TreemapTile tile) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${tile.group}\n${data[tile.indices[0]].pERCENTCHANGE ?? 0.0}%',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.H8Bold.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ))
            : Container();
      },
    );
  }
}
