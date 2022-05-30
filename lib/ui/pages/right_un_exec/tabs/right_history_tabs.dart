import 'package:flutter/material.dart';

class RightHistoryTab extends StatefulWidget {
  const RightHistoryTab({Key? key}) : super(key: key);

  @override
  State<RightHistoryTab> createState() => _RightHistoryTabState();
}

class _RightHistoryTabState extends State<RightHistoryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
