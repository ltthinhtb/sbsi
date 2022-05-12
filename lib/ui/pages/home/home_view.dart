import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/home/widget/appbar.dart';
import 'package:sbsi/ui/pages/utilities/utilities_view.dart';
import 'home_logic.dart';
import 'widget/banner.dart';
import 'widget/card_icon.dart';
import 'widget/list_stock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: state.key,
      drawer: const UtilitiesPage(),
      body: Column(
        children: [
          const AppBarHome(
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BannerHome(),
                  const SizedBox(height: 16),
                  const CardIcon(),
                  const SizedBox(height: 16),
                  const ListStockView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
