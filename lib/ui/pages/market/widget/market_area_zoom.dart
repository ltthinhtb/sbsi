import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';

class MarketAreaZoomPage extends StatefulWidget {
  const MarketAreaZoomPage({Key? key}) : super(key: key);

  @override
  State<MarketAreaZoomPage> createState() => _MarketAreaZoomPageState();
}

class _MarketAreaZoomPageState extends State<MarketAreaZoomPage> {
  final logic = Get.put(MarketLogic());
  final state = Get.find<MarketLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(title: 'MarketAreaZoomPage',),
        backgroundColor: AppColors.background,
        body: InteractiveViewer(
          minScale: 0.5,
          maxScale: 10,
          child: Obx(
            () {
              var data = state.listStockBranch;
              return data.length > 0
                  ? SfTreemap(
                      dataCount: data.length,
                      weightValueMapper: (int index) {
                        return data[index].vHTT?.toDouble() ?? 0.0;
                      },
                      enableDrilldown: true,
                      breadcrumbs: TreemapBreadcrumbs(
                        builder: (BuildContext context, TreemapTile tile,
                            bool isCurrent) {
                          return Text(tile.group,
                              style: const TextStyle(color: Colors.black));
                        },
                      ),
                      levels: <TreemapLevel>[
                        TreemapLevel(
                          groupMapper: (int index) => data[index].iNDUSTRY,
                          color: Colors.blueAccent,
                          colorValueMapper: (tile) => Colors.blue,
                          //_source[tile.indices[0]].vacancy % 20 != 0 ? Colors.red : Colors.greenAccent,
                          labelBuilder:
                              (BuildContext context, TreemapTile tile) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                tile.group,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                        TreemapLevel(
                          groupMapper: (int index) => data[index].sTOCKCODE,
                          // chỉnh màu
                          colorValueMapper: (tile) =>
                              data[tile.indices[0]].pERCENTCHANGE! >= 0
                                  ? AppColors.increase
                                  : AppColors.decrease,
                          labelBuilder:
                              (BuildContext context, TreemapTile tile) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${tile.group}\n${data[tile.indices[0]].pERCENTCHANGE ?? 0.0}%',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.H6.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ));
  }
}
