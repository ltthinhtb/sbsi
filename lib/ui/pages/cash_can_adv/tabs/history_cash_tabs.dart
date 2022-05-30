import 'package:flutter/material.dart';

class HistoryCashTab extends StatefulWidget {
  const HistoryCashTab({Key? key}) : super(key: key);

  @override
  State<HistoryCashTab> createState() => _HistoryCashTabState();
}

class _HistoryCashTabState extends State<HistoryCashTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
