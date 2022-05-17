import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class AnalyticTab extends StatefulWidget {
  const AnalyticTab({Key? key}) : super(key: key);

  @override
  State<AnalyticTab> createState() => _AnalyticTabState();
}

class _AnalyticTabState extends State<AnalyticTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.PastelSecond2,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,-0.5),
                  blurRadius: 8,
                  color: Color.fromRGBO(0, 0, 0, 0.03)
                ),
                BoxShadow(
                    offset: Offset(0,-1),
                    blurRadius: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.04)
                )
              ]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Theo giờ"
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
